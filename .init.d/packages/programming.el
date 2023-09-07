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
  :commands (magit-toplevel)
  :defer t
  :init
  (setq magit-completing-read-function 'ivy-completing-read)
  (add-hook 'git-commit-setup-hook 'turn-off-auto-fill t)
  :bind
  (("C-x g" . magit-status))
  :config
  (add-hook 'after-save-hook 'magit-after-save-refresh-status)
  (setq magit-save-repository-buffers 'dontask)
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
  ;; (magit-define-popup-switch 'magit-log-popup
  ;;   ?m "Omit merge commits" "--no-merges")
  ;; (magit-define-popup-switch 'magit-push-popup
  ;;   ?t "Follow tags" "--follow-tags")
  ;; (magit-define-popup-action 'magit-merge-popup
  ;;   ?u "Merge updates from upstream"
  ;;   (lambda ()
  ;;     (interactive)
  ;;     (magit-merge "@{upstream}" `("--ff" "--ff-only"))))
  )

;; extensions for gitflow
(use-package magit-gitflow
  :after (magit)
  :config
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))
;; check history of file changes
(use-package git-timemachine)

(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview))

;; ssh configs
(use-package ssh
  :defer t
  :init
  (setq ssh-directory-tracking-mode 'ftp)
  (add-hook 'ssh-mode-hook
            '(lambda ()
               (shell-dirtrack-mode t)
               (setq dirtrackp nil) )))
(use-package ssh-agency)
(use-package ssh-config-mode
  :defer t
  :init
  (add-hook 'ssh-config-mode-hook 'turn-on-font-lock))

;;;;;;;;;;;;;;;; languages ;;;;;;;;;;;;;;;;
;; ruby
(use-package enh-ruby-mode
  :init
  (setq enh-ruby-hanging-indent-level 2)
  (setq enh-ruby-deep-indent-paren nil)
  (setq enh-ruby-bounce-deep-indent t) ;; toggle deep indent
  ;; (setq enh-ruby-hanging-paren-indent-level 2) ;; change parentheses indentation
  ;; (setq enh-ruby-hanging-brace-indent-level 2) ;; change curly braces indentation
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
(use-package bundler
  :after (rvm))
(use-package rspec-mode
  :commands (rspec-mode)
  :init
  (setq rspec-use-rvm t)
  :config
  (rspec-install-snippets))
(use-package rubocop
  :diminish rubocop-mode
  :init
  (add-hook 'ruby-mode-hook #'rubocop-mode)
  (add-hook 'enh-ruby-mode-hook #'rubocop-mode)
  :config
  (setq rubocop-autocorrect-on-save nil))

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
  (("\\.html?\\'" . web-mode)
   ("\\.phtml\\'" . web-mode)
   ("\\.tpl\\.php\\'" . web-mode)
   ("\\.[agj]sp\\'" . web-mode)
   ("\\.as[cp]x\\'" . web-mode)
   ("\\.erb\\'" . web-mode)
   ("\\.mustache\\'" . web-mode)
   ("\\.djhtml\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2))

;; javascript
(use-package js2-mode
  ;; :mode
  ;; (("\\.js\\'" . js2-mode)) # use rjsx mode instead
  :interpreter
  ("node" . js2-mode)
  :config
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
  (add-hook 'js2-mode-hook
            (lambda () (setq js2-basic-offset 2))))

(use-package js2-refactor
  :bind
  (:map js-mode-map
        ("M-." . nil))
  :config
  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (js2r-add-keybindings-with-prefix "C-c C-r"))

(use-package xref-js2
  :config
  (add-hook 'js2-mode-hook
            (lambda () (add-hook 'xref-backend-functions
                                 #'xref-js2-xref-backend nil t))))

(use-package rjsx-mode
  :mode
  (("\\/.*\\.js\\'" . rjsx-mode)))

(use-package flow-minor-mode
  :config
  (add-hook 'js2-mode-hook 'flow-minor-enable-automatically))

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
