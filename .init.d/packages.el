(let ((directory "~/.emacs.d/.init.d/packages/"))
  (dolist (filename '(display ;; for display enhancements to emacs
                      exports ;; most of org-mode configurations here
                      editing ;; aids editing of texts/codes
                      writing ;; configs for writing modes and environments
                      programming ;; configs for programming modes and environments
                      finders ;; finders for things you seek (projectile, ivy, etc)
                      movements)) ;; movements, temporal and spatial
    (load (format "%s%s" directory filename)))) ;; load each packages declared above
