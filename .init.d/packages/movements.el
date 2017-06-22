;;;;;;;;;;;;;;;; temporal ;;;;;;;;;;;;;;;;
;; winner mode: splitting configurations
(when (fboundp 'winner-mode)
  (winner-mode 1))
(global-set-key (kbd "H->") 'winner-redo)
(global-set-key (kbd "H-<") 'winner-undo)

;; linum-relative mode: display relative line numbers
(use-package linum-relative
  :init
  (add-hook 'prog-mode-hook 'linum-relative-on)
  :config
  (setq linum-relative-current-symbol "=>"))
;; enable linum mode globally
(global-linum-mode t)

;; transpose-frame to switch windows
(use-package transpose-frame
  :bind
  (("H-\"" . flop-frame)
   ("H-?" . flip-frame)
   ("H-}" . transpose-frame)))
