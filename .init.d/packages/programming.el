;; git
(use-package magit
  :defer t
  :init
  (setq magit-completing-read-function 'ivy-completing-read)
  (add-hook 'git-commit-mode-hook 'turn-off-auto-fill)
  :bind
  (("C-x g" . magit-status)))

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
