;;; package -- Summury
;;; Just for some customise of other misc packages
;;; Commentary:
;;; Code:

;; graphviz-dot
(setq-default graphviz-dot-auto-indent-on-braces t)
(setq-default graphviz-dot-auto-indent-on-semi t)
(setq-default graphviz-dot-auto-preview-on-save t)

;; image
(eimp-mode 1)
(add-hook 'image-mode-hook 'eimp-mode)
(eval-after-load 'image-dired '(require 'image-dired+))
(eval-after-load 'image-dired+ '(image-diredx-async-mode 1))
(eval-after-load 'image-dired+ '(image-diredx-adjust-mode 1))

;; plantuml
(setq plantuml-default-exec-mode (quote jar))
(setq plantuml-executable-path "/opt/plantuml")
(setq plantuml-jar-path "/opt/plantuml/plantuml.jar")

(add-to-list 'auto-mode-alist '("\\.\\(pu\\)\\'" . plantuml-mode))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

;; for page-break-line
(require 'form-feed)
;; (add-hook 'emacs-lisp-mode-hook 'form-feed-mode)
;; (add-hook 'dashboard-mode-hook 'form-feed-mode)

(require 'page-break-lines)
(set-fontset-font "fontset-default"
                  (cons page-break-lines-char page-break-lines-char)
                  (face-attribute 'default :family))

(require 'dashboard)
(dashboard-setup-startup-hook)

;; Set the title
(setq dashboard-banner-logo-title "Come on! Jerry")
;; Set the banner
(setq dashboard-startup-banner "~/.emacs.d/configure/mylogo.png")
;; (setq dashboard-startup-banner 'logo)
;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.png" which displays whatever image you would prefer

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))

(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

;; (dashboard-modify-heading-icons '((recents . "file-text")
;;                                   (bookmarks . "book")))

;; (setq dashboard-set-navigator t)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(diredfl-global-mode 1)

(provide 'init-misc-pkg)
;;; init-misc-pkg ends here
