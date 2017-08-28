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
  :if (memq window-system '(mac ns x))
  :defer 0.5
  :config
  (add-to-list 'exec-path-from-shell-variables "GEM_PATH")
  (add-to-list 'exec-path-from-shell-variables "GEM_HOME")
  (add-hook 'after-make-frame-functions 'exec-path-from-shell-initialize))

