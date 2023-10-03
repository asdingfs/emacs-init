;;;;;;;;;;;;;;;; Personal Data ;;;;;;;;;;;;;;;;
;; username
(setq user-full-name "Anthony S. 丁富胜"
      user-mail-address "asding.fs@gmail.com")

;;;;;;;;;;;;;;;; Themes ;;;;;;;;;;;;;;;;
;; looks
(tooltip-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
;; open magit-status on emacs init file directory by default
(setq initial-buffer-choice (lambda ()
                              (magit-status (file-name-directory user-init-file))
                              (current-buffer)))

;; (set-frame-parameter nil 'fullscreen 'fullboth) ;; enable this if you want full screen
(setq column-number-mode t) ;; show column number
(setq-default line-spacing 1) ;; standardise line-spacing
(global-hl-line-mode t) ;; highlight currently active line
(add-to-list 'default-frame-alist '(font . "Iosevka Term-13")) ;; set font to use
(set-frame-font "Iosevka Term-13" nil t)
(set-language-environment "UTF-8")

;; required for unicode-fonts
(use-package font-utils
  :ensure t)
(use-package ucs-utils
  :ensure t)
(use-package list-utils
  :ensure t)
(use-package persistent-soft
  :ensure t)

;; behaviours
(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil) ;; Use spaces for indentations
(setq-default sentence-end-double-space nil)

;; customs
(setq bookmark-default-file "~/.emacs.d/.personal.d/locals/bookmarks")
(setq save-interprogram-paste-before-kill t) ;; always append system's clipboard to kill-ring

;; dired configs
(require 'dired)
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(setq dired-dwim-target t) ;; dired will try to guess the target for file operations

;; quirks
(setq system-uses-terminfo nil) ;; causing '4m' in shells
(setq shell-file-name "/bin/bash") ;; TODO: temporarily set bash as default shell for remote server compatibility

;; server
;; used launchd istead of manually starting server here
;; (load "server")
;; (unless (server-running-p) (server-start))

;; custom file
(setq custom-file "~/.emacs.d/.personal.d/custom-file.el")
(load custom-file)
;; put declaration of disabled command in custom-file
(defadvice en/disable-command (around put-in-custom-file activate)
      "Put declarations in `custom-file'."
      (let ((user-init-file custom-file))
        ad-do-it))
