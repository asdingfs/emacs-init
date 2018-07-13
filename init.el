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

;; use zenburn theme, right after use package initialization
(use-package zenburn-theme
  :ensure t)
(use-package base16-theme
  :ensure t
  :init (load-theme 'base16-gruvbox-dark-soft t))

;;;;;;;;;;;;;;;; Packages and Customizations ;;;;;;;;;;;;;;;;
(let ((directory "~/.emacs.d/.init.d/"))
  (dolist (filename '(configurations ;; global settings
                      functions      ;; global self-defined functions
                      keybindings    ;; global keybindings
                      specifics      ;; machine/os specific configurations
                      packages))     ;; other packages, most bulk, and required most organizations
    (load (format "%s%s" directory filename)))) ;; load each packages declared above

;;;;;;;;;;;;;;;; Locals and Instance Specifics ;;;;;;;;;;;;;;;;
;; i.e. require only if defined
(add-to-list 'load-path "~/.emacs.d/.personal.d/locals/")
(load "publishing" t)
