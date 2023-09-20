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

;; whitespace
(use-package whitespace
  :config
  ;; enable whitespace mode globally
  (global-whitespace-mode t)
  ;; customise display of whitespaces
  (setq whitespace-display-mappings
        (quote ((space-mark 32 [?·]) ;; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
                (newline-mark 10 [182 10]) ;; 10 LINE FEED to 「¶」
                (tab-mark 9 [9655 9] [92 9])))) ;; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
  (setq whitespace-style (quote (face trailing spaces tabs newline newline space-mark tab-mark newline-mark)))
  (set-face-attribute 'whitespace-space nil :background 'unspecified :foreground "gray35")
  ;; since font breaks for Magit, disable for Magit buffers
  (defun prevent-whitespace-mode ()
    (not (or (derived-mode-p 'magit-mode) (derived-mode-p 'org-mode))))
  (add-function :before-while whitespace-enable-predicate 'prevent-whitespace-mode))
