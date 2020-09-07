;

(defvar main-dir user-emacs-directory
  "The root directory of my Emacs configuration.")
(setq user-emacs-directory (expand-file-name "~/.emacs.d/savefiles/" main-dir))

(load "~/.emacs.d/init.el")
