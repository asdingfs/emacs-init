;;;;;;;;;;;;;;;; temporal ;;;;;;;;;;;;;;;;
;; winner mode: splitting configurations
(when (fboundp 'winner-mode)
  (winner-mode 1))
(global-set-key (kbd "H->") 'winner-redo)
(global-set-key (kbd "H-<") 'winner-undo)
