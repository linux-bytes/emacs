;;; package -- Summury
;;; Just for some customise of other misc packages
;;; Commentary:
;;; Code:

;; For image-mode
(use-package eimp
             :ensure t
             :hook
             (image-mode . eimp-mode)
)

;; 增强 Dired 的语法高亮
(use-package diredfl
             :ensure t
             :hook (dired-mode . diredfl-mode)   ;; 等价于 (diredfl-global-mode 1)，但更精确
)

;; 为 Dired 添加图标
(use-package all-the-icons-dired
             :ensure t
             :hook (dired-mode . all-the-icons-dired-mode)
)

;; 增强 image-dired 的功能（需要额外包 image-dired+）
(use-package image-dired+
             :ensure t
             :after (image-dired org)           ;; 在 image-dired 加载后加载
             :hook
             (image-dired-mode . (lambda ()
                                   (image-diredx-async-mode 1)
                                   (image-diredx-adjust-mode 1)
                                 )
             )
)

(use-package google-translate
             :ensure t
             :bind
             (("C-c q" . google-translate-at-point)
              ("C-c Q" . google-translate-smooth-translate)
             )

             :custom
             (google-translate-output-destination nil)          ;; 输出到当前缓冲区
             (google-translate-default-source-language "auto")  ;; 源语言自动检测
             (google-translate-default-target-language "zh-CN") ;; 目标语言简体中文
             (google-translate-pop-up-buffer-set-focus t)       ;; 弹出缓冲区时获取焦点

             :config
             ;; 加载平滑翻译 UI（如果确为独立模块，可保留；否则可删除）
             (require 'google-translate-smooth-ui nil :noerror)
)

(use-package page-break-lines
             :ensure t
             :hook
             (after-init . global-page-break-lines-mode)  ;; 全局启用

             :config
             ;; 确保分页线字符使用默认字体族，避免显示为方块
             (set-fontset-font "fontset-default"
                               (cons page-break-lines-char page-break-lines-char)
                               (face-attribute 'default :family)
             )
)

(use-package projectile
             :ensure t
             :bind-keymap
             ("C-c p" . projectile-command-map)   ;; 将 C-c p 绑定到命令前缀映射

             :config
             (projectile-mode +1)
)

(use-package recentf
             ;; :ensure t  ;; 内置包，无需安装
             :bind ("C-x C-o" . recentf-open-files)

             :custom
             (recentf-max-menu-item 10)                       ;; 菜单中显示最近文件数
             (recentf-exclude (list (expand-file-name "~/.emacs.d/elpa/")))  ;; 排除插件目录

             :config
             (recentf-mode 1)
)

(provide 'init-misc-pkg)
;;; init-misc-pkg.el ends here
