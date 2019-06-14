;;;;;;;;;;;;;;;; temporal ;;;;;;;;;;;;;;;;
;; winner mode: splitting configurations
(when (fboundp 'winner-mode)
  (winner-mode 1)
  (global-set-key (kbd "H->") 'winner-redo)
  (global-set-key (kbd "H-<") 'winner-undo))
(when (fboundp 'desktop-save-mode)
  (desktop-save-mode 0)
  (global-set-key (kbd "H-\`") 'desktop-read)
  (global-set-key (kbd "H-\~") 'desktop-save-in-desktop-dir)
  (add-to-list 'desktop-path "~/.emacs.d/.personal.d/locals/")
  (setq desktop-dirname "~/.emacs.d/.personal.d/locals/"))

;; transpose-frame to switch windows
(use-package transpose-frame
  :bind
  (("H-}" . flop-frame)
   ("H-|" . flip-frame)
   ("C-x \\" . transpose-frame)))

;; buffer-move to move windows directionally
(use-package buffer-move
  :bind
  (("H-:" . buf-move-left)
   ("H-\"" . buf-move-right)
   ("H-{" . buf-move-up)
   ("H-?" . buf-move-down)))

