;; autopairs
;; deletion, movement, modification
;;    for deletions, if S is defined, force overwrite the sp-command (i.e. use the normal command)
;;    for movements, if S is defined, use reverse direction
(use-package smartparens
  :diminish smartparens-mode
  :bind (:map smartparens-mode-map
              ("C-M-k" . sp-kill-sexp)
              ("C-k" . sp-kill-hybrid-sexp)
              ("C-S-k" . sp-backward-kill-sexp)
              ("C-S-w" . sp-kill-region) 
              ("C-w" . kill-region) 
              ([remap sp-kill-region] . kill-region)
              ("C-<backspace>" . sp-backward-kill-word)
              ("M-<backspace>" . backward-kill-word)
              ([remap sp-backward-kill-word] . backward-kill-word)
              ("S-<backspace>" . sp-backward-delete-char)
              ("<backspace>" . backward-delete-char)
              ([remap sp-backward-delete-char] . backward-delete-char)
              ("C-S-<backspace>" . sp-kill-whole-line)
              ("C-M-S-<backspace>" . kill-whole-line)
              ([remap sp-kill-whole-line] . kill-whole-line)
              
              ("C-M-a" . sp-beginning-of-sexp)
              ("C-M-e" . sp-end-of-sexp)
              ("C-S-f" . sp-forward-symbol)
              ("C-M-f" . sp-forward-sexp)
              ("C-S-b" . sp-backward-symbol)
              ("C-M-b" . sp-backward-sexp)
              ("C-M-n" . sp-next-sexp)
              ("C-M-p" . sp-previous-sexp)
              ("C-S-u" . sp-backward-up-sexp)
              ("C-M-u" . sp-up-sexp)
              ("C-S-d" . sp-backward-down-sexp)
              ("C-M-d" . sp-down-sexp)

              ("C-M-t" . sp-transpose-sexp)
              ("M-[" . sp-backward-unwrap-sexp)
              ("M-]" . sp-unwrap-sexp)
              ("C-)" . sp-forward-slurp-sexp)
              ("C-}" . sp-forward-barf-sexp)
              ("C-(" . sp-backward-slurp-sexp)
              ("C-{" . sp-backward-barf-sexp))
  :init
  (add-hook 'prog-mode-hook #'smartparens-mode)
  (add-hook 'org-mode-hook #'smartparens-mode)
  (add-hook 'markdown-mode-hook #'smartparens-mode)
  :config
  (require 'smartparens-config)
  (show-smartparens-global-mode t))

;; selections
(use-package expand-region
  :bind
  (("C-=" . er/expand-region)))

(use-package multiple-cursors
  :bind
  (("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)
   ("C-S-c C-S-c" . mc/edit-lines)
   ("C-S-<mouse-1>" . mc/add-cursor-on-click)))

;; code folding
(use-package origami
  :init
  (add-hook 'prog-mode-hook (lambda () (origami-mode 1)))
  :bind
  (("C-c h a" . origami-open-all-nodes)
   ("C-c h h" . origami-toggle-node)
   :map origami-mode-map
   ("C-c h o" . origami-show-only-node)
   ("C-c h s" . origami-open-node-recursively)
   ("C-c h <tab>" . origami-recursively-toggle-node)
   ("C-c h /" . origami-undo)
   ("C-c h \\" . origami-redo)))

;; code completions
(use-package company
  :diminish company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; for highlighting indentations with lines
(use-package highlight-indent-guides
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'character)
  :config
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray"))

;; snippets
(use-package yasnippet
  :diminish yas-minor-mode
  :bind
  (("C-c i" . yas-insert-snippet)
   :map yas-minor-mode-map
   ("C-c e" . yas-expand))
  :init
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  :config
  (yas-global-mode 1)
  (yas-reload-all))

(use-package yasnippet-snippets)

(use-package react-snippets)

(use-package hippie-exp
  :bind
  (("M-/" . hippie-expand))
  :config
  (setq hippie-expand-try-functions-list
        '(yas-expand-snippet
          try-expand-dabbrev
          try-expand-dabbrev-all-buffers
          try-expand-dabbrev-from-kill
          try-complete-file-name-partially
          try-complete-file-name
          try-expand-all-abbrevs
          try-expand-list
          try-expand-line
          try-complete-lisp-symbol-partially
          try-complete-lisp-symbol)))

;; merge-tools
(use-package ediff)
(use-package smerge-mode
  :init
  (setq smerge-command-prefix (kbd "C-c v")))
