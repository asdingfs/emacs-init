;;;;;;;;;;;;;;;; meta ;;;;;;;;;;;;;;;;
;; dash references for mac osx
(use-package dash-at-point
  :commands (dash-at-point)
  :bind
  (("s-." . dash-at-point)))
;; git
(use-package magit
  :defer t
  :init
  (setq magit-completing-read-function 'ivy-completing-read)
  (add-hook 'git-commit-setup-hook 'turn-off-auto-fill t)
  :bind
  (("C-x g" . magit-status)))
;; major mode for editing git config files
(use-package gitignore-mode
  :defer t)
;; terminals and ssh
(use-package multi-term
  :defer t
  :init
  (setq multi-term-program "/bin/zsh")
  (add-hook 'term-mode-hook (lambda () (yas-minor-mode -1))) 
  :bind
  (("H-0" . multi-term-next)
   ("H-9" . multi-term-prev)
   :map term-raw-map ;; char mode map
   ("C-j" . term-line-mode)
   ("C-c C-c" . term-interrupt-subjob)
   ("M-f" . term-send-forward-word)
   ("M-b" . term-send-backward-word)
   ("M-<backspace>" . term-send-backward-kill-word)
   ("M-d" . term-send-forward-kill-word)
   ("C-r" . term-send-reverse-search-history)
   ("M-y" . term-send-raw-meta)
   ("C-y" . term-send-raw)
   :map term-mode-map ;; line mode map
   ("C-j" . term-char-mode)
   ("C-c C-c" . term-interrupt-subjob)
   ("C-p" . previous-line)
   ("C-n" . next-line)
   ("M-p" . term-send-up)
   ("M-n" . term-send-down)
   ("M-f" . term-send-forward-word)
   ("M-b" . term-send-backward-word)
   ("M-<backspace>" . term-send-backward-kill-word)
   ("M-d" . term-send-forward-kill-word)
   ("C-r" . term-send-reverse-search-history)
   ("M-y" . term-send-raw-meta)
   ("C-y" . term-send-raw)))
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
(use-package rvm
  :defer 1.5 ;; after exec-path-from-shell
  :config
  (rvm-use-default))
(use-package rspec-mode
  :commands (rspec-mode)
  :init
  (add-hook 'after-init-hook 'inf-ruby-switch-setup)
  :config
  (rspec-install-snippets))
(use-package robe
  :disabled
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
;; front end major modes
(use-package css-mode
  :config
  (setq css-indent-offset 2))
(use-package web-mode
  :mode
  (("\\.phtml\\'" . web-mode)
   ("\\.tpl\\.php\\'" . web-mode)
   ("\\.[agj]sp\\'" . web-mode)
   ("\\.as[cp]x\\'" . web-mode)
   ("\\.erb\\'" . web-mode)
   ("\\.mustache\\'" . web-mode)
   ("\\.djhtml\\'" . web-mode))
  :config
  (setq web-mode-css-indent-offset 2))

;; javascript
(use-package js
  :config
  (setq js-indent-level 2))
;; json modes and configurations
(use-package json-mode
  :bind
  (:map json-mode-map
        ("C-c C-f" . json-mode-beautify))
  :config
  (setq json-reformat:indent-width 2))
