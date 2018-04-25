(add-to-list 'load-path "~/.emacs.d/.init.d/packages/")

;;;;;;;;;;;;;;;; exports ;;;;;;;;;;;;;;;;
(load-library "exports")                ;; most of org-mode configurations here

;;;;;;;;;;;;;;;; editings ;;;;;;;;;;;;;;;;
(load-library "editing")                ;; aids editing of texts/codes
(load-library "programming")            ;; configs for programming modes

;;;;;;;;;;;;;;;; navigations ;;;;;;;;;;;;;;;;
(load-library "finders")                ;; finders for things you seek (projectile, ivy, etc)
(load-library "movements")              ;; movements, temporal and spatial

;;;;;;;;;;;;;;;; displays ;;;;;;;;;;;;;;;;
(load-library "display")                ;; for display enhancements to emacs
