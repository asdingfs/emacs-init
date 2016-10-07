(use-package helm
  :init
  (progn
    (require 'helm-config)
    (helm-mode))
  (setq helm-move-to-line-cycle-in-source   t)
  :bind (("M-x" . helm-M-x))
  :diminish helm-mode )
