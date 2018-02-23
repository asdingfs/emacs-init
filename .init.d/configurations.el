;;;;;;;;;;;;;;;; Personal Data ;;;;;;;;;;;;;;;;
;; username
(setq user-full-name "Anthony S. 丁富胜"
      user-mail-address "ding.fsas@gmail.com")

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

;; themes
(use-package zenburn-theme
  :ensure t
  :init (load-theme 'zenburn t))
(add-to-list 'default-frame-alist '(font . "Inconsolata-14"))
(global-hl-line-mode t)
(set-face-background 'hl-line "#2B2B2B")

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

;; eshells
(add-hook 'eshell-mode-hook (lambda () (setq pcomplete-cycle-completions nil)))

;; server
(load "server")
(unless (server-running-p) (server-start))
