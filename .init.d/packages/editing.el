;; autopairs
(use-package smartparens
  :bind
  (("C-M-k" . sp-kill-sexp)
   ("C-M-f" . sp-forward-sexp)
   ("C-M-b" . sp-backward-sexp)
   ("C-M-u" . sp-up-sexp)
   ("C-M-d" . sp-down-sexp)
   ("C-)" . sp-forward-slurp-sexp)
   ("C-}" . sp-forward-barf-sexp)
   ("C-(" . sp-backward-slurp-sexp)
   ("C-{" . sp-backward-barf-sexp)) 
  :init
  (add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
  :config
  (require 'smartparens-config)
  (show-smartparens-global-mode t)
  )

