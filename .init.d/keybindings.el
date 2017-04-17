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

;; movements
(global-set-key (kbd "H-<escape>") 'move-to-scratch-org)
(global-set-key (kbd "H-S-<escape>") 'move-to-scratch)

;; editings
(global-set-key (kbd "H-c") 'copy-line)                                 ;; copy ARGS line or region if mark-active, successive calls appends to the same kill ring
(global-set-key (kbd "H-d") 'duplicate-line)                          ;; duplicate a current line
(global-set-key (kbd "C-c C-<return>") (kbd "C-a C-j C-p TAB"))         ;; shift down line and begin with indentations
(global-set-key (kbd "C-<return>") (kbd "C-e C-j"))                     ;; shift cursor down and make a new line

;; custom keybinding functions
;; these are all defined in functions.el in the same directory
(global-set-key (kbd "C-`") 'jump-to-mark)
(global-set-key (kbd "C-~") 'jump-to-global-mark)

(global-set-key (kbd "C-;") 'toggle-comment-on-line)
(global-set-key (kbd "C-x C-;") 'comment-or-uncomment-region)

(global-set-key (kbd "H-<backspace>") 'kill-back-to-indentation)      ;; kill until beginning of line and indent
(global-set-key (kbd "C-M-|") 'reindent-whole-buffer)

(global-set-key (kbd "H-t") 'dired-remote-alias)

