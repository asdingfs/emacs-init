(use-package gnu-elpa-keyring-update
  :ensure t)

(let ((directory "~/.emacs.d/.init.d/packages/"))
  (dolist (filename '(org ;; most of org-mode configurations here
                      display ;; for display enhancements to emacs
                      unicode-fonts ;; support for unicode fonts in emacs
                      editing ;; aids editing of texts/codes
                      writing ;; configs for writing modes and environments
                      programming ;; configs for programming modes and environments
                      finders ;; finders for things you seek (projectile, ivy, etc)
                      movements ;; movements, temporal and spatial
                      org-roam-logseq ;; org-roam integration with logseq (make sure to place this last as this is custom library)
                      ))
    (load (format "%s%s" directory filename)))) ;; load each packages declared above

(require 'unicode-fonts)
(unicode-fonts-setup)
