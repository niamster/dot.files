
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defvar main-dir user-emacs-directory
  "The root directory of my Emacs configuration.")
(setq user-emacs-directory (expand-file-name "~/.emacs.d/savefiles/" main-dir))

(load "~/.emacs.d/init.el")
