;; fuzzy matching
(use-package flx
  :defer t)

;; for searching files
(use-package ag
  :defer t
  :init
  (setq ag-highlight-search t))

;; use projectile for project file finders
(use-package projectile
  :diminish projectile-mode
  :config
  (setq projectile-completion-system 'ivy)
  (setq projectile-create-missing-test-files t)
  (setq projectile-switch-project-action 'magit-status)
  (projectile-global-mode t))

;; better search with swiper: installs ivy-mode too
(use-package ivy
  :diminish ivy-mode
  :bind
  (("C-c C-r" . ivy-resume))
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (t . ivy--regex-fuzzy)))
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-height 10)
  :config
  (ivy-mode 1)
  (ivy-add-actions t
                   '(("I" (lambda (x) (with-ivy-window (insert x))) "insert")))
  (ivy-add-actions 'counsel-find-file
                   '(("F" (lambda (x) (with-ivy-window (insert (file-relative-name x))))
                      "insert relative file name")
                     ("B" (lambda (x)
                            (with-ivy-window
                              (insert (file-name-nondirectory (replace-regexp-in-string "/\\'" "" x)))))
                      "insert file name without any directory information"))))
(use-package swiper
  :after (ivy)
  :bind
  (("C-s" . swiper)
   ("C-r" . swiper)
   ("C-S-s" . isearch-forward)
   ("C-S-r" . isearch-backward)))

;; replace vanilla finders with counsel, closely tied to ivy-mode
(use-package counsel
  :after (swiper)
  :init
  (setq counsel-ag-base-command "ag --nocolor --nogroup --hidden --ignore-dir .git %s")
  :bind
  (("M-x" . counsel-M-x)
   ("M-y" . counsel-yank-pop)
   ("C-x C-f" . counsel-find-file)
   ("C-h f" . counsel-describe-function)
   ("C-h v" . counsel-describe-variable)
   ("C-x C-d" . counsel-file-jump) 
   ("C-x r l" . counsel-bookmark)
   ("C-h x" . counsel-imenu)
   ("C-c SPC g" . counsel-git)
   ("C-c SPC j" . counsel-git-grep)
   ("H-f" . counsel-ag)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))

;; inter package integrations
(use-package counsel-projectile
  :after (counsel projectile)
  :init
  (counsel-projectile-on))
(use-package projectile-rails
  :diminish projectile-rails-mode
  :defer t
  :after (counsel-projectile)
  :init 
  (setq projectile-rails-add-keywords t)
  (setq projectile-rails-expand-snippet t)
  (add-hook 'find-file-hook 'projectile-rails-on)
  (add-hook 'dired-mode-hook 'projectile-rails-on)
  (add-hook 'magit-status-mode-hook 'projectile-rails-on))

;; remote servers
(use-package tramp
  :init
  ;; (setq tramp-verbose 10) 
  (setq tramp-default-method "ssh")
  :config
  (tramp-set-completion-function "ssh" '((tramp-parse-sconfig "/etc/ssh_config")
                                         (tramp-parse-sconfig "~/.ssh/config"))))

;; web surfing
(use-package w3m
  :bind
  (("H-w" . w3m-search)
   ("H-u" . w3m-browse-url))
  :config
  (setq
   w3m-coding-system 'utf-8
   w3m-file-coding-system 'utf-8
   w3m-file-name-coding-system 'utf-8
   w3m-input-coding-system 'utf-8
   w3m-output-coding-system 'utf-8
   w3m-terminal-coding-system 'utf-8)
  (setq w3m-search-default-engine "google"))
