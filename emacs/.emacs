(defvar main-dir user-emacs-directory
  "The root directory of my Emacs configuration.")
(setq user-emacs-directory (expand-file-name "~/.emacs.d/savefiles/" main-dir))

(setq load-path	(cons "~/.emacs.d" load-path))
(byte-recompile-directory "~/.emacs.d" 0 nil)

(load "~/.emacs.d/init.el")
