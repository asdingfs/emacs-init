;;;;;;;;;;;;;;;; Keybindings ;;;;;;;;;;;;;;;;

;; rebindings
(global-set-key (kbd "H-r") 'rename-buffer)
(global-set-key (kbd "H-,") 'previous-buffer)
(global-set-key (kbd "H-.") 'next-buffer)
(global-set-key (kbd "H-[") 'windmove-up)
(global-set-key (kbd "H-'") 'windmove-right)
(global-set-key (kbd "H-/") 'windmove-down)
(global-set-key (kbd "H-;") 'windmove-left)
(global-set-key (kbd "s-w") 'kill-buffer-and-window)

;; commands
(global-set-key (kbd "H-l") 'org-open-at-point-global)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "H--") 'text-scale-decrease)
(global-set-key (kbd "H-=") 'text-scale-increase)
(global-set-key (kbd "H-0") 'text-scale-100%)

;; movements
(global-set-key (kbd "H-<escape>") 'jump-to-working-memory)
(global-set-key (kbd "H-M-<escape>") 'jump-to-capture)
(global-set-key (kbd "H-S-<escape>") 'jump-to-scratch)
(global-set-key (kbd "C-M-<escape>") 'magit-on-init-dir)

;; editings
(global-set-key (kbd "C-+") 'copy-line) ;; copy ARGS line or region if mark-active, successive calls appends to the same kill ring
(global-set-key (kbd "H-d") 'duplicate-line) ;; duplicate a current line
(global-set-key (kbd "C-S-<return>") (kbd "C-a C-j C-p TAB")) ;; shift down line and begin with indentations
(global-set-key (kbd "C-<return>") (kbd "C-e C-j")) ;; shift cursor down and make a new line

;; custom keybinding functions
;; these are all defined in functions.el in the same directory
;; movements
(global-set-key (kbd "C-`") 'jump-to-mark)
(global-set-key (kbd "C-~") 'jump-to-global-mark)

;; editing
(global-set-key (kbd "C-;") 'toggle-comment-on-line)
(global-set-key (kbd "C-x C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "H-<backspace>") 'kill-back-to-indentation)      ;; kill until beginning of line and indent
(global-set-key (kbd "C-M-|") 'reindent-whole-buffer)
(global-set-key (kbd "M-/") 'completion-at-point)
(global-set-key (kbd "C-^") 'top-join-line)
(global-set-key (kbd "C-S-o") 'open-line-and-indent)

;; externals
(global-set-key (kbd "H-t") 'dired-remote-ssh-alias)
(global-set-key (kbd "H-g") 'magit-status)
(global-set-key (kbd "H-k") 'kubernetes-overview)
(global-set-key (kbd "H-K") 'dired-remote-kubectl-alias)
(global-set-key (kbd "H-)") 'eshell)
(global-set-key (kbd "H-(") 'term)

