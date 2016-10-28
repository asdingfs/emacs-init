;;;;;;;;;;;;;;;; Mac OSX ;;;;;;;;;;;;;;;;
(when (memq window-system '(mac ns))
  (setq ns-pop-up-frames nil)     ;; always open file on same emacs frame
  (setq mac-option-key-is-meta nil)
  (setq mac-command-key-is-meta t)
  (setq mac-right-option-modifier 'super)
  (setq mac-option-modifier 'option)
  (setq mac-right-command-modifier 'hyper)
  (setq mac-command-modifier 'meta))

(use-package exec-path-from-shell
  :defer 0.5
  :if (memq window-system '(mac ns))
  :config
  (add-to-list 'exec-path-from-shell-variables "GEM_PATH")
  (add-to-list 'exec-path-from-shell-variables "GEM_HOME")
  (exec-path-from-shell-initialize))

