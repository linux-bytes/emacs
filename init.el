;;; package -- Summury
;;; Commentary:

;;; Code:

(setq user-full-name "Jerry Zhou")
(setq user-mail-address "zhouchunhua@lixiang.com")

(add-to-list 'load-path (expand-file-name "configure" user-emacs-directory))

(require 'init-packages)

(setq custom-file (expand-file-name "configure/custom.el" user-emacs-directory))

(load-file custom-file)
;;; init.el ends here
