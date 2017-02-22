
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defvar main-dir user-emacs-directory
  "The root directory of my Emacs configuration.")
(setq user-emacs-directory (expand-file-name "~/.emacs.d/savefiles/" main-dir))

(load "~/.emacs.d/init.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company-anaconda racer company toml-mode rust-mode elixir-mode zeal-at-point xcscope projectile list-register idle-highlight-mode highlight-symbol highlight-parentheses etags-select dired+ counsel browse-kill-ring))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "#101010"))))
 '(diff-added ((t (:foreground "#559944"))))
 '(diff-context ((t nil)))
 '(diff-file-header ((t (:background "white" :foreground "#550000"))))
 '(diff-function ((t (:foreground "#00bbdd"))))
 '(diff-header ((t (:background "white" :foreground "#550000"))))
 '(diff-hunk-header ((t (:background "blue" :foreground "#fbde2d"))))
 '(diff-nonexistent ((t (:inherit diff-file-header :strike-through nil))))
 '(diff-refine-change ((t (:background "#182042"))) t)
 '(diff-refine-changed ((t (:background "#182042"))))
 '(diff-removed ((t (:foreground "#de1923"))))
 '(diredp-dir-heading ((t (:foreground "white" :bold t :weight bold))))
 '(diredp-dir-priv ((t (:foreground "#0f5fff" :bold t :weight bold))))
 '(diredp-exec-priv ((t (:background "#1e1e1e" :foreground "yellow"))))
 '(diredp-file-name ((t (:foreground "#00868b" :bold t :weight bold))))
 '(diredp-no-priv ((t (:background "#1e1e1e" :foreground "white"))))
 '(diredp-read-priv ((t (:background "#1e1e1e" :foreground "green"))))
 '(diredp-write-priv ((t (:background "#1e1e1e" :foreground "red"))))
 '(idle-highlight ((t (:foreground "#ffd700" :bold t :weight bold)))))
