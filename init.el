
;;;; NOTES
;; These init files are mostly self maintaining, however may stil need some dependency to work beautifully, as such:
;;  1. Install Inconsolata-14 on local system for most beautiful programming font out there IMO

;;;;;;;;;;;;;;;; Package Archives ;;;;;;;;;;;;;;;;
(require 'package)
(setq package-enable-at-startup nil)
(when (> emacs-major-version 24)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  ;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)


;;;;;;;;;;;;;;;; Use-Package ;;;;;;;;;;;;;;;;
(unless (package-installed-p 'use-package) ;; install if necessary
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'diminish)		;; enable :diminish options
(require 'bind-key)		;; enable :bind options
(setq use-package-always-ensure t) ;; always download if not available
(setq use-package-verbose t)	;; don't fail silently

;;;;;;;;;;;;;;;; Packages and Customizations ;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/.init.d/")
(load-library "configurations")     ;; global settings, and themes
(load-library "keybindings")        ;; global keybindings
(load-library "specifics")          ;; machine/os specific configurations
(load-library "packages")           ;; other packages, most bulk, and required most organizations


;;;;;;;;;;;;;;;; List of packages yet to be further configured ;;;;;;;;;;;;;;;;
;; Magit
;; Ruby program setup
;; emacs-w3m
;; neotree
;; ag: https://github.com/Wilfred/ag.el
;; wgrep-ag: https://github.com/mhayashi1120/Emacs-wgrep
;; powerline (better info-bar)

;;;;;;;;;;;;;;;; Auto-Generated Custom Variables ;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ox-twbs smartparens enh-ruby-mode projectile-rails counsel-projectile flx exec-path-from-shell helm zenburn-theme use-package)))
 '(projectile-mode t nil (projectile)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
