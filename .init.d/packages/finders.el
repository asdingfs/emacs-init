;; fuzzy matching 
(use-package flx)

;; for searching files
(use-package ag)

;; use projectile for project file finders
(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy))

;; better search with swiper: installs ivy-mode too
(use-package ivy
  :diminish ivy-mode
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))
  (setq ivy-initial-inputs-alist nil)
  :bind
  (("C-c C-r" . ivy-resume))
  :config
  (ivy-mode 1)
  (use-package swiper
    :bind (("C-s" . swiper))))

;; replace vanilla finders with counsel, closely tied to ivy-mode
(use-package counsel
  :bind
  (("M-x" . counsel-M-x)
   ("M-y" . counsel-yank-pop)
   ("C-x C-f" . counsel-find-file)
   ("C-h C-f" . counsel-describe-function)
   ("C-h C-v" . counsel-describe-variable)
   ("C-c SPC g" . counsel-git)
   ("C-c SPC j" . counsel-git-grep)
   ("C-c SPC s" . counsel-ag))
  :config
  (use-package counsel-projectile
    :config
    (counsel-projectile-on)))
  
