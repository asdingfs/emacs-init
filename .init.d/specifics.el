;;;;;;;;;;;;;;;; Mac OSX ;;;;;;;;;;;;;;;;
(when (memq window-system '(mac ns))
  (setq ns-pop-up-frames nil)     ;; always open file on same emacs frame
  (setq mac-option-key-is-meta nil)
  (setq mac-command-key-is-meta t)
  (setq mac-right-option-modifier 'super)
  (setq mac-option-modifier 'option)
  (setq mac-right-command-modifier 'hyper)
  (setq mac-command-modifier 'meta)

  (use-package exec-path-from-shell
    :init
    (exec-path-from-shell-initialize)
    :config
    (exec-path-from-shell-copy-env "GEM_PATH")
    (exec-path-from-shell-copy-env "GEM_HOME")))

