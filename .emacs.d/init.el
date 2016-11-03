;;created while reading mastering emacs
;; (setq package-archives
;;       '(("gnu" . "http://elpa.gnu.org/packages/")
;; 	("marmalade" . "http://marmalade-repo.org/packages/")
;; 	("melpa" . "http://melpa.milkbox.net/packages/")))

;;apropos- C-h a sort by relevancy
(setq apropos-sort-by-scores t)
;;ido mode with flex completion, a fuzzy completor
;;ido for directory finding and buffer switching
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)

;;undo-tree customisations
(package-initialize)
(require 'undo-tree)
(global-undo-tree-mode 1)

;;(global-set-key (kbd "C-z") 'undo)
;;(global-set-key (kbd "C-S-z") 'redo)
;;The above already happens with C-/ so anoop:
;;//(defalias 'redo 'undo-tree-redo)
;;//(global-set-key (kbd "C-z") 'redo)
;; note- C-x u gives an awesome visual feedback undo tree

;;winner-mode -
;; C-c right or left
;; to get to previous window configs
;;//(setq winner-mode 1)

;;(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-o") 'my-other-window)
;;single space ends sentence
(setq sentence-end-double-space nil)
;;imenu binding
(global-set-key (kbd "M-i") 'imenu)
;;helm installed via package manager
;;//(package-initialize)
;;//(require 'helm-config)
;;//(helm-mode 1)
;;helm google suggest
;;//(global-set-key (kbd "C-c h g") 'helm-google-suggest)
;;helm and ido overlap in functionality
;; helm -more features; ido - no distraction


;;I think a better way is to backward word kill
;;set C-w to cut whole line cursor is in if there is no selection
;;package installed for that
;;//(package-initialize)
;;//(require 'whole-line-or-region)
;;//(whole-line-or-region-mode 1)

;;backward word kill
;;(defun backward-kill-word-or-kill-region (&optional arg)
;;  (interactive "p")
;;  (if (region-active-mp)
;;      (kill-region (region-beginning) (region-end))
;;    (backward-kill-word arg)))
;;
;;(global-set-key (kbd "C-w") 'backward-kill-word-or-kill-region)

;;to do:
;;set someting to kill-word which is infact (forward) kill word
;;(global-set-key (kbd "something") 'kill-word)

;;//to do : autoload dtrace.l, sdraw.l, ppmx.l
;;set C-xe to a single key super = (slime-eval-last-expression)
;;(global-set-key (kbd "<menu>") 'slime-eval-last-expression)
;; take a look at parinfer plugin

;;must to do:
;;how to save and load lisp images of repl state






