(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (helm-mode))
  (setq helm-move-to-line-cycle-in-source   t))
  
