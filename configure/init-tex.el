;;; package --- Summary
;;; Commentary:

;;; Code:

;; ==================== AUCTeX 核心 ====================
(use-package tex
             :ensure auctex                            ; 安装 AUCTeX

             :mode
             ("\\.tex\\'" . LaTeX-mode)                ; .tex 文件自动进入 LaTeX-mode

             :hook (LaTeX-mode . my/LaTeX-mode-setup)  ; 主配置函数

             :custom
             ;; 编译命令与引擎
             (TeX-command-default "XeLaTeX")           ; 默认使用 XeLaTeX 编译
             (TeX-engine 'xetex)                       ; 设置 TeX 引擎
             (TeX-command-extra-options "-synctex=1")  ; 启用 SyncTeX 正向/反向搜索

             ;; 自动解析与保存
             (TeX-auto-save t)                         ; 自动保存 auctex 自动生成的缓存
             (TeX-parse-self t)                        ; 自动解析文件加载宏包
             (TeX-master nil)                          ; 不自动设置 master 文件，手动指定

             ;; 代码折叠与补全
             (TeX-electric-escape t)                   ; 输入反斜杠时自动弹出补全
             (TeX-fold-auto t)                         ; 自动折叠环境/宏
             (TeX-fold-mode t)                         ; 启用折叠模式
             (TeX-fold-type-list '(env math))          ; 折叠环境和数学公式

             ;; 清理与辅助
             (TeX-clean-confirm nil)                   ; 清理临时文件时无需确认

             ;; 自定义环境折叠规则（示例）
             (LaTeX-fold-env-spec-list '(("[figure]"       ("figure"))
                                         ("[table]"        ("table"))
                                         ("[Code-minted]"  ("minted"))
                                         ("[Item List]"    ("itemize"))
                                        )
             )

             :config
             (defun my/LaTeX-mode-setup ()
               "LaTeX 模式下的通用设置。"
               ;; 启用 RefTeX（文献引用）
               (turn-on-reftex)
               (setq reftex-plug-into-AUCTeX t)

               ;; 启用 yasnippet
               (yas-minor-mode 1)
               (yas-reload-all t)

               ;; 启用正向搜索（SyncTeX）
               (TeX-source-correlate-mode 1)

               ;; 如果需要预览，可取消注释以下两行
               ;; (latex-preview-pane-mode)
               ;; (magic-latex-buffer)
             )
)

;; ==================== RefTeX（文献引用）====================
(use-package reftex
             :ensure t                                 ; 单独安装，但通常 AUCTeX 已包含
             :after tex                                ; 在 AUCTeX 加载后配置

             :custom
             (reftex-plug-into-AUCTeX t)               ; 集成到 AUCTeX

             :config
             ;; 已通过 LaTeX-mode-hook 中的 turn-on-reftex 启用
)

;; ==================== latex-extra（额外便捷功能）====================
(use-package latex-extra
             :ensure t
             :after tex
             :hook (LaTeX-mode . latex-extra-mode)     ; 自动启用
)

;; ==================== magic-latex-buffer（实时预览）====================
;; (use-package magic-latex-buffer
;;              :ensure t
;;              :after tex
;;              :hook (LaTeX-mode . magic-latex-buffer)   ; 启用实时预览
;; )

;; ==================== auto-complete-auctex（补全增强）====================
;; (use-package auto-complete-auctex
;;              :ensure t
;;              :after (tex auto-complete)                ; 需要 auto-complete 支持
;;              :config
;;              ;; 初始化 company 或 auto-complete 与 AUCTeX 的集成
;;              (company-auctex-init)
;; )

;; ==================== 环境变量设置（用于 SyncTeX 编辑器调用）====================
;; 让 emacsclient 作为 SyncTeX 的编辑器
(setenv "SYNCTEX_EDITOR" "emacsclient --no-wait +%l %f")


(provide 'init-tex)
;;; init-tex.el ends here
