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

(use-package nlinum-relative
  :config
  (add-hook 'prog-mode-hook 'nlinum-relative-mode)
  (setq nlinum-relative-redisplay-delay 0) ;; delay
  (setq nlinum-relative-current-symbol "->")) ;; or "" for display current line number

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
              (setq pcomplete-cycle-completions nil))))

;; server
(load "server")
(unless (server-running-p) (server-start))
