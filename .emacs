;; Turn off mouse interface early in startup to avoid momentary display
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;;load init.el
(load-file "~/.emacs.d/init.el")


;;path for lisp customisation files
;;whenever possible use package manager as it is updatable easily
;;//(add-to-list 'load-path "~/.emacs.d/anoop-lisp/")
;; Shut up compile saves
(setq compilation-ask-about-save nil)
;; disable startup screen
(setq inhibit-startup-message t)
;; empty scratch message
(setq initial-scratch-message nil)
;;start eshell
;;(eshell)
;;require melpa
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
	("melpa" . "http://melpa.milkbox.net/packages/")))
;;tomorrow night theme installed via melpa
;;(load-theme 'sanityinc-tomorrow-night t)
;;(load-theme 'sanityinc-tomorrow-eighties t)
;;(load-theme 'sanityinc-solarized-light t)
;;(load-theme 'sanityinc-solarized-dark t)
;;set initial directory
;;(setq default-directory "~/mastering-emacs/")
;;(setq default-directory "~/pglisp/")
;;//(setq default-directory "~/pcl/")
;; set font
;;(set-default-font "Consolas 14")
;;(set-default-font "Monaco 13")
(set-default-font "Menlo 14")
;;(set-default-font "Source code pro 14")
;;(set-default-font "Source code pro 12")
;; linium relative line numbering
;;//(require 'linum-relative)
;; hook linum mode for all programming modes and text modes
;;//(add-hook 'prog-mode-hook 'linum-mode)
;;//(add-hook 'text-mode-hook 'linum-mode)
;;//(add-hook 'eshell-mode-hook (lambda () (linum-mode 1)))

;; multiple cursors
;; i am yet to learn to use this like in sublime text
;;//(require 'multiple-cursors)
;;//(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;;//(global-set-key (kbd "C->") 'mc/mark-next-like-this)
;;//(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;;//(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; y or n as yes/no
(fset 'yes-or-no-p 'y-or-n-p)
;; In freebsd no need to set proxy in .emacs file, it picks it up from setenv automatically
;;(setq inferior-lisp-program "/usr/local/bin/clisp")
;;//(load (expand-file-name "~/quicklisp/slime-helper.el"))
;;//          (setq inferior-lisp-program "/usr/local/bin/sbcl --core /home/anoop/anoop-lisp-repl-images/sbcl-slime")
;;//(setq slime-contribs '(slime-fancy))

;; turn on automatic bracket insertion by pairs
(electric-pair-mode 1)
;; rainbow delimiter mode
;;//(load-file "~/.emacs.d/anoop-lisp/rainbow-delimiters.elc")
;;(require 'rainbow-delimiters)
;;//(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;; highlight parenthesis
(show-paren-mode 1)

;; Setup load-path, autoloads and your lisp system
;; Not needed if you install SLIME via MELPA
;(load-file "~/Downloads/slime-master/slime.el")
;(add-to-list 'load-path "~/Downloads/slime-master")
;;(require 'slime-autoloads

;; all backups into ~/emacs-backups/
(setq backup-directory-alist '(("." . "~/emacs-backups/")))
;; open ansi file on startup
;;(find-file "~/pglisp/ansi_l.l")
;;//(slime)
;;(split-window-vertically)
;;//(delete-other-windows)
(defun set-dedicated-window ()
  "Dedicate current window to the buffer it is currently showing. 
Useful for dirtree or other content you do not want Emacs to hide."
  (interactive)
  (let ( (window (frame-selected-window)) )
    (set-window-dedicated-p window t)))

(defun reset-dedicated-window ()
  "Release a window, so that it can be used to show any buffer."
  (interactive)
  (let ( (window (frame-selected-window)) )
    (set-window-dedicated-p window nil)))

;;//(split-window-horizontally)
;;(find-file "~/pglisp/ansi_l.l")
;;//(find-file "~/pcl/pcl.lisp")
;;(find-file "~/lol/lol.l")
;;(find-file "~/david/david.l")
;;(find-file "~/mastering-emacs/scratch.l")
;;//(set-dedicated-window)
;; initial buffer ordering and dedicated window setup

;;//(set-dedicated-window)
;;//(other-window 1)
;;//(switch-to-buffer "*slime-repl sbcl*")
;;//(split-window-vertically)
;;//(set-dedicated-window)
;;//(other-window 2)
;; save cursor position in a file
;; for some reason doesnt work?
;;//(require 'saveplace)
;;//(setq-default save-place t)

;;sdraw tool to draw cons cells
;;(add-to-list 'load-path "~/david/")
;;(load-file "/home/anoop/david/sdraw.el")
;;(load "sdraw.el")
;;(require 'sdraw)

;; rainbow delimiter customise color weight
;;//(require 'cl-lib)
;;//(require 'color)
;;//(cl-loop
;;// for index from 1 to rainbow-delimiters-max-face-count
;;// do
;;// (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
;;//   (cl-callf color-saturate-name (face-foreground face) 30)))

;;to do
;;how to save and load lisp images of repl


;;disable mouse scrolling
;;(mouse-wheel-mode -1)
;;(global-set-key [wheel-up] 'ignore)
;;(global-set-key [wheel-down] 'ignore)
;;(global-set-key [double-wheel-up] 'ignore)
;;(global-set-key [double-wheel-down] 'ignore)
;;(global-set-key [triple-wheel-up] 'ignore)
;;(global-set-key [triple-wheel-down] 'ignore)
;;(global-set-key [triple-wheel-right] 'ignore)
;;(global-set-key [triple-wheel-left] 'ignore)

;; buffer-list auto update
(add-hook 'Buffer-menu-mode-hook (lambda () (auto-revert-mode 1)))
;; save all buffers when emacs loses focus
(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))

;;meta key modifications for mac
(setq mac-command-key-is-meta nil)
(setq mac-command-modifier 'super)
(setq mac-option-key-is-meta t)
(setq mac-option-modifier 'meta)
;;show filename in menu bar
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;;set Cmd+Q to quit emacs
(global-set-key (kbd "s-q")  'save-buffers-kill-terminal)

;;make prompt and previous output uneditable in shell
(defun my-comint-preoutput-turn-buffer-read-only (text)
  (propertize text 'read-only t))
(add-hook 'comint-preoutput-filter-functions 'my-comint-preoutput-turn-buffer-read-only)

;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-up (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-down (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-left (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-right (before other-window-now activate)
  (when buffer-file-name (save-buffer)))

;;// to do install lua-mode for syntax high
;;enable linum mode in all buffers

;;scrolling
;;keep cursor at same position when scrolling
(setq scroll-preserve-screen-position 1)
;;scroll window up/down by one line
(global-set-key (kbd "M-n") (kbd "C-u 3 C-v"))
(global-set-key (kbd "M-p") (kbd "C-u 3 M-v"))
;;windmove window switching activate
(windmove-default-keybindings)
;;delete key to kill window and buffer
(global-set-key (kbd "<deletechar>")  'kill-buffer-and-window)
;;ask for shell name on M-x shell
(defun cs ()
    "cs = creates a shell with a given name"
    (interactive);; "Prompt\n shell name:")
    (let ((shell-name (read-string "shell name: " nil)))
    (shell (concat "*" shell-name "*"))))
;;enter should indent as well
(define-key text-mode-map (kbd "RET") 'newline-and-indent)
;;(define-key org-mode-map (kbd "RET") 'newline-and-indent) ;; this will disable table new row feature on RET

;;C-o should indent as well
(defun open-line-and-indent (&optional n)
  "Like open-line, but the line that is moved down is re-indented."
  (interactive "p")
  (open-line n)
  (save-excursion
    (forward-line n)
    (indent-according-to-mode)))

(global-set-key (kbd "C-o") 'open-line-and-indent) ;replaces open-line

;; ;;C-k should inden as well;;buggy!!!!!
;; (defun kill-line-and-indent (&optional n)
;;   "Like open-line, but the line that is moved down is re-indented."
;;   (interactive "p")
;;   (kill-line n)
;;   (indent-according-to-mode))

;; (global-set-key (kbd "C-k") 'kill-line-and-indent) ;replaces kill-line

;;pdf-tools install
;;(pdf-tools-install)

;;some shortcuts; anoop
;;(fset 'pdf-view-previous-page "\C-xo\C-xo\C-x[\C-xo")
;;(fset 'pdf-view-next-page "\C-xo\C-xo\C-x]\C-xo")
;;(global-set-key (kbd "M-[") 'pdf-view-previous-page)
;;(global-set-key (kbd "M-]") 'pdf-view-next-page)
;;temp
;;(global-set-key (kbd "<left>") 'pdf-view-previous-page)
;;(global-set-key (kbd "<right>") 'pdf-view-next-page)


;;;;doc-view-mode

;;retina resolution 300 is enough?
(setq doc-view-resolution 300)

;;setup for 2 window with pdf doc in the other window
;; view docs
;;(fset 'doc-prev "\C-xo\C-xo\C-x[\C-xo")
;;(fset 'doc-next "\C-xo\C-xo\C-x]\C-xo")
;;(global-set-key (kbd "M-[") 'doc-prev)
;;(global-set-key (kbd "M-]") 'doc-next)

;;//to do: install packages if not installed like emacs-rocks's .emacs file


;;avoid windows in M-o command
;; my-other-window doesn't implement all the features other-window does
(require 'cl)
;;(defvar avoid-window-regexp "^[0-9]$")
(defvar avoid-window-regexp "manber.pdf")
(defun my-other-window ()
  "Similar to 'other-window, only try to avoid windows whose buffers match avoid-window-regexp"
  (interactive)
  (let* ((window-list (delq (selected-window) (window-list)))
         (filtered-window-list (remove-if
                                (lambda (w)
                                  (string-match-p avoid-window-regexp (buffer-name (window-buffer w))))
                                window-list)))
    (if filtered-window-list
        (select-window (car filtered-window-list))
      (and window-list
           (select-window (car window-list))))))
;;auto save when using my-other-window 
(defadvice my-other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))

;;PHP
(defun my-setup-php ()
  ;; enable web mode
  (web-mode)

  ;; make these variables local
  (make-local-variable 'web-mode-code-indent-offset)
  (make-local-variable 'web-mode-markup-indent-offset)
  (make-local-variable 'web-mode-css-indent-offset)

  ;; set indentation, can set different indentation level for different code type
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2))
;; setup files ending in “.php” to open in my-setup-php
(add-to-list 'auto-mode-alist '("\\.php$" . my-setup-php))

;;html file in web-mode
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

;;css file in web-mode
(add-to-list 'auto-mode-alist '("\\.css$" . web-mode))

;; ;;emacs-nav written by a google engineer
;; (require 'nav)
;; (nav-disable-overeager-window-splitting)
;; (nav-toggle)
;; ;; Optional: set up a quick key to toggle nav
;; (global-set-key [f12] 'nav-toggle)

;;js
(setq js-indent-level 2)
;;load the xah-quick-run
;; (load-file "~/.emacs.d/xah-quickrun.el")
;; (global-set-key (kbd "C-x C-e") 'xah-run-current-file)
;; (global-set-key (kbd "C-x e") 'xah-run-current-file)

(add-hook 'after-init-hook #'neotree-toggle)
(custom-set-variables
 '(neo-window-position (quote right)))

;;always show line numbers
(global-linum-mode 1)
;;show column numbers with line number
(column-number-mode)

;;web mode manual installation
(load-file "~/.emacs.d/web-mode/web-mode.el")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)

;; Run C programs directly from within emacs
(defun execute-c-program ()
  (when (buffer-modified-p) (save-buffer))
  (interactive)
  (defvar foo)
  (setq foo (concat "g++ -std=c++0x -W -Wall -Wno-sign-compare -O2 " (buffer-name) " && ./a.out" ))
  (shell-command foo))

;; todo set this only for .c files
(global-set-key (kbd "C-x e") 'execute-c-program)
(global-set-key (kbd "C-x C-e") 'execute-c-program)

;; Toggle between web-mode and html-mode for jsx files anoop
(defun toggle-for-jsx ()
  (interactive)
  (if (string= major-mode "web-mode")
      (html-mode)
    (if (string= major-mode "html-mode")
	(web-mode))))
(global-set-key (kbd "M-<tab>") 'toggle-for-jsx)

;;load the appointment reminder
(load-file "~/.emacs.d/appt-anoop.el")
;; Diary entries notification ;;http://wenshanren.org/?p=676
;; (require 'appt)
;; (setq appt-message-warning-time 0)      ; 0 minute time before warning
;; (setq diary-file "~/diary")             ; diary file
;; (appt-activate 1)
;;hide the fancy diary entries anoop:

;; now make that buffer uninteresting
;; (other-window 2)			;switch to it
;; (defun make-buffer-uninteresting ()
;;   "rename the current buffer to begin with a space"
;;   (interactive)
;;   (unless (string-match-p "^ " (buffer-name))
;;     (rename-buffer (concat " " (buffer-name)))))

;; change to powerline fonts when in shell mode to get oh-my-git to work
(defun my-buffer-face-mode-powerline ()
    (setq buffer-face-mode-face '(:family "SourceCodePro+Powerline+Awesome Regular"))
    (buffer-face-mode))

(add-hook 'shell-mode-hook 'my-buffer-face-mode-powerline)

;;kgp proxy
(setq url-proxy-services '(("no_proxy" . "127.0.0.1")
                          ("http" . "10.3.100.207:8080")
			   ("https" . "10.3.100.207:8080")))

;;to do : learn about c++ compile flags
;; simon google code jam recommends:
;; alias c 'g++ -Wall -g -O1 -fsanitize=undefined -Wconversion -D_GLIBCXX_DEBUG -D_GLIBC_DEBUG -std=c++11'

;;rgrep ignore .meteor/ directory
(eval-after-load "grep"
  '(progn
    (add-to-list 'grep-find-ignored-directories ".meteor")
    (add-to-list 'grep-find-ignored-directories ".git")
    (add-to-list 'grep-find-ignored-directories "node_modules")))

;;todo smooth scrolling

