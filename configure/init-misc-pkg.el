;;; package -- Summury
;;; Just for some customise of other misc packages
;;; Commentary:
;;; Code:

(use-package graphviz-dot-mode
             :ensure t
             :config
             ;; graphviz-dot
             (setq-default graphviz-dot-auto-indent-on-braces t)
             (setq-default graphviz-dot-auto-indent-on-semi t)
             (setq-default graphviz-dot-auto-preview-on-save t)
             )

(use-package eimp
             :ensure t
             :config
             ;; image
             (eimp-mode 1)
             (add-hook 'image-mode-hook 'eimp-mode)
             )

(use-package diredfl
             :ensure t

             :config
             (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

             (diredfl-global-mode 1)
             (eval-after-load 'image-dired '(require 'image-dired+))
             (eval-after-load 'image-dired+ '(image-diredx-async-mode 1))
             (eval-after-load 'image-dired+ '(image-diredx-adjust-mode 1))
             )

(use-package plantuml-mode
             :ensure t
             :config
             ;; plantuml
             (setq plantuml-default-exec-mode (quote jar))
             (setq plantuml-executable-path "/opt/plantuml")
             (setq plantuml-jar-path "/opt/plantuml/plantuml.jar")
             (add-to-list 'auto-mode-alist '("\\.\\(pu\\)\\'" . plantuml-mode))
             (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
             )

;; (use-package form-feed
;;              :ensure t
;; 
;;              :config
;;              (add-hook 'emacs-lisp-mode-hook 'form-feed-mode)
;;              (add-hook 'dashboard-mode-hook 'form-feed-mode)
;;              )

(use-package page-break-lines
             :ensure t

             :config
             (set-fontset-font "fontset-default"
                               (cons page-break-lines-char page-break-lines-char)
                               (face-attribute 'default :family))
             )

(use-package projectile
             :ensure t
             :config
             (projectile-mode +1)
             (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
             )

(provide 'init-misc-pkg)
;;; init-misc-pkg.el ends here
