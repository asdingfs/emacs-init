;;;;;;;;;;;;;;;; Movements ;;;;;;;;;;;;;;;;
(defun jump-to-mark () ;; rebinds C-u C-SPC, will pop local mark ring and move there
  (interactive)
  (set-mark-command 1))
(defun jump-to-global-mark () ;; rebinds C-x C-@, will pop global mark ring and move between buffers
  (interactive)
  (pop-global-mark))
(defun toggle-comment-on-line ()
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(defun kill-back-to-indentation ()
  "Kill from point back to the first non-whitespace character on the line."
  (interactive)
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos)))
(defun reindent-whole-buffer ()
  "Recompute indentation for the whole buffer."
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (indent-region (point-min) (point-max))
    (pop-mark) ;; do not store extra marks
    (pop-mark)))

;;;;;;;;;;;;;;;; Tramp ;;;;;;;;;;;;;;;;
;; TODO: figure out how to call ivy more elegantly, this is basically copy pasting
;; uses ivy methods for convenience
(defun tramp-completion-list (method)
  ;; provide a completion list, based on ivy and tramp-get-completion-function
  ;; METHOD is connection method to remote, can be ssh ftp, will be passed to (tramp-get-completion-function method)
  (let (clist)
    (dolist (x (tramp-get-completion-function method))
      (setq clist (append clist (funcall (car x) (cadr x)))))
    (setq clist (cl-delete-duplicates (delq nil clist) :test #'equal))
    (mapcar #'ivy-build-tramp-name clist)))
;; temporary convenience functions until better solutions can be found, I'm relatively happy with the hackish result
(defun dired-remote-alias (ssh-alias &optional arg)
  "Connect to remote with tramp, projectile alternative until it works"
  (interactive (list (ivy-read "Enter ssh-alias: "
                               (tramp-completion-list "ssh") )
                     (prefix-numeric-value current-prefix-arg)))
  (if (> arg 1)
      (dired (format "/ssh:%s|sudo:%s:" ssh-alias ssh-alias))
    (dired (format "/scp:%s:" ssh-alias))))
