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
(use-package diminish
  :ensure t
  :config
  (diminish 'auto-revert-mode)) ;; enable :diminish options
(use-package bind-key) ;; enable :bind options
(setq use-package-always-ensure t) ;; always download if not available
(setq use-package-verbose t)	;; don't fail silently

;;;;;;;;;;;;;;;; Packages and Customizations ;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/.init.d/")
(load-library "configurations")     ;; global settings
(load-library "functions")          ;; global self-defined functions
(load-library "keybindings")        ;; global keybindings
(load-library "specifics")          ;; machine/os specific configurations
(load-library "packages")           ;; other packages, most bulk, and required most organizations

;;;;;;;;;;;;;;;; Locals and Instance Specifics ;;;;;;;;;;;;;;;;
;; i.e. require only if defined
(add-to-list 'load-path "~/.emacs.d/.personal.d/locals/")
(load "publishing" t)
