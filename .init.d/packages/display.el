;; show line number
(use-package nlinum-relative
  :config
  (add-hook 'prog-mode-hook 'nlinum-relative-mode)
  (setq nlinum-relative-redisplay-delay 0) ;; delay
  (setq nlinum-relative-current-symbol "->")) ;; or "" for display current line number

;; better mode-line
(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  (setq sml/name-width 40)
  (setq sml/mode-width 'full)
  (setq sml/modified-char "*")
  (setq sml/show-client t)
  (add-hook 'after-init-hook #'sml/setup))
