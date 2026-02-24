;;; package --- Summary
;;; Commentary:

;;; Code:

;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 高亮当前的行
(global-hl-line-mode t)

;; 更改光标的样式
(setq-default cursor-type 'bar)

;; ========== 平滑滚动 ==========
(use-package pixel-scroll
             :ensure nil

             :custom
             ;; 基础像素滚动
             (pixel-scroll-precision-interpolate-page t)
             (pixel-scroll-precision-use-momentum t)

             ;; 滚动速度与手感
             (pixel-scroll-precision-interpolation-total-time 0.15)  ;; 插值时间（秒）
             ;; (pixel-scroll-precision-interpolation-total-time 0.2)   ;; 插值时间（秒）
             ;; (pixel-scroll-precision-interpolation-factor 8.0)
             ;; (pixel-scroll-precision-momentum-tick 0.016)   ;; 惯性刷新间隔
             ;; (pixel-scroll-precision-momentum-seconds 1.0)  ;; 惯性持续时间
             ;; (pixel-scroll-precision-initial-velocity-factor 0.25)  ;; 初始惯性


             ;; 通用滚动设置（配合使用）
             ;; (scroll-step 1)
             (scroll-conservatively 101)     ;; 避免跳到中间
             (scroll-margin 2)               ;; 光标距边缘保留行数
             (scroll-preserve-screen-position t)  ;; 翻页后光标位置不变

             :config
             (pixel-scroll-precision-mode 1)
)

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

;; 默认全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
;; (set-face-attribute 'default nil :height 120)
;; (set-default-font "Consolas")
;; (set-fontset-font "fontset-default" 'chinese-gbk "微软雅黑")
;; (setq face-font-rescale-alist '(("宋体"    . 1.4)
;;                                 ("微软雅黑" . 1.4)
;;                                 ))

;; (set-default-font "-unknown-Inconsolata-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")
;; (set-default-font "-PfEd-Inconsolata-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")
(set-frame-font "Inconsolata-12")

(use-package all-the-icons
             :ensure t
)

(use-package all-the-icons-dired
             :ensure t

             :hook
             (dired-mode . all-the-icons-dired-mode)
)

(use-package all-the-icons-gnus
             :ensure t
             :after gnus

             :config
             (all-the-icons-gnus-setup)
)

(use-package uniquify
             :ensure nil

             :custom
             (uniquify-separator "/")
             (uniquify-buffer-name-style 'forward)
)

(use-package centaur-tabs
             :ensure t
             :demand t

             :hook
             ((dashboard-mode  . centaur-tabs-local-mode)
              (term-mode       . centaur-tabs-local-mode)
              (calendar-mode   . centaur-tabs-local-mode)
              (org-agenda-mode . centaur-tabs-local-mode)
             )

             :bind
             (("C-<prior>"   . centaur-tabs-backward)
              ("C-<next>"    . centaur-tabs-forward)
              ("C-S-<prior>" . centaur-tabs-move-current-tab-to-left)
              ("C-S-<next>"  . centaur-tabs-move-current-tab-to-right)
             )

             :custom
             (centaur-tabs-enable-key-bindings t)
             (centaur-tabs-style "box")
             (centaur-tabs-height 32)
             (centaur-tabs-set-icons t)
             (centaur-tabs-show-new-tab-button t)
             (centaur-tabs-set-modified-marker t)
             (centaur-tabs-modified-marker "*")
             (centaur-tabs-show-navigation-buttons t)
             (centaur-tabs-set-bar 'under)
             (centaur-tabs-show-count nil)
             (centaur-tabs-left-edge-margin nil)
             (x-underline-at-descent-line t)
             ;; (centaur-tabs-label-fixed-length 15)
             ;; (centaur-tabs-gray-out-icons 'buffer)
             ;; (centaur-tabs-plain-icons t)
             ;; (centaur-tabs-adjust-buffer-order t)
             ;; (centaur-tabs-enable-buffer-alphabetical-reordering)

             :preface
             ;; 提前定义分组函数，:config 中引用
             (defun my/centaur-tabs-buffer-groups ()
               "`centaur-tabs-buffer-groups' control buffers' group rules.

               Group centaur-tabs with mode if buffer is derived from `eshell-mode'
               `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
               All buffer name start with * will group to \"Emacs\".
               Other buffer group by `centaur-tabs-get-group-name' with project name."
               (list (cond ((or
                              (string-equal "*" (substring (buffer-name) 0 1))
                              (memq major-mode '(magit-process-mode
                                                 magit-status-mode
                                                 magit-diff-mode
                                                 magit-log-mode
                                                 magit-file-mode
                                                 magit-blob-mode
                                                 magit-blame-mode
                                                ))
                            )
                            "Emacs")
                           ((derived-mode-p 'prog-mode) "Editing")
                           ((derived-mode-p 'dired-mode) "Dired")
                           ((memq major-mode '(helpful-mode help-mode)) "Help")
                           ((memq major-mode '(org-mode
                                                org-agenda-clockreport-mode
                                                org-src-mode
                                                org-agenda-mode
                                                org-beamer-mode
                                                org-indent-mode
                                                org-bullets-mode
                                                org-cdlatex-mode
                                                org-agenda-log-mode
                                                diary-mode)
                            ) "OrgMode")
                           (t (centaur-tabs-get-group-name (current-buffer)))
                     )
               )
             )

             :config
             (setq centaur-tabs-buffer-groups-function #'my/centaur-tabs-buffer-groups)
             (centaur-tabs-change-fonts (face-attribute 'default :font) 110)
             (centaur-tabs-headline-match)
             (centaur-tabs-mode 1)
)

(use-package dashboard
             :ensure t

             :custom
             (dashboard-banner-logo-title "Come on! Jerry")

             ;; Value can be
             ;; 'official:			which displays the official emacs logo
             ;; 'logo:				which displays an alternative emacs logo
             ;; 1, 2 or 3:			which displays one of the text banners
             ;; "path/to/your/image.png":	which displays whatever image you would prefer
             ;; (setq dashboard-startup-banner 'logo)
             (dashboard-startup-banner "~/.emacs.d/configure/mylogo.png")

             ;; Content is not centered by default. To center, set
             (dashboard-center-content t)

             ;; To disable shortcut "jump" indicators for each section, set
             (dashboard-show-shortcuts t)
             (dashboard-set-heading-icons t)
             (dashboard-set-file-icons t)
             ;; (dashboard-set-navigator t)
             (dashboard-items '((recents   . 5)
                                (bookmarks . 5)
                                (projects  . 5)
                                (agenda    . 5)
                                (registers . 5)
                               )
             )
             ;; (dashboard-modify-heading-icons '((recents . "file-text")
             ;;                                   (bookmarks . "book")))

             :config
             (dashboard-setup-startup-hook)
)

;; (use-package zenburn-theme
;;              :ensure t
;;              :config
;;              (load-theme 'zenburn t)
;;              )
;; 
;; (use-package monokai-theme
;;              :ensure t
;;              :config
;;              ;; 加载 monokai 主题
;;              (load-theme 'monokai t)
;;              )
;; 
;; (use-package kaolin-themes
;;              :ensure t
;;              :config
;;              (load-theme 'kaolin-dark t)
;;              (kaolin-treemacs-theme)
;;              ;; The following set to t by default
;;              (setq kaolin-themes-bold t       ; If nil, disable the bold style.
;;                    kaolin-themes-italic t     ; If nil, disable the italic style.
;;                    kaolin-themes-underline t) ; If nil, disable the underline style.
;; 
;;              ;; If t, use the wave underline style instead of regular underline.
;;              (setq kaolin-themes-underline-wave t)
;; 
;;              ;; When t, will display colored hl-line style
;;              (setq kaolin-themes-hl-line-colored t)
;; 
;;              (setq inhibit-compacting-font-caches t)
;;              (setq kaolin-themes 'icons)
;;              )

;; ==========================================
;; Modus Themes - Emacs 内置高质量主题
;; 文档: https://protesilaos.com/emacs/modus-themes
;; 调色板查看: M-x modus-themes-list-colors
;; ==========================================
(use-package modus-themes
             :ensure t
	     :demand t

             ;; ------------------------------------------
             ;; 按键绑定
             ;; ------------------------------------------
             :bind
             ("<f5>" . modus-themes-toggle)

             ;; ------------------------------------------
             ;; defcustom 变量（必须在 load-theme 之前生效）
             ;; ------------------------------------------
             :custom
             ;; 基础排版
             (modus-themes-italic-constructs t)          ; 注释/文档用斜体
             (modus-themes-bold-constructs nil)          ; 关键字不加粗
             (modus-themes-mixed-fonts t)                ; 允许混合等宽/比例字体
             (modus-themes-variable-pitch-ui nil)        ; UI 元素不用比例字体

             ;; 主题行为
             (modus-themes-custom-auto-reload t)         ; 修改配置后自动重载
             (modus-themes-disable-other-themes t)       ; 加载时禁用其他主题

             ;; 提示符样式
             (modus-themes-prompts '(italic bold))

             ;; Org 代码块背景
             ;; nil            → 无背景
             ;; gray-background → 灰色背景
             ;; tinted-background → 带色调背景
             (modus-themes-org-blocks 'gray-background)

             ;; ------------------------------------------
             ;; 补全框架样式（可选）
             ;; matches   :: 匹配文字样式
             ;; selection :: 选中项样式
             ;; 可用属性: underline, italic, WEIGHT
             ;; ------------------------------------------
             ;; (modus-themes-completions '((matches   . (extrabold))
             ;;                             (selection  . (semibold italic text-also))
             ;;                            )
             ;; )
             ;; (modus-themes-completions '((t . (thin italic))))

             ;; ------------------------------------------
             ;; 标题层级样式（可选）
             ;; 格式: (LEVEL . (PROPERTIES...))
             ;; 可用属性: variable-pitch, WEIGHT, HEIGHT(倍数)
             ;; ------------------------------------------
             ;; (modus-themes-headings '((1 . (variable-pitch 1.5))
             ;;                          (2 . (1.3))
             ;;                          (agenda-date . (1.3))
             ;;                          (agenda-structure . (variable-pitch light 1.8))
             ;;                          (t . (1.1))
             ;;                         )
             ;; )

             ;; (modus-themes-headings '((1 . (thin 1.2))
             ;;                          (2 . (1.1))
             ;;                          (agenda-date . (1.2))
             ;;                          (agenda-structure . (variable-pitch light 1.8))
             ;;                          (t . (1.1))
             ;;                         )
             ;; )

             ;; (modus-themes-headings '((1 . t)                 ; 保持默认
             ;;                          (2 . (semibold 0.0))
             ;;                          (t . (rainbow))         ; 其余标题用彩虹色
             ;;                         )
             ;; )

             :config
             ;; ------------------------------------------
             ;; 调色板覆盖（备选方案，按需启用一组）
             ;; 查看可用颜色: M-x modus-themes-list-colors
             ;; ------------------------------------------

             ;; 调色板覆盖（使用内置的高强度预设）
             (setq modus-themes-common-palette-overrides modus-themes-preset-overrides-intense)

             ;; --- TODO/DONE 样式 ---
             ;; (setq modus-themes-common-palette-overrides '((prose-done green-faint)
             ;;                                               (prose-todo red-faint))
             ;; )

             ;; (setq modus-themes-common-palette-overrides '((prose-done green-intense)
             ;;                                               (prose-todo red-intense))
             ;; )

             ;; (setq modus-themes-common-palette-overrides '((prose-done fg-dim)))

             ;; --- 散文/代码/元数据 全套覆盖 ---
             ;; (setq modus-themes-common-palette-overrides '((prose-block          fg-dim)
             ;;                                               (prose-code           green-cooler)
             ;;                                               (prose-done           green)
             ;;                                               (prose-macro          magenta-cooler)
             ;;                                               (prose-metadata       fg-dim)
             ;;                                               (prose-metadata-value fg-alt)
             ;;                                               (prose-table          fg-alt)
             ;;                                               (prose-tag            magenta-faint)
             ;;                                               (prose-todo           red)
             ;;                                               (prose-verbatim       magenta-warmer)
             ;;                                              )
             ;; )

             ;; --- Mode-line 边框 ---
             ;; 无边框:
             ;; (setq modus-themes-common-palette-overrides '((border-mode-line-active   unspecified)
             ;;                                               (border-mode-line-inactive unspecified)
             ;;                                              )
             ;; )

             ;; 与背景同色边框（柔和）:
             ;; (setq modus-themes-common-palette-overrides '((border-mode-line-active   bg-mode-line-active)
             ;;                                               (border-mode-line-inactive bg-mode-line-inactive)
             ;;                                              )
             ;; )

             ;; --- 标题背景/上划线/下划线 ---
             ;; (setq modus-themes-common-palette-overrides '((bg-heading-1        bg-dim)
             ;;                                               (overline-heading-1  blue)
             ;;                                               (underline-heading-1 green)
             ;;                                              )
             ;; )

             ;; (setq modus-themes-common-palette-overrides '((fg-heading-1        blue-warmer)
             ;;                                               (bg-heading-1        bg-blue-nuanced)
             ;;                                               (overline-heading-1  blue)
             ;;                                              )
             ;; )

             ;; --- 多层级标题背景色 ---
             ;; (setq modus-themes-common-palette-overrides '((bg-heading-1        bg-green-intense)
             ;;                                               (bg-heading-2        bg-red-subtle)
             ;;                                               (bg-heading-3        bg-magenta-subtle)
             ;;                                               (overline-heading-1  "blue")
             ;;                                               (underline-heading-2 "red")
             ;;                                               (overline-heading-3  "blue")
             ;;                                              )
             ;; )

             ;; --- Org 优先级 face（搭配 TODO 样式使用）---
             ;; (setq org-priority-faces '((?A . (:inherit (bold org-priority)))
             ;;                            (?B . org-priority)
             ;;                            (?C . (:inherit (shadow org-priority)))
             ;;                           )
             ;; )

             ;; ------------------------------------------
             ;; 加载主题（必须在所有 setq 之后）
             ;; ------------------------------------------
             ;; (load-theme 'modus-vivendi t)      ;; 暗色主题
             (load-theme 'modus-operandi t)
)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; (use-package gruvbox-theme
;;              :ensure t
;;              :config
;;              (load-theme 'gruvbox-dark-medium t)
;; )

(provide 'init-ui)
;;; init-ui.el ends here
