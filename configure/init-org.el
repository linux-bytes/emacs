;;; package --- Summary
;;; Commentary:

;;; Code:
(setq my-gtd-misc-file
      (expand-file-name "misc.org" "~/custom/GTD"))

(defun my-gtd-misc-template ()
       (list my-gtd-misc-file "Tasks")
       )

(use-package org
             :ensure t
             :config
             (setq org-edit-src-content-indentation 0)
             (setq org-fontify-whole-heading-line   t)
             (setq org-support-shift-select         t)
             (setq org-refile-targets               nil)
             (setq org-tags-column                  80)
             ;; (setq org-indent-indentation-per-level 2)

             (setq org-todo-keywords
                   '((sequence "TODO(p!)" "RUNNING(g!)" "HOLD(b!)" "|" "DONE(d!)" "CANCELED(c@/!)")))

             (setq org-todo-keyword-faces
                   '(("TODO" .      (:background "red"         :foreground "white" :weight bold))
                     ("RUNNING" .   (:background "magenta"     :foreground "white" :weight bold))
                     ("HOLD" .      (:background "blue"        :foreground "white" :weight bold))
                     ("DONE" .      (:background "dodger blue" :foreground "white" :weight bold))
                     ("CANCELED" .  (:background "PaleGreen4"  :foreground "white" :weight bold))
                     ))

             (setq org-priority-faces '((?A . (:foreground "red"   :weight bold))
                                        (?B . (:foreground "blue"  :weight bold))
                                        (?C . (:foreground "black" :weight bold))
                                        (?D . (:foreground "white" :weight bold))
                                        ))

             (setq org-default-notes-file my-gtd-misc-file)
             (setq org-agenda-files "~/custom/GTD/org_gtd_list.txt")

             (setq org-refile-targets
                   (quote ((org-agenda-files :maxlevel . 2))))

             (my-gtd-misc-template)

             (setq org-capture-templates
                   '(("t" "Create a new misc task." entry (file+headline "" "Misc Tasks")
                      "** %?\n %U" :empty-lines-after 1)
                     ("i" "Create a new idea." entry (file+headline "" "Ideas")
                      "** %i\n %U" :empty-lines-after 1)
                     ("p" "Create a temp project task." entry (file+headline "" "Temp Project")
                      "** %?\n %U" :empty-lines-after 1)))

             (setq org-html-head
                   (format
                     "<link rel=\"stylesheet\" type=\"text/css\" href=\"%s\"/>"
                     (expand-file-name "configure/org_style/style.css" user-emacs-directory)))

             ;; For babel
             (org-babel-do-load-languages
               'org-babel-load-languages
               '(;; Draw Picture
                 (ditaa . t)
                 (dot . t)
                 (plantuml . t)
                 (latex . t)
                 ;; Program Languages
                 (emacs-lisp . t)
                 (python . t)
                 (R . t)
                 (ruby . t)
                 ))

             (setq org-confirm-babel-evaluate nil)
             (setq org-html-postamble nil)

             ;; (add-hook 'org-mode-hook #'org-indent-mode)
             (add-hook 'org-mode-hook #'yas-minor-mode)

             (global-set-key (kbd "C-c l")    'org-store-link)
             (global-set-key (kbd "C-c a")    'org-agenda)
             (global-set-key (kbd "C-c c")    'org-capture)
             (global-set-key (kbd "C-c b")    'org-switchb)
             )

(use-package org2ctex
             :ensure t
             :after org

             :config
             (org2ctex-toggle t)

             ;;; (setq-default org2ctex-latex-default-packages-alist
             ;;;               (quote
             ;;;                (("AUTO" "inputenc" t ("pdflatex"))
             ;;;                 ("T1" "fontenc" t ("pdflatex"))
             ;;;                 ("" "graphicx" t nil)
             ;;;                 ("" "grffile" t nil)
             ;;;                 ("" "longtable" nil nil)
             ;;;                 ("" "wrapfig" nil nil)
             ;;;                 ("" "rotating" nil nil)
             ;;;                 ("normalem" "ulem" t nil)
             ;;;                 ("" "amsmath" t nil)
             ;;;                 ("" "textcomp" t nil)
             ;;;                 ("" "amssymb" t nil)
             ;;;                 ("" "capt-of" nil nil)
             ;;;                 ("" "hyperref" nil nil)
             ;;;                 ("" "minted" nil nil))))

             (add-to-list 'org2ctex-latex-default-packages-alist '("" "minted" nil) t)

             (setq org2ctex-latex-commands
                   (quote
                     ("xelatex -synctex=1 --shell-es-interaction nonstopmode -output-directory %o %f"
                      "bibtex %b"
                      "xelatex -synctex=1 -interaction nonstopmode -output-directory %o %f"
                      "xelatex -synctex=1 -interaction nonstopmode -output-directory %o %f")))

             (setq org-latex-listings (quote minted))
             )

(use-package org-alert
             :ensure t
             :after org
             )

(use-package org-brain
             :ensure t
             :after org
             )

(use-package org-superstar
             :ensure t
             :after org
             :config
             (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
             (add-hook 'org-mode-hook 'turn-on-auto-fill)
             )

;; (use-package org-bars
;;              :ensure t
;;              :after org
;;              :config
;;              (add-hook 'org-mode-hook #'org-bars-mode)
;;              )

(use-package org-tag-beautify
             :ensure t
             :after org
	     :config
	     (org-tag-beautify-mode 1)
             )

(use-package org-side-tree
              :ensure t
              :after org
              )

(use-package org-edit-latex
             :ensure t
             :after org
             )

(use-package org-easy-img-insert
             :ensure t
             :after org
             )

(use-package org-mime
             :ensure t
             :after org
             )

(use-package org-msg
             :ensure t
             :after org
             )

(use-package org-pomodoro
             :ensure t
             :after org
             )

(use-package org-projectile
             :ensure t
             :after org
             )

(use-package org-super-agenda
             :ensure t
             :after org
             )

(use-package org-sidebar
             :ensure t
             :after org
             )

;; (use-package org-bullets
;;              :ensure t
;;              :after org
;;              :config
;;              (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;;              )

(use-package ox-rst
             :ensure t
             :after org
             )

(use-package org-fancy-priorities
            :ensure t
            :hook
            (org-mode . org-fancy-priorities-mode)
            :config
            (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕"))
            ) 

(use-package org-modern
             :ensure t
             :after org

             :config
             ;; Option 1: Per buffer
             (add-hook 'org-mode-hook #'org-modern-mode)
             (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
             ;; Option 2: Globally
             (with-eval-after-load 'org (global-org-modern-mode))

             (add-hook 'org-mode-hook  (lambda ()
                                         (setq prettify-symbols-alist
                                               '(("lambda" . ?λ)
                                                 (":PROPERTIES:" . ?)
                                                 (":ID:" . ?)
                                                 (":END:" . ?)
                                                 ("#+TITLE:" . ?)
                                                 ("#+AUTHOR:" . ?)
                                                 ("#+BEGIN_QUOTE" . ?)
                                                 ("#+END_QUOTE" . ?)
                                                 ("#+RESULTS:" . ?)
                                                 ("[ ]" . ?)
                                                 ("[-]" . ?)
                                                 ("[X]" . ?)))
                                         (prettify-symbols-mode)))

	     (setq
	       org-modern-star '("◉" "○" "✸" "✿" "✦" "◆")   ; 自定义标题符号
	       org-modern-todo nil                          ; 自带的美化多一条线
	       org-modern-keyword t
	       org-modern-priority nil                      ; 美化优先级
	       org-modern-timestamp t                       ; 美化时间戳
	       org-modern-tag t                             ; 美化标签
	       org-modern-table-align t                     ; 自动对齐表格
	       org-modern-checkbox nil                      ; 启用复选框美化
	       org-modern-label-border 0.3
	       )

	     (setq
	       org-pretty-entities t
	       org-hide-emphasis-markers t                  ; orgmode 的着重标记都不显示
	       org-ellipsis "…"
	       )

	     (setq org-modern-todo-faces
                   (quote (("TODO" :background "red"
                                   :foreground "yellow"))))
             )

;; (set-face-attribute 'default nil :family "Iosevka")
;; (set-face-attribute 'variable-pitch nil :family "Iosevka Aile")
;; (set-face-attribute 'org-modern-symbol nil :family "Iosevka")

;; Other packages:
;; valign
;; ox-rst
;; org-pdfview

(provide 'init-org)
;;; init-org.el ends here
