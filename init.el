
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
(setq package-enable-at-startup nil)
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
(load-library "functions")          ;; global self-defined functions
(load-library "keybindings")        ;; global keybindings
(load-library "specifics")          ;; machine/os specific configurations
(load-library "packages")           ;; other packages, most bulk, and required most organizations
;;;;;;;;;;;;;;;; Locals and Instance Specifics ;;;;;;;;;;;;;;;;
;; i.e. require only if defined
(add-to-list 'load-path "~/.emacs.d/.personal.d/locals/")
(load "publishing" t)

;;;;;;;;;;;;;;;; List of packages yet to be further configured ;;;;;;;;;;;;;;;;
;; emacs-w3m
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
    (transpose-frame markdown-preview-mode linum-relative w3m origami expand-region json-mode markdown-mode ox-pandoc highlight-indent-guides web-mode rvm gitignore-mode git-modes magit robe ag rspec-mode yasnippet multi-term ssh-config-mode ssh yaml-mode htmlize org-bullets dash-at-point ox-twbs smartparens enh-ruby-mode projectile-rails counsel-projectile flx exec-path-from-shell helm zenburn-theme use-package)))
 '(projectile-mode t nil (projectile)))

;;;;;;;;;;;;;;;; Disabled warning commands ;;;;;;;;;;;;;;;;
(put 'narrow-to-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
