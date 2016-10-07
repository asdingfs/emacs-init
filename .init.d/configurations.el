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
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

;; themes
(use-package zenburn-theme
  :ensure t
  :init (load-theme 'zenburn t))
(set-default-font "Inconsolata-14" nil t)

;; behaviours
(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil) ;; Use spaces for indentations

;; server
(server-start)
