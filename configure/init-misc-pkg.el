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

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;;; (treemacs)
;;;
;;; (treemacs-modify-theme "Default"
;;;   :icon-directory (f-join treemacs-dir "icons/default")
;;;   :config
;;;   (progn
;;;     (treemacs-create-icon :file "dir-open.png"   :fallback ""            :extensions (root))
;;;     ))

;;; (use-package treemacs-icons-dired
;;;   :after treemacs dired
;;;   :ensure t
;;;   :config (treemacs-icons-dired-mode))
;;;
;;; (use-package treemacs
;;;   :ensure t
;;;   :defer t
;;;   :init
;;;   (with-eval-after-load 'winum
;;;     (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
;;;   :config
;;;   (progn
;;;     (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
;;;           treemacs-deferred-git-apply-delay      0.5
;;;           treemacs-directory-name-transformer    #'identity
;;;           treemacs-display-in-side-window        t
;;;           treemacs-eldoc-display                 t
;;;           treemacs-file-event-delay              5000
;;;           treemacs-file-extension-regex          treemacs-last-period-regex-value
;;;           treemacs-file-follow-delay             0.2
;;;           treemacs-file-name-transformer         #'identity
;;;           treemacs-follow-after-init             t
;;;           treemacs-git-command-pipe              ""
;;;           treemacs-goto-tag-strategy             'refetch-index
;;;           treemacs-indentation                   2
;;;           treemacs-indentation-string            " "
;;;           treemacs-is-never-other-window         nil
;;;           treemacs-max-git-entries               5000
;;;           treemacs-missing-project-action        'ask
;;;           treemacs-move-forward-on-expand        nil
;;;           treemacs-no-png-images                 nil
;;;           treemacs-no-delete-other-windows       t
;;;           treemacs-project-follow-cleanup        nil
;;;           treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
;;;           treemacs-position                      'left
;;;           treemacs-recenter-distance             0.1
;;;           treemacs-recenter-after-file-follow    nil
;;;           treemacs-recenter-after-tag-follow     nil
;;;           treemacs-recenter-after-project-jump   'always
;;;           treemacs-recenter-after-project-expand 'on-distance
;;;           treemacs-show-cursor                   nil
;;;           treemacs-show-hidden-files             t
;;;           treemacs-silent-filewatch              nil
;;;           treemacs-silent-refresh                nil
;;;           treemacs-sorting                       'alphabetic-asc
;;;           treemacs-space-between-root-nodes      t
;;;           treemacs-tag-follow-cleanup            t
;;;           treemacs-tag-follow-delay              1.5
;;;           treemacs-user-mode-line-format         nil
;;;           treemacs-width                         35)
;;;
;;;     ;; The default width and height of the icons is 22 pixels. If you are
;;;     ;; using a Hi-DPI display, uncomment this to double the icon size.
;;;     ;;(treemacs-resize-icons 44)
;;;
;;;     (treemacs-follow-mode t)
;;;     (treemacs-filewatch-mode t)
;;;     (treemacs-fringe-indicator-mode t)
;;;     (pcase (cons (not (null (executable-find "git")))
;;;                  (not (null treemacs-python-executable)))
;;;       (`(t . t)
;;;        (treemacs-git-mode 'deferred))
;;;       (`(t . _)
;;;        (treemacs-git-mode 'simple))))
;;;   :bind
;;;   (:map global-map
;;;         ("M-0"       . treemacs-select-window)
;;;         ("C-x t 1"   . treemacs-delete-other-windows)
;;;         ("C-x t t"   . treemacs)
;;;         ("C-x t B"   . treemacs-bookmark)
;;;         ("C-x t C-t" . treemacs-find-file)
;;;         ("C-x t M-t" . treemacs-find-tag)))
;;;
;;; (use-package treemacs-evil
;;;   :after treemacs evil
;;;   :ensure t)
;;;
;;; (use-package treemacs-projectile
;;;   :after treemacs projectile
;;;   :ensure t)
;;;
;;; (use-package treemacs-icons-dired
;;;   :after treemacs dired
;;;   :ensure t
;;;   :config (treemacs-icons-dired-mode))
;;;
;;; (use-package treemacs-magit
;;;   :after treemacs magit
;;;   :ensure t)
;;;
;;; (use-package treemacs-persp
;;;   :after treemacs persp-mode
;;;   :ensure t
;;;   :config (treemacs-set-scope-type 'Perspectives))
;;;
;;; (treemacs)
;;;
;;; (treemacs-create-theme "test"
;;;   :icon-directory (f-join treemacs-dir "icons/default")
;;;   :config
;;;   (progn
;;;     (treemacs-create-icon :file "emacs.png"   :fallback ""            :extensions (root))
;;;     (treemacs-create-icon :file "emacs.png"  :fallback "🗏 "          :extensions ("el" "elc"))
;;;     (treemacs-create-icon :file "readme.png" :fallback "🗏 "          :extensions ("readme.md"))
;;;     (treemacs-create-icon :icon (all-the-icons-icon-for-file "yaml") :extensions ("yml" "yaml"))))
;;;
;;; (treemacs-modify-theme "Default"
;;;   :icon-directory (f-join treemacs-dir "icons/default")
;;;   :config
;;;   (progn
;;;     (treemacs-create-icon :file "vsc/dir-closed.png" :fallback ""       :extensions (root))))

(provide 'init-misc-pkg)
;;; init-misc-pkg.el ends here
