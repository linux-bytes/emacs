;;; package --- Summary
;;; Commentary:

;;; Code:
(setq my-gtd-misc-file
      (expand-file-name "misc.org" "~/custom/GTD")
)

(defun my-gtd-misc-template ()
       (list my-gtd-misc-file "Tasks")
)

(use-package org
	     :ensure t

	     ;; ---------- 钩子设置 ----------
	     :hook
	     ((org-mode . yas-minor-mode)
	      ;; (org-mode . org-indent-mode)   ; 根据需要取消注释
	      (org-mode . (lambda () (setq-local fill-column 100)))
	     )

	     ;; ---------- 用户选项变量（defcustom） ----------
	     :custom
	     (org-edit-src-content-indentation 0)
	     (org-fontify-whole-heading-line t)
	     (org-support-shift-select t)
	     (org-refile-targets nil)
	     (org-tags-column 100)
	     ;; (org-indent-indentation-per-level 2)   ; 可选
	     (org-plantuml-jar-path "/opt/plantuml/plantuml.jar")
	     (org-confirm-babel-evaluate nil)
	     ;; (org-image-actual-width '(500))
	     (org-pretty-entities t)
	     (org-hide-emphasis-markers t)          ; 隐藏着重标记
	     (org-ellipsis "…")

	     ;; TODO 关键词及颜色
	     (org-todo-keywords
	       '((sequence "TODO(p!)" "RUNNING(g!)" "HOLD(b!)" "|" "DONE(d!)" "CANCELED(c@/!)")
                )
	     )

	     (org-todo-keyword-faces
               '(("TODO"     . (:background "red"         :foreground "white" :weight bold))
                 ("RUNNING"  . (:background "magenta"     :foreground "white" :weight bold))
                 ("HOLD"     . (:background "blue"        :foreground "white" :weight bold))
                 ("DONE"     . (:background "dodger blue" :foreground "white" :weight bold))
                 ("CANCELED" . (:background "PaleGreen4"  :foreground "white" :weight bold))
                )
             )

	     ;; 优先级颜色
	     (org-priority-faces
               '((?A . (:foreground "red"   :weight bold))
                 (?B . (:foreground "blue"  :weight bold))
                 (?C . (:foreground "black" :weight bold))
                 (?D . (:foreground "white" :weight bold))
                )
             )

	     ;; 文件及捕获模板
	     (org-default-notes-file my-gtd-misc-file)          ; 确保此变量已定义
	     (org-agenda-files "~/custom/GTD/org_gtd_list.txt")
	     (org-refile-targets '((org-agenda-files :maxlevel . 2)))
	     (org-capture-templates
               '(("t" "Create a new misc task." entry (file+headline "" "Misc Tasks")
                  "** %?\n %U" :empty-lines-after 1)
                 ("i" "Create a new idea." entry (file+headline "" "Ideas")
                  "** %i\n %U" :empty-lines-after 1)
                 ("p" "Create a temp project task." entry (file+headline "" "Temp Project")
                  "** %?\n %U" :empty-lines-after 1))
               )

	     ;; HTML 导出样式
	     (org-html-head (format "<link rel=\"stylesheet\" type=\"text/css\" href=\"%s\"/>"
                                    (expand-file-name "configure/org_style/style.css" user-emacs-directory))
             )

	     ;; 其他选项
	     (org-confirm-babel-evaluate nil)
	     (org-html-postamble nil)

	     ;; ---------- 需要执行代码的部分 ----------
	     :config
	     ;; 调用自定义函数（假设它存在）
	     (my-gtd-misc-template)

	     ;; 加载 Babel 语言支持（必须调用函数）
	     (org-babel-do-load-languages
               'org-babel-load-languages
               '((ditaa . t)
                 (dot . t)
                 (plantuml . t)
                 (shell . t)
                 (latex . t)
                 (emacs-lisp . t)
                 (python . t)
                 (R . t)
                 (ruby . t))
               )

	     ;; 执行后自动显示图片
	     (add-hook 'org-babel-after-execute-hook
                       'org-redisplay-inline-images)
	     ;; (add-hook 'org-mode-hook (lambda () (flymake-mode -1)))

	     ;; ---------- 全局键绑定（用 :bind 更优雅） ----------
	     :bind
	     (("C-c l" . org-store-link)
	      ("C-c a" . org-agenda)
	      ("C-c c" . org-capture)
	      ("C-c b" . org-switchb)
	     )
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
;; )

(use-package org-tag-beautify
             :ensure t
             :after org
	     :config
	     (org-tag-beautify-mode 1)
)

(use-package org-fancy-priorities
            :ensure t

            :hook
            (org-mode . org-fancy-priorities-mode)

            :config
            (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕"))
)

;; (use-package org-bullets
;;              :ensure t
;;              :after org
;;              :config
;;              (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; )

;; ==========================================
;; org-modern 美化
;; ==========================================
(use-package org-modern
	     :ensure t
	     :after org

	     ;; hook：选择 per-buffer 方式（推荐，更可控）
	     :hook
	     ((org-mode            . org-modern-mode)
	      (org-agenda-finalize . org-modern-agenda)
	     )

	     ;; defcustom 变量
	     :custom
	     (org-modern-star '("◉" "○" "✸" "✿" "✦" "◆"))
	     (org-modern-todo nil)
	     (org-modern-keyword t)
	     (org-modern-priority nil)
	     (org-modern-timestamp t)
	     (org-modern-tag t)
	     (org-modern-table-align t)
	     (org-modern-checkbox nil)
	     (org-modern-label-border 0.3)
	     (org-modern-todo-faces '(("TODO" :background "red" :foreground "yellow")))

	     ;; lambda hook 和其他配置
	     :config
	     (add-hook 'org-mode-hook (lambda ()
                                        (setq-local prettify-symbols-alist
                                                    '(("lambda"        . ?λ)
                                                      (":PROPERTIES:"  . ?)
                                                      (":ID:"          . ?)
                                                      (":END:"         . ?)
                                                      ("#+TITLE:"      . ?)
                                                      ("#+AUTHOR:"     . ?)
                                                      ("#+BEGIN_QUOTE" . ?)
                                                      ("#+END_QUOTE"   . ?)
                                                      ("#+RESULTS:"    . ?)
                                                      ("[ ]"           . ?)
                                                      ("[-]"           . ?)
                                                      ("[X]"           . ?)
                                                     )
                                        )
                                        (prettify-symbols-mode 1)
                                      )
             )
)

(use-package org-easy-img-insert
             :ensure t
             :after org
)

;; 安装并配置 org-download
(use-package org-download
	     :ensure t
	     :after org
	     :bind (:map org-mode-map
                         ("C-c s" . org-download-screenshot)   ; 绑定截图快捷键
                         ("C-c y" . org-download-yank))        ; 从剪贴板粘贴图片链接
	     :custom
	     ;; 截图命令：调用 flameshot 的 GUI 模式，并将图片保存到 %s 指定路径
	     (org-download-screenshot-method "flameshot gui --path %s")
  
	     ;; 图片保存方式：'directory 表示保存到指定目录，'attach 使用 Org 附件机制
	     (org-download-method 'directory)

	     ;; 图片存放根目录（nil 表示保存在当前 Org 文件所在目录）
             (org-download-image-dir "images")
  
             ;; (org-download-heading-lvl nil)

	     ;; 可选：自定义文件名时间戳格式（默认 "%Y%m%d-%H%M%S"）
	     ;; (org-download-timestamp "%Y%m%d-%H%M%S")
  
	     :config
	     ;; 启用拖拽图片插入功能（可选）
	     (add-hook 'org-mode-hook #'org-download-enable)
)

(use-package org-roam
             :ensure t
             :after org

             :custom
             ;; (org-roam-directory (file-truename "~/custom/org-roam/"))
             ;; (org-roam-db-location (expand-file-name "org-roam.db" user-emacs-directory))
             (org-roam-directory (file-truename "~/custom/org-roam/org-files/"))
             (org-roam-db-location (expand-file-name "../org-roam.db" org-roam-directory))

             :bind
	     (("C-c n l" . org-roam-buffer-toggle)
              ("C-c n f" . org-roam-node-find)
              ("C-c n g" . org-roam-graph)
              ("C-c n i" . org-roam-node-insert)
              ("C-c n c" . org-roam-capture)
              ("C-c n b" . org-roam-switch-to-buffer)
              ("C-c n t" . org-roam-tag-add)
              ("C-c n a" . org-roam-alias-add)
	     )

             :config
             (org-roam-db-autosync-mode)
)

(use-package org-brain
             :ensure t
             :after org
)

(use-package org-edit-latex
             :ensure t
             :after org
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
                      "xelatex -synctex=1 -interaction nonstopmode -output-directory %o %f")
                   )
             )

             (setq org-latex-listings (quote minted))
)

(use-package ox-rst
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

(use-package org-alert
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

(use-package org-side-tree
             :ensure t
             :after org
)

(use-package org-sidebar
             :ensure t
             :after org
)

;; Other packages:
;; valign
;; ox-rst
;; org-pdfview

(provide 'init-org)
;;; init-org.el ends here
