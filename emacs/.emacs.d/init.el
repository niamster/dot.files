; defined in ~/.Xdefaults
;(set-default-font "Dejavu Sans Mono-6")
;(set-default-font "-bitstream-bitstream vera sans mono-bold-r-normal--10-8-*-*-m-*-iso8859-1")
;(set-default-font "-misc-dejavu sans mono-medium-r-normal--10-8-*-*-m-*-iso8859-1")

; fg/bg colors
(if window-system
    (setq default-frame-alist
          '(
            (background-color . "black")
            (foreground-color . "RoyalBlue")
            (left-fringe . 1) (right-fringe . 1)
            )
          )

  (set-background-color "black")
  (set-foreground-color "green")
  (menu-bar-mode nil)
  )

(setq frame-title-format '("" "%b:" default-directory))

; fullscreen mode
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
					   (if (frame-parameter nil 'fullscreen)
						   nil 'fullboth))
  )
(global-set-key [f11] 'fullscreen)

;server
(setq server-use-tcp t)
(setq server-host "0.0.0.0")
(defun run-server()
  (interactive)
  (setq server-name (read-string "Server name:"))
  (message "Don't forget to copy ~/.emacs.d/server/%s to host" server-name)
  (server-start)
  )
(global-set-key (kbd "C-c s") 'run-server)


; locale
(setq current-language-environment "UTF-8")
(setq default-input-method "russian-computer")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)

; highlighting
(setq font-lock-maximum-decoration 3)
(global-font-lock-mode t)

; hi-lock
(defface hi-brown  '((t (:foreground "#cd3333"))) "hi- face" :group 'hi-lock-faces)
(defface hi-orange '((t (:foreground "#cd6600"))) "hi- face" :group 'hi-lock-faces)
(defface hi-white  '((t (:foreground "#ffffff"))) "hi- face" :group 'hi-lock-faces)
(defface hi-cyan   '((t (:foreground "#00ffff"))) "hi- face" :group 'hi-lock-faces)
(defface hi-purple '((t (:foreground "#a020f0"))) "hi- face" :group 'hi-lock-faces)
(defface hi-fgreen '((t (:foreground "#228b22"))) "hi- face" :group 'hi-lock-faces)
(defface hi-yellow '((t (:foreground "#ffff00"))) "hi- face" :group 'hi-lock-faces)
(defface hi-blue   '((t (:foreground "#0000ff"))) "hi- face" :group 'hi-lock-faces)
(defface hi-green  '((t (:foreground "#00ff00"))) "hi- face" :group 'hi-lock-faces)
(defface hi-red    '((t (:foreground "#ff0000"))) "hi- face" :group 'hi-lock-faces)
(defface hi-pink   '((t (:foreground "#ff1595"))) "hi- face" :group 'hi-lock-faces)
(defface hi-red-b    '((t (:background "#ff0000"))) "hi- face" :group 'hi-lock-faces)
(defface hi-black-b  '((t (:background "#000000"))) "hi- face" :group 'hi-lock-faces)
(defface hi-black-hb '((t (:background "#000000"))) "hi- face" :group 'hi-lock-faces)
(defface hi-green-b  '((t (:background "#00ff00"))) "hi- face" :group 'hi-lock-faces)
(defface hi-blue-b   '((t (:background "#0000ff"))) "hi- face" :group 'hi-lock-faces)
(defface hi-pink     '((t (:background "#ff1595"))) "hi- face" :group 'hi-lock-faces)
(global-hi-lock-mode t)

; highlight parent brace
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'parenthesis)
(set-face-background 'show-paren-match-face "green")
(set-face-attribute 'show-paren-match-face nil :weight 'bold :underline nil :overline nil :slant 'normal)
(set-face-foreground 'show-paren-mismatch-face "red")
(set-face-attribute 'show-paren-mismatch-face nil :weight 'bold :underline t :overline nil :slant 'normal)

; highlight additional keywords NOTE TODO FIXME BUG DEBUG
(setq assertface '((:foreground "#d7ff00" :weight bold)))
(setq keysface '((:foreground "#d7ff00" :underline t :weight bold)))
(setq bugface '((:foreground "#ff0000" :weight bold)))
(setq debugkeyface '((:foreground "#00cdcd" :weight bold)))
(setq keys '(
             ("\\(FIXME\\|TODO\\|NOTE\\)" 1 keysface t)
             ("[^E]\\(BUG\\)" 1 bugface t)
             ("[^E]\\(BUG_ON\\)" 1 bugface t)
             ("\\(WARN_ON[A-Z_]*\\)" 1 assertface t)
             ("\\([A-Z_]*ASSERT[A-Z_]*\\)" 1 assertface t)
             ("\\([A-Z_]*DEBUG[A-Z_]*\\)" 1 debugkeyface t)
             )
      )
(font-lock-add-keywords 'c-mode keys)
(font-lock-add-keywords 'c++-mode keys)
(font-lock-add-keywords 'emacs-lisp-mode keys)
(font-lock-add-keywords 'python-mode keys)

(defface font-lock-function-call-face '((t (:foreground "forest green"))) "Font Lock mode face used to highlight function calls." :group 'font-lock-highlighting-faces)
(defvar font-lock-function-call-face 'font-lock-function-call-face)
(defun font-lock-function-call-hook ()
  (font-lock-add-keywords
   nil
   '(("\\<\\([a-zA-Z0-9_]+\\) ?(" 1 font-lock-function-call-face))
   t)
  )
(add-hook 'c-mode-hook 'font-lock-function-call-hook)
(add-hook 'c++-mode-hook 'font-lock-function-call-hook)

; highlight #if 0
(defface if0face '((t (:foreground "#cccccc"))) "#if 0 face" :group 'basic-faces)
(setq cpp-known-face 'default)
(setq cpp-unknown-face 'default)
(setq cpp-known-writable 't)
(setq cpp-unknown-writable 't)
(setq cpp-edit-list '(("0" if0face default both)
                      ("1" default if0face both)))
(defun cpp-font-lock-if0 (limit)
  (cpp-highlight-buffer t)
  nil)
(defun cpp-font-lock-if0-hook ()
  (font-lock-add-keywords
   nil
   '((cpp-font-lock-if0 (0 if0face prepend)))
   'add-to-end))
(add-hook 'c-mode-hook 'cpp-font-lock-if0-hook)
(add-hook 'c++-mode-hook 'cpp-font-lock-if0-hook)

; misc staff
(transient-mark-mode t) ; highlight the region whenever it is active
(auto-compression-mode t) ; uncompress files before displaying them
(setq make-backup-files nil)
(setq scroll-conservatively most-positive-fixnum) ; scroll only one line when move past the bottom of the screen
(setq scroll-down-aggressively 0.0)
(setq scroll-margin 0)
(setq scroll-step 1)
(setq scroll-up-aggressively 0.0)
(fset 'yes-or-no-p 'y-or-n-p) ; make the y or n suffice for a yes or no question
(setq comment-style 'indent)
(delete-selection-mode t) ; replace highlighted text with what typed
(setq case-fold-search nil) ; case-sensitive search
(setq inhibit-startup-message t) ; do not show startup message
(column-number-mode t) ; column-number in the mode line
(setq pop-up-windows nil) ; stop emacs from changing window configuration
(setq confirm-nonexistent-file-or-buffer nil) ; stop emacs from prompting you whenever a new file is created

; woman in same frame
(setq woman-use-own-frame nil)

; dired ls options
(setq dired-listing-switches "-l --group-directories-first -h -G -a")

; search: toggle case, edit search string
(add-hook 'isearch-mode-hook
		  (lambda ()
			(define-key isearch-mode-map (kbd "C-c") 'isearch-toggle-case-fold)
			(define-key isearch-mode-map (kbd "C-j") 'isearch-edit-string)
			)
		  )

; give 5 secs to think before killing emacs
(setq confirm-kill-emacs
	  (lambda (e)
		(y-or-n-p-with-timeout
		 "Really exit Emacs (automatically exits in 5 secs)? " 5 t)
		)
	  )


; up/low case region
(put 'upcase-region 'disabled nil) ; enable C-x C-u for upcase region
(put 'downcase-region 'disabled nil) ; enable C-x C-l for downcase region
; M-l : Convert following word to lower case
; M-u : Convert following word to upper case

; treat word with uppercase and lowercase letters as different words
(defun subword-hook ()
  (if (fboundp 'subword-mode)
      (subword-mode)
	(c-subword-mode)
	)
  )
(add-hook 'c-mode-hook 'subword-hook)
(add-hook 'c++-mode-hook 'subword-hook)
(add-hook 'text-mode-hook 'subword-hook)
(add-hook 'asm-mode-hook 'subword-hook)
(add-hook 'python-mode-hook 'subword-hook)
(add-hook 'emacs-lisp-mode-hook 'subword-hook)

; backspace to delete character backwards
(define-key key-translation-map "\177" (kbd "C-="))
(define-key key-translation-map (kbd "C-=") "\177")
(global-set-key "\177" 'delete-backward-char)
(global-set-key (kbd "C-=") 'delete-backward-char)
(global-set-key (kbd "C-M-=") 'backward-kill-word)

; keybinding
(global-set-key (kbd "C-x g") 'gdb) ; gdb
(global-set-key (kbd "C-x m") 'woman) ; man
(global-set-key (kbd "M-g") 'goto-line) ; go to line
(global-set-key (kbd "M-t") 'tab-to-tab-stop) ; inserts indentation before point
(global-set-key (kbd "C-x C-b") 'ibuffer) ; buffers menu in the same window
(global-set-key (kbd "C-s") 'isearch-forward-regexp) ; search regexp forward
(global-set-key (kbd "C-r") 'isearch-backward-regexp) ; search regexp backward
(global-set-key (kbd "RET") 'newline-and-indent) ; indent after return pressed
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "TAB") 'indent-according-to-mode)
(global-set-key (kbd "C-i") 'indent-according-to-mode)
(global-set-key (kbd "C-j") (lambda () (interactive) (end-of-line) (newline-and-indent))) ; newline and indent
(global-set-key (kbd "C-x C-d") 'dired) ; open dired
(global-set-key (kbd "C-x C-g") 'rgrep) ; find in files
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

; buffer navigation
(define-prefix-command 'buffer-nav-map)
(define-key buffer-nav-map "b" 'windmove-left)
(define-key buffer-nav-map "f" 'windmove-right)
(define-key buffer-nav-map "p" 'windmove-up)
(define-key buffer-nav-map "n" 'windmove-down)
(global-set-key (kbd "C-x n") buffer-nav-map)

(defun disable-key (keymap oldkey newkey)
  "Disable a keybinding, and replace it with a message of what key to use."
  (define-key keymap oldkey
    (list 'lambda ()
          "Disabled key"
          '(interactive)
          (list 'message "Key disabled, use %s instead" newkey)
          )
    )
  )

(defun move-key (keymap oldkey newkey)
  "Move a local key binding to a new key and install a disabled message in the old one."
  (define-key keymap newkey (lookup-key keymap oldkey))
  (disable-key keymap oldkey newkey)
  )

(defun global-move-key (oldkey newkey)
  "Move a global key binding to a new key and install a disabled message in the old one."
  (move-key (current-global-map) oldkey newkey)
  )

(global-move-key (kbd "<home>") (kbd "C-a"))
(global-move-key (kbd "<end>") (kbd "C-e"))
(global-move-key (kbd "<next>") (kbd "C-v"))
(global-move-key (kbd "<prior>") (kbd "M-v"))
(global-move-key (kbd "<left>") (kbd "C-b"))
(global-move-key (kbd "<right>") (kbd "C-f"))
(global-move-key (kbd "<up>") (kbd "C-p"))
(global-move-key (kbd "<down>") (kbd "C-n"))

; frame control
(global-set-key (kbd "C-x 5 3") 'make-frame-on-display)
; C-z     : Minimize (or “iconify) the selected Emacs frame (suspend-frame)
; C-x 5 0 : Delete the selected frame (delete-frame)
; C-x 5 o : Select another frame, raise it, and warp the mouse to it.
; C-x 5 1 : Delete all frames except the selected one.
; C-x 5 2 : Create a new frame
; C-x 5 b : Select buffer bufname in another frame
; C-x 5 f : Visit file filename and select its buffer in another frame
; C-x 5 d : Select a Dired buffer for directory directory in another frame

(move-key minibuffer-local-map (kbd "<up>") (kbd "C-p"))
(move-key minibuffer-local-map (kbd "<down>") (kbd "C-n"))
(move-key minibuffer-local-map (kbd "<right>") (kbd "C-f"))
(move-key minibuffer-local-map (kbd "<left>") (kbd "C-b"))

(global-unset-key (kbd "C-x <left>"))
(global-unset-key (kbd "C-x <right>"))

; duplicate the line and comment the first
(defun duplicate-comment-line ()
  (interactive)
  (beginning-of-line)
  (push-mark)
  (end-of-line)
  (let ((str (buffer-substring (region-beginning) (region-end))))
    (comment-region (region-beginning) (region-end))
    (insert-string
      (concat (if (= 0 (forward-line 1)) "" "\n") str "\n"))
    (forward-line -1)
    )
  )
(global-set-key (kbd "C-c c") 'duplicate-comment-line)

; Wrap marked region with #if 0/#endif
(defun wrap-if-0 ()
  (interactive)
  (save-excursion
    (goto-char (region-beginning))
    (if (/= (region-beginning) (line-beginning-position))
        (insert "\n")
      )
    (insert "#if 0\n")
    )
  (save-excursion
    (goto-char (region-end))
    (insert "\n#endif")
    (if (/= (region-end) (line-end-position))
        (insert "\n")
      )
    )
  )
(global-set-key (kbd "C-x M-0") 'wrap-if-0)

; killing and yanking lines
(defun copy-whole-line ()
  (interactive)
  (kill-new (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
  )
(defun copy-indent-line ()
  (interactive)
  (setq cpoint (point))
  (back-to-indentation)
  (setq bpoint (point))
  (kill-new (buffer-substring-no-properties bpoint (line-end-position)))
  (goto-char cpoint)
  )
(defun kill-total-line ()
  (interactive)
  (let ((kill-whole-line t))
	(beginning-of-line)
	(kill-line)
	(setq top (car kill-ring))
	(setq last (substring top -1))
	(if (string-equal last "\n")
		(let ()
		  (setq stripped (substring top 0 -1))
		  (setq kill-ring (cons stripped (cdr kill-ring)))
		  )
	  )
	)
  )
(defun yank-line-after ()
  (interactive)
  (end-of-line)
  (newline)
  (yank)
  )
(defun yank-indent-line-after ()
  (interactive)
  (end-of-line)
  (newline-and-indent)
  (yank)
  )
(global-set-key (kbd "M-P") 'copy-whole-line)
(global-set-key (kbd "M-I") 'copy-indent-line)
(global-set-key (kbd "C-k") 'kill-total-line)
(global-set-key (kbd "M-p") 'yank-line-after)
(global-set-key (kbd "M-i") 'yank-indent-line-after)

; window spliting
(defun split-window-horizontally-other ()
  (interactive)
  (split-window-horizontally)
  (other-window 1)
  )
(defun split-window-vertically-other ()
  (interactive)
  (split-window-vertically)
  (other-window 1)
  )
(global-set-key (kbd "C-x 3") 'split-window-horizontally-other)
(global-set-key (kbd "C-x 2") 'split-window-vertically-other)

; string/regexp replacing
(defun replace-string-in-buffer ()
  (interactive)
  (setq cpoint (point))
  (setq needle (read-string "Replace string:"))
  (setq replacement (read-string "Replace with:"))
  (goto-char 1)
  (replace-string needle replacement)
  (goto-char cpoint)
  )
(defun replace-regexp-in-buffer ()
  (interactive)
  (setq cpoint (point))
  (setq needle (read-string "Replace regexp:"))
  (setq replacement (read-string "Replace with:"))
  (goto-char 1)
  (replace-regexp needle replacement)
  (goto-char cpoint)
  )
(global-set-key (kbd "M-C-s") 'replace-string-in-buffer)
(global-set-key (kbd "M-C-r") 'replace-regexp-in-buffer)

; region indentation
(defun unindent-region ()
  (interactive)
  (indent-region (region-beginning) (region-end) -1)
)
(global-set-key (kbd "C-x TAB") 'indent-region)
(global-set-key (kbd "C-x <backtab>") 'unindent-region)

; cursor color
(defun set-cursor-according-to-mode ()
  "change cursor color and type according to some minor modes."
  (cond
    (buffer-read-only
      (set-cursor-color "grey")
      (setq cursor-type 'hbar)
      )
    (overwrite-mode
      (set-cursor-color "red")
      (setq cursor-type 'block)
      )
    (t
      (set-cursor-color "yellow")
      (setq cursor-type 'bar)
      )
    )
  )
(add-hook 'post-command-hook 'set-cursor-according-to-mode)

; indentation
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(setq tab-always-indent t)
(setq default-tab-width tab-width)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
(setq standard-indent tab-width)

; file types to mode
(setq auto-mode-alist
	  (append '(
				("\\.cpp$"		. c++-mode)
				("\\.h$"		. c++-mode)
				("\\.hpp$"		. c++-mode)
				("\\.inline$"   . c++-mode)
				("\\.env$"		. shell-script-mode)
				("\\.conf$"		. shell-script-mode)
				)
			  auto-mode-alist))

(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (setq indent-tabs-mode 1)

  (c-set-offset 'case-label 0)
  )
(setq auto-mode-alist (cons '(".*/linux-2.6/.*\\.[chsS]$" . linux-c-mode) auto-mode-alist))

(defun Kconfig-mode ()
  "Kconfig mode"
  (interactive)
  (c-mode)
  (setq indent-tabs-mode 1)
  )
(setq auto-mode-alist (cons '(".*Kconfig.*" . Kconfig-mode) auto-mode-alist))

; List of c-set-offset's [from http://stuff.mit.edu/afs/sipb/contrib/emacs/packages/cc-mode-5.21/cc-styles.el]
(defun indentation-mode-common-hook ()
  (interactive)

  (setq c-indent-level tab-width)
  (setq c-basic-offset tab-width)

  (c-set-offset 'statement-block-intro '+)
  (c-set-offset 'defun-block-intro '+)
  (c-set-offset 'substatement '+)
  (c-set-offset 'substatement-open 'c-indent-one-line-block)
  (c-set-offset 'class-open 0)
  (c-set-offset 'inclass '+)
  (c-set-offset 'access-label '/)
  (c-set-offset 'case-label '+)
  (c-set-offset 'label '*)
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'brace-list-open 0)
  (c-set-offset 'arglist-cont-nonempty '++)
  (c-set-offset 'arglist-close '++)
)
(add-hook 'c-mode-hook 'indentation-mode-common-hook)
(add-hook 'c++-mode-hook 'indentation-mode-common-hook)

; comment style
(defun comment-mode-common-hook ()
  (interactive)

  (setq comment-start "/* ")
  (setq comment-end " */")
)
(add-hook 'c-mode-hook 'comment-mode-common-hook)
(add-hook 'c++-mode-hook 'comment-mode-common-hook)
(add-hook 'asm-mode-hook 'comment-mode-common-hook)

; gdb configuration
(setq gdb-many-windows t)

; ediff
(define-prefix-command 'ediff-map)
(define-key ediff-map "b" 'ediff-buffers)
(define-key ediff-map "f" 'ediff-files)
(global-set-key (kbd "C-x e") ediff-map)
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

; diff
(custom-set-faces
 '(diff-added ((t (:foreground "#559944"))))
 '(diff-context ((t nil)))
 '(diff-file-header ((t (:background "white" :foreground "#550000"))))
 '(diff-function ((t (:foreground "#00bbdd"))))
 '(diff-header ((t (:background "white" :foreground "#550000"))))
 '(diff-hunk-header ((t (:background "blue" :foreground "#fbde2d"))))
 '(diff-nonexistent ((t (:inherit diff-file-header :strike-through nil))))
 '(diff-refine-change ((t (:background "#182042"))))
 '(diff-removed ((t (:foreground "#de1923"))))
 )

; Automatically split window horizontally [from http://tsdh.wordpress.com/2007/03/09/automatically-split-window-horizontally-if-current-window-is-wide-enough/]
(setq display-buffer-function 'th-display-buffer)
(defun th-display-buffer (buffer force-other-window)
  (or (get-buffer-window buffer)
	  (if (one-window-p)
		  (let ((new-win (if (> (window-width) 165)
							 (split-window-horizontally)
						   (split-window-vertically))))
			(set-window-buffer new-win buffer)
			new-win)
		(let ((new-win (get-lru-window)))
		  (set-window-buffer new-win buffer)
		  new-win)
		)
	  )
  )

; toggle HTML entities
(setq html-entities-on nil)
(defun toggle-html-entities ()
  (interactive)
  (setq cpoint (point))
  (let ((sym '("\&" "\>" "\<")) (ent '("\&amp;" "\&gt;" "\&lt;")) lst0 lst1)
	(if html-entities-on
		(let ()
		  (setq html-entities-on nil)
		  (setq lst0 ent)
		  (setq lst1 sym)
		  )
	  (let ()
		  (setq html-entities-on t)
		  (setq lst0 sym)
		  (setq lst1 ent)
		)
	  )
	(let (i0 i1)
	  (while (and lst0 lst1)
		(setq i0 (car lst0))
		(setq i1 (car lst1))
		(goto-char 1)
		(replace-regexp i0 i1)
		(setq lst0 (cdr lst0))
		(setq lst1 (cdr lst1))
		)
	)
	)
  (goto-char cpoint)
  )

; ediff hexl of files
(defun ediff-hexl (first second)
  (setq first-buffer (find-file-noselect first))
  (switch-to-buffer first-buffer)
  (hexl-mode)
  (setq second-buffer (find-file-noselect second))
  (switch-to-buffer second-buffer)
  (hexl-mode)
  (ediff-buffers first-buffer second-buffer)
  )

; modules

(require 'whitespace)
(setq whitespace-style '(trailing empty))
(global-whitespace-mode t)

(require 'linum)
(add-hook 'c-mode-hook (lambda () (linum-mode t)))
(add-hook 'c++-mode-hook (lambda () (linum-mode t)))
(add-hook 'asm-mode-hook (lambda () (linum-mode t)))
(add-hook 'python-mode-hook (lambda () (linum-mode t)))
(add-hook 'emacs-lisp-mode-hook (lambda () (linum-mode t)))
(add-hook 'makefile-mode-hook (lambda () (linum-mode t)))

(require 'ibuf-ext)
(add-hook 'ibuffer-mode-hook (lambda ()
							   (setq ibuffer-filter-groups '(
															 ("dired"    (mode . dired-mode))
                                                             ("emacs"    (or
                                                                          (name . "^\\*Compile-log\\*$")
                                                                          (name . "^\\*Completions\\*$")
                                                                          (name . "^TAGS\\(<[0-9]+>\\)?$")
                                                                          (name . "^\\*scratch\\*$")
                                                                          (name . "^\\*Messages\\*$")
                                                                          )
                                                              )
                                                             ("vc"       (or
                                                                          (name . "^\\*vc-.*\\*$")
                                                                          (name . "^\\*Annotate.*\\*$")
                                                                          )
                                                              )
															 ("*buffer*" (name . "\\*.*\\*"))
															 )
									 )
							   (setq ibuffer-sorting-mode 'alphabetic)
							   (setq ibuffer-always-show-last-buffer nil)
							   (setq ibuffer-show-empty-filter-groups nil)
							   (setq ibuffer-formats '(
													   (mark modified read-only
															 " " (name 36 36 :left :elide)
															 " " filename)
													   )
									 )
							   )
		  )

(require 'list-register)
(global-set-key (kbd "C-x r v") 'list-registers)

(require 'ido)
(ido-mode t)
(setq ido-ignore-buffers
      '("\\` ""^\\*.*" ".*Completion")
      ido-work-directory-list '("~/" "~/Desktop" "~/Documents")
      ido-case-fold  t
      ido-use-filename-at-point nil
      ido-use-url-at-point nil
      ido-enable-flex-matching t
      ido-max-prospects 6
      ido-everywhere t
      ido-auto-merge-work-directories-length -1
      ido-confirm-unique-completion t)
;; This tab override shouldn't be necessary given ido's default
;; configuration, but minibuffer-complete otherwise dominates the
;; tab binding because of my custom tab-completion-everywhere
;; configuration.
(add-hook 'ido-setup-hook
		  (lambda ()
			(define-key ido-completion-map (kbd "<tab>") 'ido-complete)
            (define-key ido-completion-map (kbd "C-b") 'ido-prev-match)
            (define-key ido-completion-map (kbd "C-f") 'ido-next-match)
			)
		  )
; Do not prompt for non-existent buffer creation
(setq ido-create-new-buffer 'always)

(require 'dired+)
(toggle-dired-find-file-reuse-dir 1)
(custom-set-faces
 '(diredp-dir-heading ((t (:foreground "White" :bold t :weight bold))))
 '(diredp-dir-priv ((t (:foreground "#0f5fff" :bold t :weight bold))))
 '(diredp-read-priv ((t (:background "#1e1e1e" :foreground "Green"))))
 '(diredp-write-priv ((t (:background "#1e1e1e" :foreground "Red"))))
 '(diredp-exec-priv ((t (:background "#1e1e1e" :foreground "Yellow"))))
 '(diredp-no-priv ((t (:background "#1e1e1e" :foreground "White"))))
 )

(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

(require 'etags-select)
(global-set-key (kbd "M-?") 'etags-select-find-tag-at-point)
(global-set-key (kbd "M-.") 'etags-select-find-tag)
(add-hook 'etags-select-mode-hook
		  (lambda ()
			(define-key etags-select-mode-map (kbd "C-m") 'etags-select-goto-tag)
			(define-key etags-select-mode-map (kbd "C-o") 'etags-select-goto-tag-other-window)
            (define-key etags-select-mode-map (kbd "C-n") 'etags-select-next-tag)
            (define-key etags-select-mode-map (kbd "C-p") 'etags-select-previous-tag)
			)
		  )

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

(require 'highlight-parentheses)
(add-hook 'c-mode-hook (lambda () (highlight-parentheses-mode t)))
(add-hook 'c++-mode-hook (lambda () (highlight-parentheses-mode t)))
(add-hook 'emacs-lisp-mode-hook (lambda () (highlight-parentheses-mode t)))

; truncate lines [NOTE: keep this in the end]
(add-hook 'c-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'c++-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'text-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'asm-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'dired-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'ibuffer-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'python-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'emacs-lisp-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'grep-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'makefile-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'diff-mode-hook (lambda () (toggle-truncate-lines t)))
