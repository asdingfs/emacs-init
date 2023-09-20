;; main org configurations
(use-package org
  :commands (ox-md ox-twbs ox-pandoc htmlize)
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   ("C-c l" . org-store-link)
   :map org-mode-map
   ("C-S-c C-S-w" . org-refile-within-current-buffer)
   ("C-c C-w" . org-refile-to-all-defined-org-files)
   ("C-c C-j" . counsel-org-goto)
   ("C-c C-q" . counsel-org-tag)
   ("H-M-'"  . org-metaright)
   ("H-M-;"  . org-metaleft)
   ("H-M-["  . org-metaup)
   ("H-M-/"  . org-metadown)
   ("H-M-\"" . org-shiftmetaright)
   ("H-M-:"  . org-shiftmetaleft)
   ("H-M-?"  . org-shiftmetadown)
   ("H-M-{"  . org-shiftmetaup)
   ("H-C-\"" . org-shiftcontrolright)
   ("H-C-:"  . org-shiftcontrolleft)
   ("H-C-?"  . org-shiftcontroldown)
   ("H-C-{"  . org-shiftcontrolup))
  :init
  (add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
  (add-hook 'org-mode-hook (lambda () (org-cycle-hide-drawers 'all)))
  (add-hook 'org-mode-hook (lambda () (org-indent-mode 't)))
  (add-hook 'org-mode-hook (lambda () (visual-line-mode 't)))
  (add-hook 'org-mode-hook (lambda () (setq line-spacing 0.15)))
  :config
  ;; general
  (org-all-files-refresh)
  (org-agenda-files-refresh)
  (setq org-pretty-entities 't)
  (setq org-hide-leading-stars 't)
  (setq org-ellipsis "⤵")
  (let* ((serif-font-family '(:family "Baskerville"))
         (sans-serif-font-family '(:family "Avenir" :weight regular))
         (monospaced-font-family '(:family "Iosevka Term"))
         (variable-tuple `(,@sans-serif-font-family))
         (headline `(,@monospaced-font-family)))
    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@headline ,@variable-tuple :height 1 :foreground "bisque3"))))
     `(org-level-7 ((t (,@headline ,@variable-tuple :height 1 :foreground "bisque3"))))
     `(org-level-6 ((t (,@headline ,@variable-tuple :height 1))))
     `(org-level-5 ((t (,@headline ,@variable-tuple :height 1.1))))
     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.2))))
     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.3))))
     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.4))))
     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.5))))
     `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :weight medium))))
     ))
  (set-face-attribute 'default nil :family "Iosevka Term")
  (set-face-attribute 'fixed-pitch nil :family "Iosevka Term")
  (set-face-attribute 'variable-pitch nil :family "Avenir")
  (custom-theme-set-faces
   'user
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))
  (setq org-cycle-level-faces nil)
  (setq org-cycle-hide-drawer-startup nil)
  (setq org-hide-emphasis-markers t) ;; show content only
  (setq org-startup-with-inline-images t)
  (setq org-image-actual-width '(300)) ;; restrict image display to display size
  (setq org-log-done t)
  (setq org-goto-auto-isearch nil)
  (setq org-imenu-depth 3)
  (setq org-src-window-setup 'current-window)
  (add-hook 'focus-out-hook (lambda () (org-save-all-org-buffers)))
  (setq org-directory "~/.emacs.d/.personal.d/org/notes")
  ;; attachments
  (setq org-file-apps (quote ((auto-mode . emacs)
                              ("\\.mm\\'" . default)
                              ("\\.x?html?\\'" . default)
                              ("\\.pdf\\'" . default)
                              ("\\.xls\\'" . default)
                              ("\\.xlsx\\'" . default))))
  ;; capture
  (setq org-default-notes-file "~/.emacs.d/.personal.d/org/notes/capture.org")
  (setq org-capture-templates
        (quote (
                ("t" "Task" entry
                 (file+headline "" "Tasks")
                 "* TODO %?\n  %u\n  %a")
                ("l" "Action Logs")
                ("ls" "Success Logs" entry
                 (file+olp+datetree "~/.emacs.d/.personal.d/org/notes/time-logging.org")
                 (file "~/.emacs.d/.personal.d/org/templates/time-logging-success.org")
                 :tree-type day
                 :unnarrowed t)
                ("lf" "Failure Logs" entry
                 (file+olp+datetree "~/.emacs.d/.personal.d/org/notes/time-logging.org")
                 (file "~/.emacs.d/.personal.d/org/templates/time-logging-failure.org")
                 :tree-type day
                 :unnarrowed t)
                ("j" "Journal")
                ;; collection of monk templates
                ("jm" "Monk Journalling Templates")
                ("jmd" "Daily Journal (Plan)" entry
                 (file+olp+datetree "~/.emacs.d/.personal.d/org/notes/monk-journal.org" "Entries")
                 (file "~/.emacs.d/.personal.d/org/templates/monk-journal-daily-plan.org")
                 :tree-type day
                 :jump-to-captured t
                 :unnarrowed t)
                ("jmf" "Daily Journal (Reflect)" entry
                 (file+olp+datetree "~/.emacs.d/.personal.d/org/notes/monk-journal.org" "Entries")
                 (file "~/.emacs.d/.personal.d/org/templates/monk-journal-daily-reflect.org")
                 :tree-type day
                 :jump-to-captured t
                 :unnarrowed t)
                ("jmw" "Weekly Journal (Plan)" entry
                 (file+olp-datetree "~/.emacs.d/.personal.d/org/notes/monk-journal.org" "Entries")
                 (file "~/.emacs.d/.personal.d/org/templates/monk-journal-weekly-plan.org")
                 :tree-type month
                 :jump-to-captured t
                 :unnarrowed t)
                ("jme" "Weekly Journal (Reflect)" entry
                 (file+olp+datetree "~/.emacs.d/.personal.d/org/notes/monk-journal.org" "Entries")
                 (file "~/.emacs.d/.personal.d/org/templates/monk-journal-weekly-reflect.org")
                 :tree-type month
                 :jump-to-captured t
                 :unnarrowed t)
                ("jmc" "Monthly Journal (Plan)" entry
                 (file+olp+datetree "~/.emacs.d/.personal.d/org/notes/monk-journal.org" "Entries")
                 (file "~/.emacs.d/.personal.d/org/templates/monk-journal-monthly-plan.org")
                 :tree-type month
                 :jump-to-captured t
                 :unnarrowed t)
                ("jmv" "Monthly Journal (Reflect)" entry
                 (file+olp+datetree "~/.emacs.d/.personal.d/org/notes/monk-journal.org" "Entries")
                 (file "~/.emacs.d/.personal.d/org/templates/monk-journal-monthly-reflect.org")
                 :tree-type month
                 :jump-to-captured t
                 :unnarrowed t)
                ("jmn" "Notes" entry
                 (file+olp+datetree "~/.emacs.d/.personal.d/org/notes/monk-journal.org" "Entries")
                 (file "~/.emacs.d/.personal.d/org/templates/monk-journal-notes.org")
                 :tree-type day
                 :unnarrowed t))))
  ;; refiling
  (setq org-refile-targets (quote ((nil :maxlevel . 5))))
  ;; refile includes full file name, for clarity
  (setq org-refile-use-outline-path (quote full-file-path))
  ;; confirm if creating a new parent node
  (setq org-refile-allow-creating-parent-nodes (quote confirm))
  ;; show all paths, for ivy autocomplete
  (setq org-outline-path-complete-in-steps nil)

  ;; export settings
  (setq org-export-in-background t)     ;; run exporting and publishing in background
  (setq org-export-async-debug t)       ;; by default, leave data behind
  (setq org-export-with-sub-superscripts nil)
  (setq org-export-backends '(ascii html icalendar latex odt md))
  ;; looks
  (setq org-indent-indentation-per-level 2) ;; set indentation level to 2 (avoid Iosevka Term's compactness)
  (setq org-adapt-indentation nil)
  (customize-set-variable 'org-blank-before-new-entry
                          '((heading . nil)
                            (plain-list-item.nil)))
  (setq org-cycle-separator-lines 1)
  (setq org-src-fontify-natively t)     ;; make source code block prettier
  (setq org-src-tab-acts-natively t)    ;; make tab works as if programming normally
  (setq org-src-preserve-indentation t) ;; preserve leading whitespace character in code blocks
  (setq org-edit-src-content-indentation nil) ;; this has no effect if org-src-preserve-indentation is non-nil
  (defface org-block-begin-line
    '((t (:background "#383838" :foreground "#7F9F7F")))
    "Face used for the line delimiting the begin of source blocks.")
  (defface org-block-background
    '((t (:background "#383838")))
    "Face used for the source block background.")
  (defface org-block-end-line
    '((t (:background "#383838" :foreground "#7F9F7F")))
    "Face used for the line delimiting the end of source blocks.")
  ;; todos
  (setq org-todo-keywords (quote ((sequence "INBOX(i)" "TODO(t)" "NEXT(n)" "|" "DONE(v)" "CLOSED(c)")
                                  (sequence "WAITING(w)" "|" "DEFER(d)")
                                  (sequence "|" "FAILED(f)"))))
  ;; tags
  (setq org-tag-alist (quote ((:startgroup)
                              ("@Context" . ?@)

                              (:startgrouptag)
                              ("@life" . ?l)
                              (:grouptags)
                              ("spiritual")
                              ("brainwork")
                              ("swpphotog")
                              ("ccsggchoir")
                              (:endgrouptag)

                              (:startgrouptag)
                              ("@people" . ?p)
                              (:grouptags)
                              ("followup")
                              ("reachout")
                              (:endgrouptag)

                              (:startgrouptag)
                              ("@home". ?h)
                              (:grouptags)
                              ("housework")
                              ("paperwork")
                              ("errands")
                              (:endgrouptag)

                              (:startgrouptag)
                              ("@projects" . ?w)
                              (:grouptags)
                              ("supaherovb")
                              ("brainvr")
                              ("risuto")
                              ("")
                              (:endgrouptag)

                              (:endgroup)))))

;; exporting
;; pretty html
(use-package ox-twbs)
;; source code to follow formatting in org-mode src blk
(use-package htmlize :after (org))
(use-package ox-pandoc
  :after (org exec-path-from-shell)
  :init
  (with-eval-after-load 'ox (require 'ox-pandoc))
  :config
  (setq org-pandoc-menu-entry
        '((106 "to json and open." org-pandoc-export-to-json-and-open)
          (74 "as json." org-pandoc-export-as-json)
          (108 "to latex-pdf and open." org-pandoc-export-to-latex-pdf-and-open)
          (76 "to latex-pdf." org-pandoc-export-to-latex-pdf)
          (109 "to man and open." org-pandoc-export-to-man-and-open)
          (77 "as man." org-pandoc-export-as-man)
          (111 "to odt and open." org-pandoc-export-to-odt-and-open)
          (79 "to odt." org-pandoc-export-to-odt)
          (112 "to pptx and open." org-pandoc-export-to-pptx-and-open)
          (80 "to pptx." org-pandoc-export-to-pptx)
          (120 "to docx and open." org-pandoc-export-to-docx-and-open)
          (88 "to docx." org-pandoc-export-to-docx)))
  :defer t)


;; display
(use-package org-superstar
  :after (org)
  :custom
  (org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "◇" "►" "➤" "▻" "*" "+" "~" "-" "•"))
  (org-superstar-cycle-headline-bullets nil)
  (org-superstar-leading-bullet ?\s)
  (org-superstar-lightweight-lists t)
  (org-superstar-prettify-item-bullets nil)
  (org-superstar-leading-bullet "")
  (set-face-attribute 'org-superstar-header-bullet nil :height 1.25)
  :config
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

(use-package org-modern
  :init
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
  :config
  (setq
   org-modern-checkbox nil
   org-modern-list nil
   org-modern-todo nil
   org-modern-tag nil
   org-modern-block-fringe 0))

(use-package org-download ;; drag and drop file into emacs buffer & upload as attachments
  :config
  (add-hook 'org-mode-hook 'org-download-enable)
  (add-hook 'dired-mode-hook 'org-download-enable))

;; other editing/export modes
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  :config
  (setq markdown-fontify-code-blocks-natively t)
  (set-face-attribute 'markdown-code-face nil :family "Inconsolata"))
(use-package markdown-preview-mode
  :defer t)

;; interface with pandoc
(use-package pandoc-mode
  :init
  (load "pandoc-mode")
  :config
  (add-hook 'markdown-mode-hook 'pandoc-mode)
  (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings))


;; second brain with org-roam
;; from https://github.com/org-roam/org-roam
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/.emacs.d/.personal.d/org/notes/brain/logseq-brain/")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   (quote (
           ;; default template
           ("d" "default" plain
            "%?"
            :target (file+head "pages/${slug}.org" "#+title: ${title}\n\n")
            :unnarrowed t))))
  (org-roam-dailies-directory "journals/")
  (org-roam-dailies-capture-templates
   (quote (
           ;; default template
           ("d" "default" entry "* [EMACS] %<%I:%M %p>:\n %?"
            :target (file+head "%<%Y_%m_%d>.org" "#+title: %<%Y-%m-%d>\n"))
           )))
  :bind (("C-c n c" . org-roam-capture)
         ("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n I" . org-roam-node-insert-immediate)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today)
         :map org-mode-map
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow)
         )
  :bind-keymap ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  (org-roam-setup)
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  ;; (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))

;; Bind this to C-c n I
(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))
