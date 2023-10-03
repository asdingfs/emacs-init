;;;; Linux
(when (eq system-type 'gnu/linux)
  (setq shell-file-name "/home/linuxbrew/.linuxbrew/bin/zsh")
  (setq explicit-shell-file-name "/home/linuxbrew/.linuxbrew/bin/zsh")
  (setenv "SHELL" shell-file-name)
  (setenv "ESHELL" shell-file-name)

  (use-package exec-path-from-shell
    :config
    (exec-path-from-shell-copy-env "GEM_PATH")
    (exec-path-from-shell-copy-env "GEM_HOME")
    (exec-path-from-shell-initialize)
    (message "Initialized PATH and other variables from SHELL"))
  )

;;;; MACOSX
(when (eq system-type 'darwin)
  ;; modifier keys
  (setq ns-pop-up-frames nil)     ;; always open file on same emacs frame
  (setq ns-option-modifier 'meta)
  (setq ns-command-modifier 'super)
  (setq ns-right-command-modifier 'hyper)
  (setq ns-right-option-modifier 'super)

  ;; behaviour
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

  ;; shell configuration & envs
  (setq shell-file-name "/usr/local/bin/zsh")
  (setq explicit-shell-file-name "/usr/local/bin/zsh")
  (setenv "SHELL" shell-file-name)
  (setenv "ESHELL" shell-file-name)

  (when (eq system-type 'darwin)
    (require 'ls-lisp)
    (setq ls-lisp-use-insert-directory-program nil))

  (use-package exec-path-from-shell
    :config
    (exec-path-from-shell-copy-env "GEM_PATH")
    (exec-path-from-shell-copy-env "GEM_HOME")
    (exec-path-from-shell-initialize)
    (message "Initialized PATH and other variables from SHELL"))

  ;; configure title bar
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  )

;;;; WINDOWS
(when (featurep 'w32)
  ;; modifier keys
  (setq w32-pass-rwindow-to-system nil)
  (setq w32-pass-alt-to-system nil)
  (setq w32-rwindow-modifier 'hyper) ;; Right Windows keys
  ;; NOTE: need to set the following Autohotkey Configuration
  ;; Also, turn on FILTER KEYS in Ease Access>Keyboard
  (w32-register-hot-key [s-])
  (w32-register-hot-key [H-])
  ;; set to use git bash for shell
  (setq shell-file-name "C:/Program Files/Git/bin/bash.exe")
  (setq explicit-shell-file-name "C:/Program Files/Git/bin/bash.exe")
  (setenv "SHELL" shell-file-name)
  (setenv "ESHELL" shell-file-name)
  ;; set ssh_askpass executable so Magit doesn't throw error
  (setq ssh-askpass-executables "c:/Program Files/Git/mingw64/libexec/git-core/git-askpass.exe")
  (setenv "SSH_ASKPASS" ssh-askpass-executables))
