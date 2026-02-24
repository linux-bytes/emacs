;;; package --- Summary
;;; Commentary:

;;; Code:

(use-package yasnippet
             :ensure t
             :defer t

             :hook
             (prog-mode . yas-minor-mode)

             :config
             (yas-reload-all)
)

(use-package yasnippet-snippets
             :ensure t
             :defer t
             :after yasnippet
)

(setq my-gtd-misc-file
      (expand-file-name "misc.org" "~/custom/GTD")
)

(defun my-gtd-misc-template ()
       (list my-gtd-misc-file "Tasks")
)

(use-package org
             :ensure t
             :defer t

             :init
             ;; (defun my/org-mode-font-setup ()
             ;;   (when (display-graphic-p)
             ;;     (set-face-attribute 'org-table nil
             ;;                         :font "JetBrains Mono"  ;; 替换成你喜欢的等宽字体
             ;;                         :height 110)
             ;;     (set-face-attribute 'fixed-pitch nil
             ;;                         :font "JetBrains Mono"  ;; 替换成你喜欢的等宽字体
             ;;                         :height 110)
             ;;   )
             ;; )

             (defun my/org-mode-font-setup (font-name &optional height)
               (when (display-graphic-p)
                 (let ((height (or height 110)))
                   ;; 设置表格
                   (set-face-attribute 'org-table nil :font font-name :height height)
                   ;; 设置固定宽度基 face
                   (set-face-attribute 'fixed-pitch nil :font font-name :height height)
                 )
               )
             )

             ;; ---------- 钩子设置 ----------
             :hook
             ((org-mode . yas-minor-mode)
              ;; (org-mode . org-indent-mode)   ; 根据需要取消注释
              (org-mode . (lambda () (setq-local fill-column 100)))
              (org-mode . (lambda () (my/org-mode-font-setup "JetBrains Mono" 110)))
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
;;              :hook
;;              (org-mode . org-bars-mode)
;; )

(use-package org-tag-beautify
             :ensure t
             :defer t
             :after org
             :hook (org-mode . org-tag-beautify-mode)
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
             :defer t
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

;; ==================== Valign：视觉对齐表格 ====================
(use-package valign
             :ensure t                                 ; 从 GNU ELPA 安装
             :defer t

             :hook
             ((org-mode markdown-mode) . valign-mode) ; 在 Org 和 Markdown 模式中启用

             :custom
             ;; 如果你想要更美观的表格竖线，可以取消下面这行的注释
             (valign-fancy-bar t)            ; 使用更美观的表格竖线 [citation:1][citation:6]
             ;; (valign-bar-character ?━)       ; 水平线
             ;; (valign-bar-vertical ?┃)        ; 垂直线（一般不需要改）
             ;; (valign-bar-cross ?╋)           ; 交叉点

             ;; 如果你有非常大的表格（例如超过100行），valign 默认可能不会对齐以保性能。
             ;; 如果你确定需要对齐大表格，可以调整下面这个阈值（单位：字符数）。
             ;; 默认是 4000，注释掉表示使用默认值 [citation:1][citation:5][citation:7]。
             ;; (valign-max-table-size 8000)             ; 增大表格大小限制

             :config
             ;; 如果你因为某些原因需要手动移除 valign 添加的 advice，可以使用这个函数。
             ;; 注意：通常不需要手动调用，除非你完全停用 valign 并且遇到了问题 [citation:1][citation:6]。
             ;; (valign-remove-advice)
)

;; 配置 form-feed：将 ^L 字符显示为水平分隔线
(use-package form-feed
             :ensure t
             :defer t
             ;; 在编程模式和 Org 模式中都启用 form-feed-mode
             :hook
             ((prog-mode org-mode) . form-feed-mode)

             :bind
             (:map org-mode-map
                   ("C-c C-n" . form-feed-next)         ;; 跳到下一个分页符
                   ("C-c C-p" . form-feed-previous)     ;; 跳到上一个分页符
             )

             :config
             ;; 可选：自定义分隔线的外观（使用 face 属性）
             ;; 例如让分隔线更显眼：粗体、下划线、或指定颜色
             (set-face-attribute 'form-feed-line nil
                                 :height 0.1               ;; 线的高度（很细）
                                 :background "gray60"      ;; 线的颜色
                                 :underline nil)           ;; 确保不使用下划线样式
)

(use-package org-easy-img-insert
             :ensure t
             :defer t
             :after org
)

;; 安装并配置 org-download
(use-package org-download
             :ensure t
             :defer t
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
             :defer t
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

;; (use-package org-brain
;;              :ensure t
;;              :after org
;; )

(use-package org-edit-latex
             :ensure t
             :defer t
             :after org
)

(use-package org2ctex
             :ensure t
             :defer t
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
             :defer t
             :after org
)

;; 配置 pdf-tools
(use-package pdf-tools
             :ensure t
             :defer t

             :magic ("%PDF" . pdf-view-mode)  ;; 根据文件内容自动关联 PDF 模式

             :mode ("\\.pdf\\'" . pdf-view-mode)

             :hook
             (pdf-view-mode . (lambda () (display-line-numbers-mode -1)))   ; 进入 PDF 模式时关闭行号

             :config
             (pdf-tools-install :no-query)     ;; 安装并启用 pdf-tools，:no-query 避免询问
             ;; 可选：针对 HiDPI 屏幕优化显示
             ;; (setq pdf-view-use-scaling t)
             ;; 可选：性能优化
             (setq pdf-view-use-scaling nil)
             (setq pdf-view-max-image-width 1200)
)

;; ==================== org-pdftools (增强链接) ====================
;; 注意：这个包可能不在 MELPA 官方源，如果 :ensure t 失败，
;; 你需要手动从 https://github.com/fuxialexander/org-pdftools 下载
(use-package org-pdftools
             :ensure t   ;; 如果安装失败，请参考上面的注释处理
             :defer t
             :after (org pdf-tools)
             :hook (org-mode . org-pdftools-setup-link)  ;; 在 Org 模式中设置链接功能
)

;; ==================== org-noter (核心笔记工具) ====================
(use-package org-noter
             :ensure t                                     ; 确保安装
             :defer t
             :after (org pdf-tools)                        ; 在 org 和 pdf-tools 之后加载

             :bind
             (("C-c n" . org-noter)                ; 建议绑定一个顺手的关键字
              :map org-noter-doc-mode-map            ; 仅在文档缓冲区生效的键位
              (("M-p" . org-noter-sync-prev-page-or-chapter)
               ("M-n" . org-noter-sync-next-page-or-chapter)
               ("M-." . org-noter-sync-current-page-or-chapter)
              )
             )

             :custom
             (org-noter-always-create-frame nil)        ;; 建议设为 nil，在当前 Emacs 框架内分屏
             (org-noter-auto-save-last-location t)      ;; 自动保存上次阅读的位置，下次打开时直接跳转 [citation:5][citation:6]
             ;; 笔记窗口的分割方式：水平分割（文档在上，笔记在下）[citation:5]
             (org-noter-notes-window-location 'horizontal-split)
             ;; 插入笔记时，自动将文档中选中的文本放入笔记内容中 [citation:5][citation:10]
             (org-noter-insert-selected-text-inside-note t)
             ;; 隐藏与当前视图无关的其他笔记标题，保持界面清爽 [citation:5]
             (org-noter-hide-other t)
             ;; 笔记的默认标题，$p$ 会被替换为页码 [citation:5]
             (org-noter-default-heading-title "Page $p$ - %c")
             ;; 当在 dired 缓冲区中时，可以用 'M-s n' 快速为选中的文件启动会话 [citation:7]

             :config
             ;; 示例：如果想要在杀死会话时同时关闭框架，可以取消下面这行的注释
             ;; (setq org-noter-kill-frame-at-session-end t)
)

;; ==================== org-noter-pdftools (精确笔记的关键) ====================
(use-package org-noter-pdftools
             :after (org-noter org-pdftools)
             :defer t
             :config
             ;; 添加一个函数，用于插入精确笔记（基于选中的文本或光标位置）
             (defun my/org-noter-insert-precise-note ()
               (interactive)
               (org-noter--with-valid-session
                 (let ((org-pdftools-use-isearch-link t)
                       (org-pdftools-use-freepointer-annot t))
                  (org-noter-insert-note (org-noter--get-precise-info))
                 )
               )
             )

             ;; 将精确笔记命令绑定到 PDF 视图的某个快捷键，例如 C-c M-i
             (define-key pdf-view-mode-map (kbd "C-c M-i") 'my/org-noter-insert-precise-note)

             ;; 修复一些已知问题，确保与 pdftools 注释功能的兼容性
             (with-eval-after-load 'pdf-annot
                                   (add-hook 'pdf-annot-activate-handler-functions
                                             #'org-noter-pdftools-jump-to-note))
)

(use-package org-mime
             :ensure t
             :defer t
             :after org
)

(use-package org-msg
             :ensure t
             :defer t
             :after org
)

(use-package org-alert
             :ensure t
             :defer t
             :after org
)

(use-package org-pomodoro
             :ensure t
             :defer t
             :after org
)

(use-package org-projectile
             :ensure t
             :defer t
             :after org
)

(use-package org-super-agenda
             :ensure t
             :defer t
             :after org
)

(use-package org-side-tree
             :ensure t
             :defer t
             :after org
)

(use-package org-sidebar
             :ensure t
             :defer t
             :after org
)

(use-package htmlize
             :ensure t
             :defer t
)

;; Other packages:
;; valign
;; ox-rst
;; org-pdfview

(provide 'init-org)
;;; init-org.el ends here
