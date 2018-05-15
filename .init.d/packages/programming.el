;;;;;;;;;;;;;;;; meta ;;;;;;;;;;;;;;;;
;; eshells
(defun eshell/gst (&rest args)
    (magit-status (pop args) nil)
    (eshell/echo))   ;; The echo command suppresses output
(use-package eshell
  :init
  (setq eshell-scroll-to-bottom-on-input 'all
        eshell-destroy-buffer-when-process-dies t)
  (add-hook 'eshell-mode-hook
            (lambda ()
              ;; for better handling of ansiterm when running these commands
              (add-to-list 'eshell-visual-commands "ssh")
              (add-to-list 'eshell-visual-commands "tail")
              (add-to-list 'eshell-visual-commands "top")
              ;; add eshell-tramp integration to eshell-modules-list
              (add-to-list 'eshell-modules-list 'eshell-tramp)
              ;; don't cycle completions, and show completion-list
              (setq pcomplete-cycle-completions nil)
              (define-key eshell-mode-map (kbd "<tab>") 'completion-at-point))))

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
  (("C-x g" . magit-status))
  :config
  (setq magit-display-buffer-function
      (lambda (buffer)
        (display-buffer
         buffer
         (cond ((and (derived-mode-p 'magit-mode)
                     (eq (with-current-buffer buffer major-mode)
                         'magit-status-mode))
                nil)
               ((memq (with-current-buffer buffer major-mode)
                      '(magit-process-mode
                        magit-revision-mode
                        magit-diff-mode
                        magit-log-mode
                        magit-stash-mode))
                nil)
               (t
                '(display-buffer-same-window))))))
  (magit-define-popup-switch 'magit-log-popup
    ?m "Omit merge commits" "--no-merges")
  (magit-define-popup-switch 'magit-push-popup
    ?t "Follow tags" "--follow-tags"))

(use-package magit-gitflow
  :after (magit)
  :config
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))
;; major mode for editing git config files
(use-package gitignore-mode
  :defer t)
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
  :after (exec-path-from-shell)
  :config
  (rvm-use-default))
(use-package rspec-mode
  :commands (rspec-mode)
  :init
  (setq rspec-use-rvm t)
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

;; bash scripting
(use-package conf-mode
  :mode
  (("\\.env.sample\\'" . conf-mode)
   ("\\.env\\'" . conf-mode)))
