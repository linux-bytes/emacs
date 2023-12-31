;;; package -- Summury
;;; Commentary:

;;; Code:

(setq user-full-name "Jerry Zhou")
(setq user-mail-address "zhouchunhua@lixiang.com")

(add-to-list 'load-path "~/.emacs.d/configure")

(require 'init-packages)
(require 'init-ui)
(require 'init-change-defaults)
(require 'init-org)
(require 'init-flycheck)
(require 'init-tex)
(require 'init-misc-pkg)
(require 'init-keybindings)
(require 'init-program)

(setq custom-file (expand-file-name "configure/custom.el" user-emacs-directory))
(load-file custom-file)
;;; init.el ends here
