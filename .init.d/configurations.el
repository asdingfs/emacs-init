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
;; (set-frame-parameter nil 'fullscreen 'fullboth) ;; enable this if you want full screen
(setq column-number-mode t) ;; show column number
(global-hl-line-mode t) ;; highlight currently active line
(add-to-list 'default-frame-alist '(font . "Inconsolata-14")) ;; set font to use

;; behaviours
(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil) ;; Use spaces for indentations

;; customs
(setq bookmark-default-file "~/.emacs.d/.personal.d/locals/bookmarks")
(setq save-interprogram-paste-before-kill t) ;; always append system's clipboard to kill-ring

;; dired configs
(require 'dired)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(setq dired-dwim-target t) ;; dired will try to guess the target for file operations

;; quirks
(setq system-uses-terminfo nil) ;; causing '4m' in shells

;; server
(load "server")
(unless (server-running-p) (server-start))

;; custom file
(setq custom-file "~/.emacs.d/.personal.d/custom-file.el")
(load custom-file)
;; put declaration of disabled command in custom-file
(defadvice en/disable-command (around put-in-custom-file activate)
      "Put declarations in `custom-file'."
      (let ((user-init-file custom-file))
        ad-do-it))
