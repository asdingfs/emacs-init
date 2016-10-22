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
(global-set-key (kbd "H-o") 'org-open-at-point-global)

;; custom key macros
(global-set-key (kbd "C-c C-SPC") (kbd "C-a C-SPC C-n M-w C-y C-b"))    ;; duplicate a current line
(global-set-key (kbd "C-c C-<return>") (kbd "C-a C-M-o TAB"))           ;; shift down line and begin with indentations
(global-set-key (kbd "C-c C-<backspace>") (kbd "C-0 C-k TAB"))          ;; kill until beginning of line and indent

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

(global-set-key (kbd "C-`") 'jump-to-mark)
(global-set-key (kbd "C-~") 'jump-to-global-mark)

(global-set-key (kbd "C-;") 'toggle-comment-on-line)
(global-set-key (kbd "C-x C-;") 'comment-or-uncomment-region)

