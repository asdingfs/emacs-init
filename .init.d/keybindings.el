;;;;;;;;;;;;;;;; Keybindings ;;;;;;;;;;;;;;;;

;; rebindings
(global-set-key (kbd "H-r") 'rename-buffer)
(global-set-key (kbd "H-,") 'previous-buffer)
(global-set-key (kbd "H-.") 'next-buffer)
(global-set-key (kbd "H-[") 'windmove-up)
(global-set-key (kbd "H-'") 'windmove-right)
(global-set-key (kbd "H-/") 'windmove-down)
(global-set-key (kbd "H-;") 'windmove-left)

;; actions
(global-set-key (kbd "H-l") 'org-open-at-point-global)

;; custom key macros
(global-set-key (kbd "C-c C-SPC") (kbd "C-a C-SPC C-n M-w C-y C-b"))    ;; duplicate a current line
(global-set-key (kbd "C-c C-<return>") (kbd "C-a C-j C-p TAB"))         ;; shift down line and begin with indentations
(global-set-key (kbd "C-<return>") (kbd "C-e C-j"))                     ;; shift cursor down and make a new line

;; custom keybinding functions
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

(global-set-key (kbd "C-`") 'jump-to-mark)
(global-set-key (kbd "C-~") 'jump-to-global-mark)

(global-set-key (kbd "C-;") 'toggle-comment-on-line)
(global-set-key (kbd "C-x C-;") 'comment-or-uncomment-region)

(global-set-key (kbd "C-c C-<backspace>") 'kill-back-to-indentation)      ;; kill until beginning of line and indent
(global-set-key (kbd "C-M-|") 'reindent-whole-buffer)

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
      (dired (format "/scp:%s|sudo:%s:" ssh-alias ssh-alias))
    (dired (format "/scp:%s:" ssh-alias))))
(global-set-key (kbd "H-s") 'dired-remote-alias)

