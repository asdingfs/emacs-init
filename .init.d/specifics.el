;;;;;;;;;;;;;;;; Modifier keys ;;;;;;;;;;;;;;;;
;;;; MACOSX
(when (featurep 'ns)
  (setq ns-pop-up-frames nil)     ;; always open file on same emacs frame
  (setq ns-option-modifier 'meta)
  (setq ns-command-modifier 'super)
  (setq ns-right-command-modifier 'super)
  (setq ns-right-option-modifier 'hyper)

  (defun ns-raise-emacs ()
    "Raise Emacs."
    (select-frame-set-input-focus (selected-frame)))

  (defun ns-raise-emacs-with-frame (frame)
    "Raise Emacs and select the provided frame."
    (with-selected-frame frame
      (when (display-graphic-p)
        (ns-raise-emacs))))

  (add-hook 'after-make-frame-functions 'ns-raise-emacs-with-frame)

  (when (display-graphic-p)
    (ns-raise-emacs))

  (setq shell-file-name "/usr/local/bin/zsh")
  (setq explicit-shell-file-name "/usr/local/bin/zsh")
  (setenv "SHELL" shell-file-name)
  (setenv "ESHELL" shell-file-name)

  (when (eq system-type 'darwin)
    (require 'ls-lisp)
    (setq ls-lisp-use-insert-directory-program nil))

  (use-package exec-path-from-shell
    :if (memq window-system '(mac ns x nil))
    :config
    (exec-path-from-shell-copy-env "GEM_PATH")
    (exec-path-from-shell-copy-env "GEM_HOME")
    (exec-path-from-shell-initialize)
    (message "Initialized PATH and other variables from SHELL")))

;;;; WINDOWS
(when (featurep 'w32)
  (setq w32-pass-rwindow-to-system nil)
  (setq w32-rwindow-modifier 'super) ;; Right Windows keys
  ;; NOTE: need to set the following Autohotkey Configuration
  ;;   RAlt::F24
  (w32-register-hot-key [s-])
  (w32-register-hot-key [H-])
  (bind-key "<f24>" 'event-apply-hyper-modifier function-key-map))
