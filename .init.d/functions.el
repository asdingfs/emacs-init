;;;;;;;;;;;;;;;; Movements ;;;;;;;;;;;;;;;;
(defun jump-to-scratch ()
  "Switch to buffer named *scratch* and create if it does not exist"
  (interactive)
  (switch-to-buffer
   (get-buffer-create "*scratch*")))
(defun jump-to-working-memory ()
  "immediately jump to my working-memory org file"
  (interactive)
  (find-file "~/.emacs.d/.personal.d/org/notes/working-memory.org"))
(defun magit-on-init-dir ()
  "immediately run magit-status on emacs init directory .emacs.d"
  (interactive)
  (magit-status "~/.emacs.d"))
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

(defun counsel-projectile-switch-project-action-dwim (project)
  "Jump to a file in PROJECT."
  (let ((projectile-switch-project-action
         (lambda () (magit-status-on-toplevel-if-possible))))
    (counsel-projectile-switch-project-by-name project)))

(defun magit-status-on-toplevel-if-possible ()
  "If the project being switched to is a git repository, invoke
magit-status on the project root directory. Use dired otherwise."
  (interactive)
  (if (and (executable-find "git")
           (eq (projectile-project-vcs) 'git)
           (string-equal (magit-toplevel) (projectile-project-root)))
      (magit-status (projectile-project-root))
    (find-file (projectile-project-root))))

;;;;;;;;;;;;;;;; Editings ;;;;;;;;;;;;;;;;
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring.
    Ease of use features:
    - Move to start of next line
    - Appends the copy on sequential calls
    - Use newline as last char even on the last line of the buffer
    - If region is active, copy its lines."
  (interactive "p")
  (let ((b (line-beginning-position))
        (e (line-end-position arg)))
    (when mark-active
      (if (> (point) (mark))
          (setq b (save-excursion (goto-char (mark)) (line-beginning-position)))
        (setq e (save-excursion (goto-char (mark)) (line-end-position)))))
    (if (eq last-command 'copy-line)
        (kill-append (buffer-substring b e) (< e b))
      (kill-ring-save b e)))
  (kill-append "\n" nil)
  (beginning-of-line (or (and arg (1+ arg)) 2))
  (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

(defun duplicate-line ()
  "Deactivate any active mark, duplicates current line, saves horizontal position, and moves to the next line"
  (interactive)
  (save-excursion
    (deactivate-mark)
    (copy-line nil)
    (yank))
  (next-line))

(defun top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))

(defun open-line-and-indent (arg)
  "Call open line and immediately indent the next line"
  (interactive "p")
  (save-excursion
    (open-line arg)
    (indent-according-to-mode)
    (next-line 1)
    (indent-according-to-mode)))

;;;;;;;;;;;;;;;; Tramp ;;;;;;;;;;;;;;;;
;; set default remote shell to use
(defun set-default-remote-shell ()
  "Function to set remote shell to default, not following current environment"
  (when (file-remote-p (buffer-file-name))
    (setq-local shell-file-name "/bin/bash")))
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
;; method required to convert prefix-numeric-value to number of times prefix C-u is pressed
(defun safe-positive-log-4 (arg)
  "If arg < 1 return 0, otherwise return (log arg 4)"
  (let ((sanitised-arg (if (< arg 1) 1 arg)))
    (truncate (log sanitised-arg 4))))
;; temporary convenience functions until better solutions can be found, I'm relatively happy with the hackish result

(defun dired-remote-alias (ssh-alias &optional arg)
  "Connect to remote with tramp, projectile alternative until it works"
  (interactive (list (ivy-read "Enter ssh-alias: "
                               (tramp-completion-list "ssh") )
                     (prefix-numeric-value current-prefix-arg)))
  (let ((times (safe-positive-log-4 arg)))
    (cond
     ((= 1 times) ;; select method of connection, e.g. ssh, scp
      (dired (format "/%s:%s:"
                     (read-string "Enter connection type: ") ssh-alias ssh-alias)))
     ((= 2 times) ;; ssh as root
      (dired (format "/ssh:%s|sudo:%s:" ssh-alias ssh-alias)))
     (t ;; else, connect normally using user specified in ~/.ssh/config
      (dired (format "/ssh:%s:" ssh-alias))))))
