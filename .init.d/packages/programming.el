;;;;;;;;;;;;;;;; meta ;;;;;;;;;;;;;;;;
;; dash references for mac osx
(use-package dash-at-point
  :commands (dash-at-point)
  :bind
  (("H-d" . dash-at-point)))
;; git
(use-package magit
  :defer t
  :init
  (setq magit-completing-read-function 'ivy-completing-read)
  (add-hook 'git-commit-setup-hook 'turn-off-auto-fill t)
  :bind
  (("C-x g" . magit-status)))
;; ssh client
(use-package ssh
  :defer t
  :init
  (setq ssh-directory-tracking-mode 'ftp)
  (add-hook 'ssh-mode-hook
            '(lambda ()
               (shell-dirtrack-mode t)
               (setq dirtrackp nil) )))
(use-package ssh-config-mode
  :defer t
  :init
  (add-hook 'ssh-config-mode-hook 'turn-on-font-lock))

;;;;;;;;;;;;;;;; languages ;;;;;;;;;;;;;;;;
;; ruby
(use-package enh-ruby-mode              
  :init
  (setq enh-ruby-hanging-indent-level 2) 
  (setq enh-ruby-deep-arglist nil)
  ;; (setq enh-ruby-deep-indent-paren nil)
  ;; (setq enh-ruby-bounce-deep-indent t)
  ;; (setq enh-ruby-hanging-paren-deep-indent-level 0)
  ;; (setq enh-ruby-hanging-brace-deep-indent-level 0)
  :mode
  (("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
  :config
  (unbind-key "C-d" enh-ruby-mode-map))
(use-package robe
  :defer t
  :init
  (add-hook 'ruby-mode-hook 'robe-mode)
  (add-hook 'enh-ruby-mode-hook 'robe-mode)
  :config
  (robe-start))

;; yaml
(use-package yaml-mode
  :defer t
  :bind
  (:map yaml-mode-map
   ("C-m" . newline-and-indent)
   ("<return>" . newline-and-indent))
  :mode
  (("\\.yml\\'" . yaml-mode)))
