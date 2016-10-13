(use-package swiper
  :init
  (setq ivy-use-virtual-buffers t)
  :bind
  (("C-s" . swiper)
   ("C-c C-r" . ivy-resume))
  :config
  (ivy-mode 1))


(use-package counsel
  :bind
  (("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-h C-f" . counsel-describe-function)
   ("C-h C-v" . counsel-describe-variable)
   ("C-c g" . counsel-git)
   ("C-c j" . counsel-git-grep)
   ("C-c a" . counsel-ag)))
