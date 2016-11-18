;; autopairs
;; deletion, movement, modification
;;    for deletions, if S is defined, force overwrite the sp-command (i.e. use the normal command)
;;    for movements, if S is defined, use reverse direction
(use-package smartparens
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
  (add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
  :config
  (require 'smartparens-config)
  (show-smartparens-global-mode t))

;; snippets
(use-package yasnippet
  :init
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  :config
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/.personal.d/snippets")
  (yas-reload-all))

;; merge-tools
(use-package ediff)
(use-package smerge-mode
  :init
  (setq smerge-command-prefix (kbd "C-c v")))
