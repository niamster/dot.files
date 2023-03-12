;; defined in ~/.Xdefaults
;;(set-default-font "Dejavu Sans Mono-6")
;;(set-default-font "-bitstream-bitstream vera sans mono-bold-r-normal--10-8-*-*-m-*-iso8859-1")
;;(set-default-font "-misc-dejavu sans mono-medium-r-normal--10-8-*-*-m-*-iso8859-1")
(set-face-attribute 'default t :font "Fira Code-12")

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(if (>= emacs-major-version 24) (load-theme 'monokai t))

(setq exec-path (append exec-path '("/usr/local/bin")))
(setq exec-path (append exec-path '("~/bin")))

(if window-system
    (progn
      (setq default-frame-alist '((left-fringe . 1) (right-fringe . 1)))
      (scroll-bar-mode -1)
      (tool-bar-mode -1)
      )
  (menu-bar-mode nil))

(setq custom-bg-color "#101010")
(setq custom-fg-color "#00868b")

(custom-set-faces `(default ((t (:background ,custom-bg-color)))))
(custom-set-faces `(default ((t (:foreground ,custom-fg-color)))))
(set-face-attribute 'default nil :background custom-bg-color :foreground custom-fg-color)

(setq frame-title-format '("" "%b:" default-directory))

;; fullscreen mode
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen)
                           nil 'fullboth))
  )
(global-set-key [f11] 'fullscreen)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; do not copy marked region to the primary selection
(setq select-active-regions nil)
(setq mouse-drag-copy-region nil)

;; server
(setq server-use-tcp t)
(setq server-host "0.0.0.0")
(defun run-server()
  (interactive)
  (setq server-name (read-string "Server name:"))
  (message "Don't forget to copy ~/.emacs.d/server/%s to host" server-name)
  (server-start)
  )
(global-set-key (kbd "C-c s") 'run-server)

;; locale
(setq current-language-environment "UTF-8")
(setq default-input-method "russian-computer")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; mac specific key settings
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  ;; brew install libressl
  (require 'gnutls)
  (add-to-list 'gnutls-trustfiles "/usr/local/etc/openssl/cert.pem")
  )

;; highlighting
(setq font-lock-maximum-decoration t)
(setq-default font-lock-multiline t)

(global-font-lock-mode t)
(setq light-symbol-mode t)

;; hi-lock
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

;; highlight parent brace
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'parenthesis)
(set-face-background 'show-paren-match "green")
(set-face-attribute 'show-paren-match nil :weight 'bold :underline nil :overline nil :slant 'normal)
(set-face-foreground 'show-paren-mismatch "red")
(set-face-attribute 'show-paren-mismatch nil :weight 'bold :underline t :overline nil :slant 'normal)

;; highlight additional keywords NOTE TODO FIXME BUG DEBUG
(setq assertface '((:foreground "#d7ff00" :weight bold)))
(setq keysface '((:foreground "#d7ff00" :underline t :weight bold)))
(setq bugface '((:foreground "#ff0000" :weight bold)))
(setq debugkeyface '((:foreground "#00cdcd" :weight bold)))
(setq keys '(
             ("\\(FIXME\\|TODO\\|NOTE\\|WARNING\\|XXX\\)" 1 keysface t)
             ("[^E]\\(BUG\\)" 1 bugface t)
             ("[^E]\\(BUG_ON\\)" 1 bugface t)
             ("\\(WARN_ON[A-Z_]*\\)" 1 assertface t)
             ("\\([A-Z_]*ASSERT[A-Z_]*\\)" 1 assertface t)
             ("\\([A-Z_]*DEBUG[A-Z_]*\\)" 1 debugkeyface t)
             )
      )
(defun font-lock-kw-hook () (font-lock-add-keywords nil keys t))

;; highlight #if 0
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

;; misc staff
(setq-default bidi-display-reordering nil) ;; do not use BIDI
(transient-mark-mode t) ;; highlight the region whenever it is active
(auto-compression-mode t) ;; uncompress files before displaying them
(setq make-backup-files nil)
(setq scroll-conservatively most-positive-fixnum) ;; scroll only one line when move past the bottom of the screen
(setq scroll-down-aggressively 0.0)
(setq scroll-margin 10)
(setq scroll-step 1)
(setq scroll-up-aggressively 0.0)
(setq scroll-preserve-screen-position t)
(setq auto-window-vscroll nil) ;; speedup down scroll
(setq hscroll-step 1)
(setq redisplay-dont-pause t) ;; this will be default in emacs24
(fset 'yes-or-no-p 'y-or-n-p) ;; make the y or n suffice for a yes or no question
(setq comment-style 'indent)
(delete-selection-mode t) ;; replace highlighted text with what typed
(setq case-fold-search nil) ;; case-sensitive search
(setq inhibit-startup-message t) ;; do not show startup message
(column-number-mode t) ;; column-number in the mode line
(setq pop-up-windows nil) ;; stop emacs from changing window configuration
(setq confirm-nonexistent-file-or-buffer nil) ;; stop emacs from prompting you whenever a new file is created

;; woman in same frame
(setq woman-use-own-frame nil)

;; dired ls options
(if (eq system-type 'darwin)
    (setq insert-directory-program "/opt/homebrew/bin/gls")
  )
(setq dired-listing-switches "-l --group-directories-first -h -G -a")

;; search: toggle case, edit search string
(add-hook 'isearch-mode-hook
          (lambda ()
            (define-key isearch-mode-map (kbd "C-c") 'isearch-toggle-case-fold)
            (define-key isearch-mode-map (kbd "C-j") 'isearch-edit-string)
            )
          )

;; give 5 secs to think before killing emacs
(setq confirm-kill-emacs
      (lambda (e)
        (y-or-n-p-with-timeout
         "Really exit Emacs (automatically exits in 5 secs)? " 5 t)
        )
      )

;; stop prompting me about whether I really mean to bring that large file into a buffer
(setq large-file-warning-threshold nil)

(defun find-file-check-make-large-file-read-only-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 1024 1024))
    (setq buffer-read-only t)
    (buffer-disable-undo)
    (fundamental-mode)
    (font-lock-fontify-buffer)
    )
  )
(add-hook 'find-file-hook 'find-file-check-make-large-file-read-only-hook)

;; up/low case region
(put 'upcase-region 'disabled nil) ;; enable C-x C-u for upcase region
(put 'downcase-region 'disabled nil) ;; enable C-x C-l for downcase region
;; M-l : Convert following word to lower case
;; M-u : Convert following word to upper case

;; treat word with uppercase and lowercase letters as different words
(defun subword-hook ()
  (if (fboundp 'subword-mode)
      (subword-mode)
    (c-subword-mode)
    )
  )

;; backspace to delete character backwards
(define-key key-translation-map "\177" (kbd "C-="))
(define-key key-translation-map (kbd "C-=") "\177")
(global-set-key "\177" 'delete-backward-char)
(global-set-key (kbd "C-=") 'delete-backward-char)
(global-set-key (kbd "C-M-=") 'backward-kill-word)

;; keybinding
(global-set-key (kbd "C-x g") 'gdb) ;; gdb
(global-set-key (kbd "C-x m") 'woman) ;; man
(global-set-key (kbd "M-g") 'goto-line) ;; go to line
(global-set-key (kbd "M-t") 'tab-to-tab-stop) ;; inserts indentation before point
(global-set-key (kbd "C-x C-b") 'ibuffer) ;; buffers menu in the same window
(global-set-key (kbd "C-s") 'isearch-forward-regexp) ;; search regexp forward
(global-set-key (kbd "C-r") 'isearch-backward-regexp) ;; search regexp backward
(global-set-key (kbd "RET") 'newline-and-indent) ;; indent after return pressed
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-c >") 'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "C-c <") 'indent-rigidly-left-to-tab-stop)
(global-set-key (kbd "TAB") 'indent-according-to-mode)
(global-set-key (kbd "C-i") 'indent-according-to-mode)
(global-set-key (kbd "C-j") (lambda () (interactive) (end-of-line) (newline-and-indent))) ;; newline and indent
(global-set-key (kbd "C-x C-g") 'rgrep) ;; find in files
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-x C-t") '(lambda ()(interactive)(ansi-term "/bin/bash")))
(global-set-key (kbd "C-c r") 'set-frame-name)
(global-set-key (kbd "M-*") 'pop-tag-mark)

(add-hook 'text-mode-hook '(lambda () (local-set-key (kbd "RET") 'newline)))
(add-hook 'text-mode-hook '(lambda () (local-set-key (kbd "C-m") 'newline)))
(add-hook 'text-mode-hook '(lambda () (local-set-key (kbd "C-j") (lambda () (interactive) (end-of-line) (newline-and-indent)))))

(setq initial-major-mode 'text-mode)
(setq default-major-mode 'text-mode)

;; buffer navigation
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

;; (global-move-key (kbd "<home>") (kbd "C-a"))
;; (global-move-key (kbd "<end>") (kbd "C-e"))
;; (global-move-key (kbd "<next>") (kbd "C-v"))
;; (global-move-key (kbd "<prior>") (kbd "M-v"))
;; (global-move-key (kbd "<left>") (kbd "C-b"))
;; (global-move-key (kbd "<right>") (kbd "C-f"))
;; (global-move-key (kbd "<up>") (kbd "C-p"))
;; (global-move-key (kbd "<down>") (kbd "C-n"))

;; remove annoying keybinding(`[` is too close to `p`)
(global-unset-key (kbd "C-[ C-["))

;; frame control
(global-set-key (kbd "C-x 5 3") 'make-frame-on-display)
;; C-z     : Minimize (or “iconify) the selected Emacs frame (suspend-frame)
;; C-x 5 0 : Delete the selected frame (delete-frame)
;; C-x 5 o : Select another frame, raise it, and warp the mouse to it.
;; C-x 5 1 : Delete all frames except the selected one.
;; C-x 5 2 : Create a new frame
;; C-x 5 b : Select buffer bufname in another frame
;; C-x 5 f : Visit file filename and select its buffer in another frame
;; C-x 5 d : Select a Dired buffer for directory directory in another frame

(move-key minibuffer-local-map (kbd "<up>") (kbd "C-p"))
(move-key minibuffer-local-map (kbd "<down>") (kbd "C-n"))
(move-key minibuffer-local-map (kbd "<right>") (kbd "C-f"))
(move-key minibuffer-local-map (kbd "<left>") (kbd "C-b"))

(global-unset-key (kbd "C-x <left>"))
(global-unset-key (kbd "C-x <right>"))

;; speedup vc-git for big git repos(http://debbugs.gnu.org/cgi/bugreport.cgi?bug=8288)
(defun vc-git-state-heuristic (file)
  "Just claim we're up to date."
  'up-to-date)

;; duplicate the line and comment the first
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

;; Wrap marked region with #if 0/#endif
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

;; killing and yanking lines
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

;; window spliting
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

;; string/regexp replacing
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

;; region indentation
(defun unindent-region ()
  (interactive)
  (indent-region (region-beginning) (region-end) -1)
  )
(global-set-key (kbd "C-x TAB") 'indent-region)
(global-set-key (kbd "C-x <backtab>") 'unindent-region)

;; cursor color
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

;; indentation
(defun two-space-mode ()
  (interactive)
  (setq tab-width 2)
  (setq default-tab-width tab-width)
  (setq tab-stop-list '(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40))
  (setq standard-indent tab-width)
  )
(defun four-space-mode ()
  (interactive)
  (setq tab-width 4)
  (setq default-tab-width tab-width)
  (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
  (setq standard-indent tab-width)
  )
(setq tab-width 2)
(setq-default indent-tabs-mode nil)
(setq tab-always-indent t)
(setq-default tab-width tab-width)
(setq default-tab-width tab-width)
(setq tab-stop-list '(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40))
(setq standard-indent tab-width)

;; Prefer four-space-mode for Python (standard black policy)
(setq python-indent 4)
(setq python-guess-indent nil)
(add-hook 'python-mode-hook
          (lambda ()
            (four-space-mode)
            )
          )
(setq lua-indent-level tab-width)

;; file types to mode
(setq auto-mode-alist
      (append '(
                ("\\.cpp$"		. c++-mode)
                ("\\.h$"		. c++-mode)
                ("\\.hpp$"		. c++-mode)
                ("\\.inline$"           . c++-mode)
                ("\\.env$"		. shell-script-mode)
                ("\\.conf$"		. shell-script-mode)
                ("\\.go$"		. go-mode)
                )
              auto-mode-alist))

(defun tab-mode ()
  (interactive)
  (setq indent-tabs-mode 1)
  )

(defun spc-mode ()
  (interactive)
  (setq indent-tabs-mode nil)
  )

(defun linux-mode ()
  "Linux-style C mode with tabs for indentation."
  (interactive)
  (c-mode)
  (setq indent-tabs-mode 1)
  (c-set-offset 'case-label 0)
  )
(setq auto-mode-alist (cons '(".*/linux-.*/.*\\.[chsS]$" . linux-mode) auto-mode-alist))

(defun Kconfig-mode ()
  "Kconfig mode"
  (interactive)
  (c-mode)
  (setq indent-tabs-mode 1)
  )
(setq auto-mode-alist (cons '(".*Kconfig.*" . Kconfig-mode) auto-mode-alist))

(defun custom-c-arglist-init-expression (langelem)
  "Indents to the beginning of the current C expression plus one offset."
  (save-excursion
    (back-to-indentation)
    ;; Go to beginning of *previous* line:
    (c-backward-syntactic-ws)
    (back-to-indentation)

    ;; (cond
    ;;  ;; We are making a reasonable assumption that if there is a control
    ;;  ;; structure to indent past, it has to be at the beginning of the line.
    ;;  ((looking-at ".*?\\([a-zA-Z0-9_]+\s*(\\)")
    ;;   (goto-char (match-beginning 1))
    ;;   )
    ;;  )

    ;; (message "matched %d '%s'"
    ;;          (match-beginning 1)
    ;;          (buffer-substring (match-beginning 1) (match-end 1)))
    (vector (+ c-basic-offset (current-column)))
    )
  )
(defun custom-c-arglist-close-expression (langelem)
  "Indents to the beginning of the current C expression."
  (save-excursion
    (c-beginning-of-statement 1)
    (back-to-indentation)
    ;; (message "moving %d '%s'"
    ;;          (current-column)
    ;;          (buffer-substring (point) (+ (point) 10)))
    (vector (current-column))
    )
  )

;; List of c-set-offset's [from http://stuff.mit.edu/afs/sipb/contrib/emacs/packages/cc-mode-5.21/cc-styles.el]
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
  (c-set-offset 'arglist-cont-nonempty '+)
  (c-set-offset 'arglist-close 'custom-c-arglist-close-expression)
  (c-set-offset 'arglist-intro 'custom-c-arglist-init-expression)
  (c-set-offset 'inextern-lang 0)
  )
(add-hook 'c-mode-hook 'indentation-mode-common-hook)
(add-hook 'c++-mode-hook 'indentation-mode-common-hook)

;; comment style
(defun comment-mode-common-hook ()
  (interactive)

  (setq comment-start "/* ")
  (setq comment-end " */")
  )
(add-hook 'c-mode-hook 'comment-mode-common-hook)
(add-hook 'c++-mode-hook 'comment-mode-common-hook)
(add-hook 'asm-mode-hook 'comment-mode-common-hook)
(add-hook 'java-mode-hook 'comment-mode-common-hook)

(add-hook 'java-mode-hook (lambda () (setq c-basic-offset 2)))

;; display current function in mode space
(which-function-mode t)

;; gdb configuration
(setq gdb-many-windows t)

;; verilog-mode configuration
(defun verilog-mode-custom ()
  (setq verilog-auto-newline nil)
  (setq verilog-auto-endcomments nil)
  (setq verilog-auto-lineup nil)
  (setq verilog-indent-level 2)
  (setq verilog-indent-level-module 2)
  (setq verilog-indent-level-declaration 2)
  (setq verilog-indent-level-behavioral 2)
  )
(setq verilog-mode-hook 'verilog-mode-custom)

;; ediff
(define-prefix-command 'ediff-map)
(define-key ediff-map "b" 'ediff-buffers)
(define-key ediff-map "f" 'ediff-files)
(global-set-key (kbd "C-x e") ediff-map)
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; diff
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

;; toggle HTML entities
(setq html-entities-on nil)
(defun toggle-html-entities ()
  (interactive)
  (setq cpoint (point))
  (let ((sym '("\&" "\>" "\<")) (ent '("\&amp;;" "\&gt;;" "\&lt;;")) lst0 lst1)
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

;; ediff hexl of files
(defun ediff-hexl (first second)
  (setq first-buffer (find-file-noselect first))
  (switch-to-buffer first-buffer)
  (hexl-mode)
  (setq second-buffer (find-file-noselect second))
  (switch-to-buffer second-buffer)
  (hexl-mode)
  (ediff-buffers first-buffer second-buffer)
  )

;; ibuffer grouping
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

;; mechanism for making buffer names unique
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; This should go _after_ package-initialize(bug in package.el?)
(setq load-path	(cons "~/.emacs.d" load-path))

(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)
      )
  )
(require 'use-package)
(setq use-package-always-ensure t)

;; Modules initialization and their parameters

;;
(setq quelpa-update-melpa-p nil)
(setq quelpa-self-upgrade-p nil)
(setq quelpa-stable-p t)
(use-package quelpa)
(use-package quelpa-use-package)

;;
(use-package powerline)
(powerline-default-theme)

;;
(use-package rust-mode)

;;
(use-package json-mode)

;; snake <-> camel conversion
(use-package string-inflection)

;;
(use-package flycheck)

;;
(use-package lsp-mode)
(setq lsp-keymap-prefix "C-c l")
(setq lsp-file-watch-threshold 100000)
;; Perf tuning, see https://emacs-lsp.github.io/lsp-mode/page/performance/
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

(setq modes '(go-mode-hook
              rust-mode-hook
              zig-mode-hook
              ))
(dolist (mode modes)
  (add-hook mode 'lsp)
  (add-hook mode (lambda () (local-set-key (kbd "M-.") 'lsp-find-definition)))
  )

;;
;; You need to install gopls.
;; See https://github.com/golang/tools/blob/master/gopls/doc/emacs.md for more details.
(use-package go-mode)
(defun custom-go-mode-hook ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t)
  ;; go-pls issues `go list` too often which kills the perf
  (setq lsp-diagnostics-provider :none)
  )
(add-hook 'go-mode-hook 'custom-go-mode-hook)

;;
(use-package lua-mode)

;;
(use-package markdown-mode)

;;
(use-package toml-mode)

;;
(use-package whitespace)
(setq whitespace-style '(face trailing empty))
(global-whitespace-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;
;; C-M-j to open file name that matches smth else
(use-package ivy)
(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq ivy-wrap t)

;;
(use-package swiper)
(global-set-key (kbd "C-s") 'swiper)

;;
(use-package counsel)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(setq counsel-find-file-ignore-regexp
      (regexp-opt '(".o"
                    ".pyc"
                    )))
;; better than calling dired directly due to the way it handles the file selection
(global-set-key (kbd "C-x C-d") 'counsel-find-file)
(global-set-key (kbd "C-x d") 'counsel-find-file)

;;
(use-package projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'ivy)

;;
(use-package helm)
(setq projectile-completion-system 'helm)
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-map (kbd "TAB") nil)

;;
(use-package dired+
  :quelpa (dired+ :fetcher github :repo "emacsmirror/dired-plus")
  )
(custom-set-faces
 '(diredp-dir-heading ((t (:foreground "white" :bold t :weight bold))))
 '(diredp-file-name ((t (:foreground "#00868b" :bold t :weight bold))))
 '(diredp-dir-priv ((t (:foreground "#0f5fff" :bold t :weight bold))))
 '(diredp-read-priv ((t (:background "#1e1e1e" :foreground "green"))))
 '(diredp-write-priv ((t (:background "#1e1e1e" :foreground "red"))))
 '(diredp-exec-priv ((t (:background "#1e1e1e" :foreground "yellow"))))
 '(diredp-no-priv ((t (:background "#1e1e1e" :foreground "white"))))
 )
(setq diredp-hide-details-initially-flag nil)
(setq diredp-hide-details-propagate-flag nil)
(diredp-toggle-find-file-reuse-dir 1)

;;
(use-package browse-kill-ring)
(browse-kill-ring-default-keybindings)

;;
(use-package etags-select
  :quelpa (etags-select :fetcher github :repo "emacsmirror/etags-select")
  )
(global-set-key (kbd "M-.") 'etags-select-find-tag-at-point)
(define-key etags-select-mode-map (kbd "C-m") 'etags-select-goto-tag)

;;
(use-package highlight-parentheses)

;;
(use-package yaml-mode)

;;
(use-package ini-mode)

;;
(use-package nginx-mode)
(setq auto-mode-alist (cons '(".*/nginx.*/.*\\(\\.conf\\|_params\\)$" . nginx-mode) auto-mode-alist))

;;
(use-package highlight-symbol)
(global-set-key (kbd "C-x h") 'highlight-symbol-at-point)
(global-set-key (kbd "C-x u") 'highlight-symbol-remove-all)

;;
(use-package idle-highlight-mode)
(custom-set-faces
 '(idle-highlight ((t (:foreground "#ffd700" :bold t :weight bold))))
 )
(setq idle-highlight-idle-time .6)

;;
(use-package xcscope)
(cscope-setup)
(define-prefix-command 'xscope-map)
(define-key xscope-map "i" 'cscope-set-initial-directory)
(define-key xscope-map "s" 'cscope-find-this-symbol)
(define-key xscope-map "r" 'cscope-find-functions-calling-this-function)
(define-key xscope-map "*" 'cscope-pop-mark)
(global-set-key (kbd "C-x a") xscope-map)

;;
(use-package zeal-at-point)
(global-set-key (kbd "C-c z") 'zeal-at-point)

;;
(use-package flycheck-rust)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

;;
;; Solution for failed jedi installation: https://github.com/proofit404/anaconda-mode/issues/225#issuecomment-280009142
(use-package anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-mode)

;;
(use-package company-anaconda)
(eval-after-load "company" '(add-to-list 'company-backends 'company-anaconda))
(add-hook 'python-mode-hook 'anaconda-mode)

;;
(use-package indent-guide)
(indent-guide-global-mode)

;;
;; Don't forget to run irony-install-server
;; Want to use bear: https://github.com/rizsotto/Bear
;; And wrap make like this:
;;
;; #!/bin/bash
;; set -a
;; make=/usr/bin/make
;; bear=$(which bear 2>/dev/null)
;; exec $bear $make "$@"
;; See also https://github.com/Sarcasm/irony-mode/issues/167#issuecomment-71817840
(use-package irony)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
;; Replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun custom-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'custom-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;
(use-package company-irony)
(eval-after-load 'company '(add-to-list 'company-backends 'company-irony))

;;
(use-package flycheck-irony)
(eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;;
(use-package clang-format)
(defun clang-format-hook ()
  ;; http://clang.llvm.org/docs/ClangFormatStyleOptions.html#configurable-format-style-options
  (unless (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
    (setq clang-format-style "{BasedOnStyle: Google, ColumnLimit: 120}"))
  )
(add-hook 'c-mode-hook 'clang-format-hook)
(add-hook 'c++-mode-hook 'clang-format-hook)

;;
(use-package company)
(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends '(company-dabbrev-code company-capf company-gtags company-etags company-keywords))
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-h") nil)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)

;;
(use-package protobuf-mode)
(defconst custom-protobuf-style
  '((c-basic-offset . 2)
    (indent-tabs-mode . nil))
  )
(add-hook 'protobuf-mode-hook
          (lambda () (c-add-style "custom-protobuf-style" custom-protobuf-style t))
          )

;;
(use-package bazel)
(add-hook 'bazel-mode-hook
          (lambda ()
            (add-hook 'four-space-mode)
            ;; https://github.com/bazelbuild/buildtools/blob/master/buildifier/README.md
            (add-hook 'before-save-hook #'bazel-format nil t)
            )
          )
;;
(use-package terraform-mode)

;;
;; Also handy to install ZLS (https://github.com/zigtools/zls)
(use-package zig-mode)

;;
(use-package dockerfile-mode)

;;
(use-package format-all)
(add-hook 'prog-mode-hook 'format-all-mode)
(add-hook 'format-all-mode-hook 'format-all-ensure-formatter)

;;
(use-package tree-sitter)
(use-package tree-sitter-langs)
(face-spec-set 'tree-sitter-hl-face:function '((t (:slant italic))))
(face-spec-set 'tree-sitter-hl-face:method\.call '((t (:inherit tree-sitter-hl-face:method :weight normal :slant normal))))
(face-spec-set 'tree-sitter-hl-face:method '((t (:slant italic))))
(face-spec-set 'tree-sitter-hl-face:function\.call '((t (:inherit tree-sitter-hl-face:function :weight normal :slant normal))))

;; truncate lines [NOTE: keep this in the end]
(add-hook 'dired-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'ibuffer-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'grep-mode-hook (lambda () (toggle-truncate-lines t)))
(add-hook 'diff-mode-hook (lambda () (toggle-truncate-lines t)))

(setq modes '(c-mode-hook
              c++-mode-hook
              java-mode-hook
              asm-mode-hook
              python-mode-hook
              ruby-mode-hook
              emacs-lisp-mode-hook
              makefile-mode-hook
              verilog-mode-hook
              go-mode-hook
              sh-mode-hook
              lua-mode-hook
              rust-mode-hook
              markdown-mode-hook
              text-mode-hook
              bazel-mode-hook
              zig-mode-hook
              dockerfile-mode-hook
              ))
(dolist (mode modes)
  (add-hook mode (lambda () (toggle-truncate-lines t)))
  (add-hook mode (lambda () (linum-mode t)))
  (add-hook mode (lambda () (idle-highlight-mode t)))
  (add-hook mode 'font-lock-kw-hook)
  (add-hook mode 'subword-hook)
  (add-hook mode (lambda () (highlight-parentheses-mode t)))
  (add-hook mode 'flyspell-prog-mode)
  (unless (member mode '(text-mode-hook))
    (add-hook mode 'tree-sitter-mode)
    (add-hook mode 'tree-sitter-hl-mode)
    )
  )

(setq modes '(
              markdown-mode-hook
              text-mode-hook
              ))
(dolist (mode modes)
  (remove-hook mode 'flyspell-prog-mode)
  (add-hook mode 'flyspell-mode)
  )

;; w/a for md-mode for `(define-key map (kbd "C-x n b") 'markdown-narrow-to-block)`
;; see https://github.com/jrblevin/markdown-mode/blob/e9dff50d572caa96b68a7466c18c97a8d6ed651c/markdown-mode.el#L5386
(add-hook 'markdown-mode-hook
          (lambda () (local-set-key (kbd "C-x n b") 'windmove-left))
          )

;; Define ligatures
;; See https://andreyorst.gitlab.io/posts/2020-07-21-programming-ligatures-in-emacs/
;; https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
(let ((ligatures `((?-  . ,(regexp-opt '("-|" "-~" "---" "-<<" "-<" "--" "->" "->>" "-->")))
                   (?/  . ,(regexp-opt '("/**" "/*" "///" "/=" "/==" "/>" "//")))
                   (?*  . ,(regexp-opt '("*>" "***" "*/")))
                   (?<  . ,(regexp-opt '("<-" "<<-" "<=>" "<=" "<|" "<||" "<|||::=" "<|>" "<:" "<>" "<-<"
                                         "<<<" "<==" "<<=" "<=<" "<==>" "<-|" "<<" "<~>" "<=|" "<~~" "<~"
                                         "<$>" "<$" "<+>" "<+" "</>" "</" "<*" "<*>" "<->" "<!--")))
                   (?:  . ,(regexp-opt '(":>" ":<" ":::" "::" ":?" ":?>" ":=")))
                   (?=  . ,(regexp-opt '("=>>" "==>" "=/=" "=!=" "=>" "===" "=:=" "==")))
                   (?!  . ,(regexp-opt '("!==" "!!" "!=")))
                   (?>  . ,(regexp-opt '(">]" ">:" ">>-" ">>=" ">=>" ">>>" ">-" ">=")))
                   (?&  . ,(regexp-opt '("&&&" "&&")))
                   (?|  . ,(regexp-opt '("|||>" "||>" "|>" "|]" "|}" "|=>" "|->" "|=" "||-" "|-" "||=" "||")))
                   (?.  . ,(regexp-opt '(".." ".?" ".=" ".-" "..<" "...")))
                   (?+  . ,(regexp-opt '("+++" "+>" "++")))
                   (?\[ . ,(regexp-opt '("[||]" "[<" "[|")))
                   (?\{ . ,(regexp-opt '("{|")))
                   ;; Following makes Emacs hang in python mode
                   ;; (?\? . ,(regexp-opt '("??" "?." "?=" "?:")))
                   (?#  . ,(regexp-opt '("####" "###" "#[" "#{" "#=" "#!" "#:" "#_(" "#_" "#?" "#(" "##")))
                   (?\; . ,(regexp-opt '(";;")))
                   (?_  . ,(regexp-opt '("_|_" "__")))
                   (?\\ . ,(regexp-opt '("\\" "\\/")))
                   (?~  . ,(regexp-opt '("~~" "~~>" "~>" "~=" "~-" "~@")))
                   (?$  . ,(regexp-opt '("$>")))
                   (?^  . ,(regexp-opt '("^=")))
                   (?\] . ,(regexp-opt '("]#"))))))
  (dolist (char-regexp ligatures)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

;; Enable composite mode only in prog modes
(global-auto-composition-mode -1)
(add-hook 'prog-mode-hook 'auto-composition-mode)
