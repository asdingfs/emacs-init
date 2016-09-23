;; Package archives
(require 'package)
(when (> emacs-major-version 24)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Username
(setq user-full-name "Anthony S. 丁富胜"
     user-mail-address "ding.fsas@gmail.com")

;; Themes and Looks
(load-theme 'zenburn t)
(tooltip-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-default-font "Inconsolata-14" nil t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

;; Global keybindings
(global-set-key (kbd "s-SPC") 'just-one-space)
(global-set-key (kbd "H-r") 'rename-buffer)
(global-set-key (kbd "H-,") 'previous-buffer)
(global-set-key (kbd "H-.") 'next-buffer)

;; Behaviours
(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)



