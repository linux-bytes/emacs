;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(add-to-list 'load-path "~/.emacs.d/configure")

(require 'init-packages)
(require 'init-ui)
(require 'init-change-defaults)
(require 'init-org)
(require 'init-flycheck)
(require 'init-tex)
(require 'init-keybindings)

(setq custom-file (expand-file-name "configure/custom.el" user-emacs-directory))
(load-file custom-file)
