;;;;;;;;;;;;;;;; Mac OSX ;;;;;;;;;;;;;;;;
(when (memq window-system '(mac ns))
  (setq ns-pop-up-frames nil)     ;; always open file on same emacs frame
  (setq ns-option-key-is-meta nil)
  (setq ns-command-key-is-meta t)
  (setq ns-right-option-modifier 'super)
  (setq ns-option-modifier 'option)
  (setq ns-right-command-modifier 'hyper)
  (setq ns-command-modifier 'meta))

(use-package exec-path-from-shell
  :defer 0.5
  :if (memq window-system '(mac ns))
  :config
  (add-to-list 'exec-path-from-shell-variables "GEM_PATH")
  (add-to-list 'exec-path-from-shell-variables "GEM_HOME")
  (exec-path-from-shell-initialize))

