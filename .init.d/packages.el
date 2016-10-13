(add-to-list 'load-path "~/.emacs.d/.init.d/packages/")

;;;;;;;;;;;;;;;; editings ;;;;;;;;;;;;;;;;
(load-library "editing")               ;; aids editing of texts/codes
(load-library "programming")           ;; configs for programming modes

;;;;;;;;;;;;;;;; navigations ;;;;;;;;;;;;;;;;
(load-library "finders")                ;; finders for things you seek (projectile, ivy, etc)
(load-library "movements")              ;; movements, temporal and spatial
