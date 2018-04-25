;; use zenburn theme
(use-package zenburn-theme
  :ensure t
  :init (load-theme 'zenburn t))
(add-to-list 'default-frame-alist '(font . "Inconsolata-14"))
(global-hl-line-mode t)

;; show line number
(use-package nlinum-relative
  :config
  (add-hook 'prog-mode-hook 'nlinum-relative-mode)
  (setq nlinum-relative-redisplay-delay 0) ;; delay
  (setq nlinum-relative-current-symbol "->")) ;; or "" for display current line number

;; show column number
(setq column-number-mode t)

;; better mode-line
