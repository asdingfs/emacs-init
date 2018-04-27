;;;;;;;;;;;;;;;; Modifier keys ;;;;;;;;;;;;;;;;
(setq ns-pop-up-frames nil)     ;; always open file on same emacs frame
(setq ns-option-modifier 'meta)
(setq ns-command-modifier nil)
(setq ns-right-command-modifier 'super)
(setq ns-right-option-modifier 'hyper)

(when (featurep 'ns)
  (defun ns-raise-emacs ()
    "Raise Emacs."
    (ns-do-applescript "tell application \"Emacs\" to activate"))

  (defun ns-raise-emacs-with-frame (frame)
    "Raise Emacs and select the provided frame."
    (with-selected-frame frame
      (when (display-graphic-p)
        (ns-raise-emacs))))

  (add-hook 'after-make-frame-functions 'ns-raise-emacs-with-frame)

  (when (display-graphic-p)
    (ns-raise-emacs)))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x nil))
  :config
  (exec-path-from-shell-copy-env "GEM_PATH")
  (exec-path-from-shell-copy-env "GEM_HOME")
  (exec-path-from-shell-initialize)
  (message "Initialized PATH and other variables from SHELL"))
