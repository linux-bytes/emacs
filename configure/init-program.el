;;; package --- Summary
;;; Commentary:

;;; Code:
(setq c-default-style (quote ((c-mode    . "linux")
                              (java-mode . "java")
                              (awk-mode  . "awk")
                              (other     . "gnu")))
)

(use-package sphinx-frontend
             :ensure t
             :defer t
)

(use-package graphviz-dot-mode
             :ensure t
             :defer t
             :config
             ;; graphviz-dot
             (setq-default graphviz-dot-auto-indent-on-braces t)
             (setq-default graphviz-dot-auto-indent-on-semi t)
             (setq-default graphviz-dot-auto-preview-on-save t)
)

(use-package plantuml-mode
             :ensure t
             :defer t

             ;; 文件类型关联
             :mode ("\\.pu\\'"
                    "\\.puml\\'"
                    "\\.plantuml\\'")

             ;; 按键绑定（自动绑定到 plantuml-mode-map）
             :bind
             (:map plantuml-mode-map
                   ("C-c C-c" . plantuml-preview)
                   ("C-c C-e" . plantuml-export)
                   ("C-c C-d" . plantuml-goto-diagram))

             ;; hook（拆成独立函数更清晰）
             :hook
             ((plantuml-mode . flycheck-mode)
              ;; (plantuml-mode . company-mode)
              (plantuml-mode . display-line-numbers-mode))

             ;; defcustom 变量
             :custom
             (plantuml-default-exec-mode 'jar)
             (plantuml-executable-path "/opt/plantuml")
             (plantuml-jar-path (expand-file-name "/opt/plantuml/plantuml.jar"))
             (plantuml-output-type "png")
             (plantuml-indent-level 4)
             (plantuml-server-url "http://www.plantuml.com/plantuml")
             ;; (plantuml-extra-include-paths (list (expand-file-name "~/.plantuml/c4-plantuml")))

             ;; 有逻辑判断，留在 :init
             :init
             (unless (file-exists-p (expand-file-name "/opt/plantuml/plantuml.jar"))
               (warn "PlantUML JAR not found at: %s" "/opt/plantuml/plantuml.jar"))

             ;; 有表达式求值 / 非标准设置，留在 :config
             :config
             (with-eval-after-load 'org
               (add-to-list 'org-src-lang-modes '("plantuml" . plantuml)))

             (setq plantuml-preview-command
                   (cond ((eq system-type 'windows-nt) "start")
                         ((eq system-type 'darwin) "open")
                         (t "xdg-open")))

             ;; comment 相关是 buffer-local 设置，用 hook lambda
             (add-hook 'plantuml-mode-hook
                       (lambda ()
                         (setq-local comment-start "'")
                         (setq-local comment-end "")))
)

(use-package mermaid-mode
             :ensure t
             :config
             (setq mermaid-mmdc-location (executable-find "mmdc"))
             (setq mermaid-output-format ".svg")
)

(use-package ag
             :ensure t
             :defer t
)


(use-package dts-mode
             :ensure t
             :defer t
)

;; GN
(use-package gn-mode
             :ensure t
             :defer t
             :mode ("\\.gni?\\'" . gn-mode)
             :config
             (with-eval-after-load 'org
                                   (add-to-list 'org-src-lang-modes '("gn" . gn)))
)

;; Ninja
(use-package ninja-mode
             :ensure t
             :defer t
             :mode ("\\.ninja\\'" . ninja-mode)
             :config
             (with-eval-after-load 'org
                                   (add-to-list 'org-src-lang-modes '("ninja" . ninja)))
)

(use-package corfu
             :ensure t
	     :hook (after-init . global-corfu-mode)
)

(use-package lsp-mode
             :ensure t
             :defer t
             :commands (lsp lsp-deferred)
             :hook ((prog-mode . lsp-deferred)
                    (LaTeX-mode . lsp)   ;; 进入 LaTeX 模式时自动启动 lsp-mode
                   )
             :init
             (setq lsp-keymap-prefix "C-c l")
             :config
             ;; 如果你希望 lsp-mode 也接管补全，可以关闭其自带的次要模式，
             ;; 让它只提供数据，由 Corfu 来展示。
             (setq lsp-completion-provider :capf)  ;; 关键：通过 CAPF 提供补全
)

;; 确保 lsp-ui (可选) 提供额外的视觉效果
(use-package lsp-ui
             :ensure t
             :defer t
             :commands lsp-ui-mode
)

;; ==================== Markdown 编辑核心 ====================
(use-package markdown-mode
             :ensure t
             :defer t
             :mode
             (("\\.md\\'"        . markdown-mode)   ;; 常见的 Markdown 扩展名
              ("\\.markdown\\'"  . markdown-mode)
              ("\\.mkd\\'"       . markdown-mode)
              ("README\\.md\\'"  . gfm-mode)        ;; README.md 自动启用 GitHub Flavored Markdown 模式 [citation:2]
             )
             :hook (markdown-mode . my/markdown-mode-hook) ; 自定义钩子，集中配置

             :bind
             (:map markdown-mode-map
                   ("C-c C-c"   . markdown-command)     ;; 运行外部 Markdown 处理器（如 pandoc）
                   ("C-c C-t a" . markdown-table-align) ;; 表格对齐
             )

             :custom
             (markdown-command "pandoc -f markdown -t html5 --mathjax") ;; 用 pandoc 生成 HTML，支持数学公式
             (markdown-fontify-code-blocks-natively t)    ;; 代码块内使用语法高亮 [citation:5]
             :config
             (defun my/markdown-mode-hook ()
               "Markdown 模式下的统一配置。"
               ;; 启用自动补全（需已配置 corfu/company）
               (when (bound-and-true-p corfu-mode) (setq-local corfu-auto t))
               ;; 如果使用 tree-sitter，可以尝试启用 markdown-ts-mode（Emacs 30 内置）
               ;; 注意：当前 markdown-ts-mode 功能有限，仅推荐用于纯语法高亮 [citation:3][citation:8]
               ;; (when (treesit-available-p)
               ;;   (treesit-parser-create 'markdown))
             )
)

;; ==================== 目录生成器 ====================
(use-package markdown-toc
             :ensure t
             :defer t
             :after markdown-mode
             :bind (:map markdown-mode-map
                         ("C-c C-t t" . markdown-toc-generate-toc)   ; 生成目录
                         ("C-c C-t r" . markdown-toc-refresh-toc)  ; 刷新目录 [citation:5]
                   )
)

;; ==================== 实时预览（GitHub 风格）====================
(use-package grip-mode
             :ensure t
             :defer t

             :after markdown-mode

             :hook (markdown-mode . grip-mode)           ;; 进入 Markdown 模式时自动启用

             :config
             ;; 可选：设置 grip 的默认端口和浏览器
             (setq grip-binary-path "~/.local/bin/grip")  ;; 根据实际安装路径调整
             ;; (setq grip-browser-function 'browse-url-default-browser)
)

;; ==================== 多语言代码块支持 ====================
(use-package poly-markdown
             :ensure t
             :defer t
             :after markdown-mode
             :hook (markdown-mode . poly-markdown-mode)  ;; 启用多模式支持 [citation:5]
)

;; ==================== 在独立缓冲区编辑代码块 ====================
(use-package edit-indirect
             :ensure t
             :defer t
             :after markdown-mode
             :bind (:map markdown-mode-map
                         ("C-c '" . edit-indirect-region)    ;; 编辑当前代码块 [citation:2]
                   )
)
;; ==================== Pandoc 导出集成（可选）====================
(use-package pandoc-mode
             :ensure t
             :defer t
             :after markdown-mode
             :hook (markdown-mode . pandoc-mode)          ;; 加载 pandoc-mode 次要模式
             :config
             (setq pandoc-data-dir "~/.pandoc")           ;; 指定 pandoc 数据目录
             ;; 常用导出命令：M-x pandoc-convert-file
)

(use-package with-editor
             :ensure t
             :defer t
             :config
             ;; 让 shell 模式也能使用 Emacsclient 作为编辑器
             (add-hook 'shell-mode-hook 'with-editor-export-editor)
             (add-hook 'eshell-mode-hook 'with-editor-export-editor)
)

;; ==================== Magit 核心配置 ====================
(use-package magit
             :ensure t
             :defer t
             :after (with-editor)  ;; 明确依赖

             :bind
             (("C-c g" . magit-status)
              ("C-c l" . magit-log))

             :custom
             ;; 窗口行为：在同一个窗口显示 Magit 缓冲区
             (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
             (magit-bury-buffer-function #'magit-mode-quit-window)

             ;; 安全设置：删除文件时移至回收站
             (magit-delete-by-moving-to-trash t)
             ;; 常用操作无需二次确认
             (magit-no-confirm '(stage-all-changes
                                  unstage-all-changes
                                  trash
                                  safe-with-wip))

             ;; 性能优化
             (magit-refresh-status-buffer nil)          ; 手动刷新状态缓冲区，避免频繁刷新
             (magit-refresh-verbose nil)                 ; 关闭详细刷新日志
             (magit-diff-refine-hunk 'all)                ; 显示逐词差异（可根据仓库大小调整）
             (magit-diff-paint-whitespace nil)            ; 不高亮空白差异，提升性能

             ;; 日志设置
             (magit-log-arguments '("--graph" "--decorate" "-n256"))

             ;; 提交信息设置
             (git-commit-summary-max-length 72)
             (git-commit-fill-column 72)

             :config
             ;; 优化提交缓冲区快捷键
             (with-eval-after-load 'git-commit
                                   (define-key git-commit-mode-map (kbd "C-c C-c") 'with-editor-finish)
                                   (define-key git-commit-mode-map (kbd "C-c C-k") 'with-editor-cancel))

             ;; 完全禁用 VC 模式，避免与 Magit 冲突
             ;; (setq vc-handled-backends nil)
)

;; ==================== magit-gerrit（Gerrit 代码评审支持）====================
;; (use-package magit-gerrit
;;              :ensure t
;;              :after magit
;;              :config
;;              (require 'magit-gerrit)
;;              ;; 如果需要 SSH 凭据，可以在此添加，例如：
;;              ;; (setq magit-gerrit-ssh-creds "your-username@gerrit.example.com")
;; )

;; ==================== diff-hl（行号旁显示 Git 差异标记）====================
(use-package diff-hl
             :ensure t
             :defer t
             :hook
             ((prog-mode . diff-hl-mode)               ; 编程模式中启用
              (magit-pre-refresh . diff-hl-magit-pre-refresh)
              (magit-post-refresh . diff-hl-magit-post-refresh)
             )

             :config
             (diff-hl-flydiff-mode 1)                ; 实时显示未保存的 diff
)

;; (use-package company
;;              :ensure jedi
;;              :ensure jedi-core
;;              :ensure company-jedi
;;              :ensure company-auctex
;;
;;              :init nil
;;              :config
;;              ;; 开启全局 Company 补全
;;              (global-company-mode 1)
;;              (setq company-idle-delay 0.08)
;;              (setq company-minimum-prefix-length 1)
;;              )

(provide 'init-program)
;;; init-program.el ends here
