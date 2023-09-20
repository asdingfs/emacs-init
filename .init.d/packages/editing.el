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
(use-package hideshow
  :config
  (defun toggle-selective-display (column)
      (interactive "P")
      (set-selective-display
       (or column
           (unless selective-display
             (1+ (current-column))))))
  (defun toggle-hiding (column)
      (interactive "P")
      (if hs-minor-mode
          (if (condition-case nil
                  (hs-toggle-hiding)
                (error t))
              (hs-show-all))
        (toggle-selective-display column)))
  (add-hook 'prog-mode-hook (lambda () (hs-minor-mode t)))
  :bind
  ("C-c h t" . 'toggle-hiding)
  ("C-c h d" . 'toggle-selective-display)
  ("C-c h h" . 'hs-hide-block)
  ("C-c h s" . 'hs-show-block)
  ("C-c h H" . 'hs-hide-all)
  ("C-c h S" . 'hs-show-all)
  )

;; code completions
(use-package company
  :diminish company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package flycheck-flow
  :config
  (flycheck-add-mode 'javascript-flow 'flow-minor-mode)
  (flycheck-add-mode 'javascript-eslint 'flow-minor-mode)
  (flycheck-add-next-checker 'javascript-flow 'javascript-eslint))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically
   (quote (save idle-change mode-enable)))
  (setq flycheck-idle-change-delay 4)
  (setq flycheck-idle-buffer-switch-delay 4)
  (add-hook 'js2-mode-hook #'flycheck-mode))

;; for highlighting indentations with lines
(use-package highlight-indent-guides
  :init
  ;; disable autoload of highlight-indent-guides-mode as it's very laggy for some reason
  ;; will enable manually if a workaround for font-lock is found
  ;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'character)
  :config
  (setq highlight-indent-guides-responsive (quote top))
  (setq highlight-indent-guides-delay 1)
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


;; configuration guide: https://www.emacswiki.org/emacs/Edit_with_Emacs
(use-package edit-server
  :ensure t
  :config
  (setq edit-server-new-frame nil)
  (edit-server-start))

(use-package writeroom-mode
  :init
  (add-hook 'writeroom-mode-hook #'(lambda () (text-scale-100%) (text-scale-increase 2)))
  :custom
  (writeroom-width 64))
