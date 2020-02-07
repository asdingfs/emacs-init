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
   ("H-M-{"  . org-shiftmetaup))
  :init
  (add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
  :config
  ;; general
  (org-all-files-refresh)
  (org-agenda-files-refresh)
  (setq org-hide-emphasis-markers t) ;; show content only
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
  (setq org-src-fontify-natively t)     ;; make source code block prettier
  (setq org-src-tab-acts-natively t)    ;; make tab works as if programming normally
  (defface org-block-begin-line
    '((t (:background "#383838" :foreground "#7F9F7F")))
    "Face used for the line delimiting the begin of source blocks.")
  (defface org-block-background
    '((t (:background "#383838")))
    "Face used for the source block background.")
  (defface org-block-end-line
    '((t (:background "#383838" :foreground "#7F9F7F")))
    "Face used for the line delimiting the end of source blocks."))

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
(use-package org-bullets ;; bullets
  :after (org)
  :init
  (setq org-bullets-bullet-list
        '("►" ">" "●" "○" "*" "+" "~" "-"
          "•" "•" "•" "•" "•" "•" "•" "•"))
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  :defer t)

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
