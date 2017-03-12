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
(set-default-font "Inconsolata-14" nil t)
(global-hl-line-mode t)

;; behaviours
(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil) ;; Use spaces for indentations

;; customs
(setq bookmark-default-file "~/.emacs.d/.personal.d/locals/bookmarks")
(setq dired-dwim-target t) ;; dired will try to guess the target for file operations
(setq save-interprogram-paste-before-kill t) ;; always append system's clipboard to kill-ring

;; quirks
(setq system-uses-terminfo nil) ;; causing '4m' in shells

;; server
(server-start)
