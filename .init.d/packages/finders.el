;; fuzzy matching
(use-package flx
  :defer t)

;; edit on occur
(use-package wgrep
  :defer t)

;; for searching files
(use-package ag
  :defer t
  :init
  (setq ag-highlight-search t))

;; for finding definitions
(use-package dumb-jump
  :ensure t
  :bind
  (("C-." . dumb-jump-go)
   ("C-," . dumb-jump-back)
   ("C-M-." . dumb-jump-go-other-window)
   ("C-?" . dumb-jump-go-prompt)
   ("M-?" . dumb-jump-quick-look)
   ("M-g ." . dumb-jump-go-prefer-external)
   ("M-g M-." . dumb-jump-go-prefer-external-other-window))
  :config
  (setq dumb-jump-selector 'ivy)
  (setq dumb-jump-prefer-searcher 'ag))

;; use projectile for project file finders
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :init
  (when (fboundp 'projectile-mode)
    (projectile-mode +1))
  :hook
  (emacs-startup . projectile-load-known-projects)
  :bind
  (("M-s" . projectile-command-map))
  :config
  (setq projectile-completion-system 'ivy)
  (setq projectile-create-missing-test-files t)
  (setq projectile-switch-project-action 'magit-status-on-toplevel-if-possible))

;; better search with swiper: installs ivy-mode too
(use-package ivy
  :diminish ivy-mode
  :bind
  (("C-c C-r" . ivy-resume))
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist
        '((counsel-ag . ivy--regex-plus)
          (swiper . ivy--regex-plus)
          (t . ivy--regex-fuzzy)))
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-height 12)
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
   ("C-S-r" . isearch-backward))
  :config
  (setq swiper-include-line-number-in-search t))

;; replace vanilla finders with counsel, closely tied to ivy-mode
(use-package counsel
  :after (swiper)
  :init
  (setq counsel-ag-base-command "ag --vimgrep --nocolor --nogroup --hidden --ignore-dir .git %s")
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
   ("C-S-e" . counsel-mark-ring) ;; # TODO: implement custom function for global mark ring
   ("H-f" . counsel-ag)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))

;; inter package integrations
(use-package counsel-projectile
  :after (counsel projectile)
  :config
  (setq counsel-projectile-switch-project-action
        '(1
          ("dwim" counsel-projectile-switch-project-action-dwim "execute do-what-i-mean")
          ("o" counsel-projectile-switch-project-action "jump to a project buffer or file")
          ("f" counsel-projectile-switch-project-action-find-file "jump to a project file")
          ("d" counsel-projectile-switch-project-action-find-dir "jump to a project directory")
          ("b" counsel-projectile-switch-project-action-switch-to-buffer "jump to a project buffer")
          ("m" counsel-projectile-switch-project-action-find-file-manually "find file manually from project root")
          ("S" counsel-projectile-switch-project-action-save-all-buffers "save all project buffers")
          ("k" counsel-projectile-switch-project-action-kill-buffers "kill all project buffers")
          ("K" counsel-projectile-switch-project-action-remove-known-project "remove project from known projects")
          ("c" counsel-projectile-switch-project-action-compile "run project compilation command")
          ("C" counsel-projectile-switch-project-action-configure "run project configure command")
          ("E" counsel-projectile-switch-project-action-edit-dir-locals "edit project dir-locals")
          ("v" counsel-projectile-switch-project-action-vc "open project in vc-dir / magit / monky")
          ("sg" counsel-projectile-switch-project-action-grep "search project with grep")
          ("ss" counsel-projectile-switch-project-action-ag "search project with ag")
          ("sr" counsel-projectile-switch-project-action-rg "search project with rg")
          ("xs" counsel-projectile-switch-project-action-run-shell "invoke shell from project root")
          ("xe" counsel-projectile-switch-project-action-run-eshell "invoke eshell from project root")
          ("xt" counsel-projectile-switch-project-action-run-term "invoke term from project root")
          ("O" counsel-projectile-switch-project-action-org-capture "org-capture into project"))))

(use-package projectile-rails
  :diminish projectile-rails-mode
  :defer t
  :after (counsel-projectile)
  :init
  (setq projectile-rails-add-keywords t)
  (setq projectile-rails-expand-snippet t)
  (add-hook 'find-file-hook 'projectile-rails-on)
  (add-hook 'dired-mode-hook 'projectile-rails-on)
  (add-hook 'magit-mode-hook 'projectile-rails-on)
  :bind
  (:map projectile-rails-mode-map
   ("M-s M-r" . projectile-rails-command-map))
  :config
  (projectile-rails-global-mode))

;; remote servers
(use-package tramp
  :config
  (setq tramp-default-method "scp")
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (tramp-set-completion-function "ssh" '((tramp-parse-sconfig "/etc/ssh_config")
                                         (tramp-parse-sconfig "~/.ssh/config")))
  (add-hook 'find-file-hook 'set-default-remote-shell))

;; web surfing
(use-package w3m
  :disabled t
  :bind
  (("H-s" . w3m-search)
   ("H-b" . w3m-browse-url))
  :config
  (setq
   w3m-coding-system 'utf-8
   w3m-file-coding-system 'utf-8
   w3m-file-name-coding-system 'utf-8
   w3m-input-coding-system 'utf-8
   w3m-output-coding-system 'utf-8
   w3m-terminal-coding-system 'utf-8)
  (setq w3m-search-default-engine "google"))

;; file managers
(use-package f)
