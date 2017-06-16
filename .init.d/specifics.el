;;;;;;;;;;;;;;;; Modifier keys ;;;;;;;;;;;;;;;;
(setq ns-pop-up-frames nil)     ;; always open file on same emacs frame
(setq ns-option-key-is-meta nil)
(setq ns-command-key-is-meta t)
(setq ns-right-option-modifier 'super)
(setq ns-option-modifier 'option)
(setq ns-right-command-modifier 'hyper)
(setq ns-command-modifier 'meta)

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
  :defer 0.5
  :if (memq window-system '(mac ns))
  :config
  (add-to-list 'exec-path-from-shell-variables "GEM_PATH")
  (add-to-list 'exec-path-from-shell-variables "GEM_HOME")
  (exec-path-from-shell-initialize))

