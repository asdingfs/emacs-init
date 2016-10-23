;; main org configurations
(use-package org
  :commands (ox-twbs)
  :defer t
  :init
  (setq org-export-with-sub-superscripts nil))

;; exporting
(use-package ox-twbs ;; pretty html
  :after (org)
  :defer t)

;; display
(use-package org-bullets ;; bullets
  :after (org)
  :init
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  :defer t)
