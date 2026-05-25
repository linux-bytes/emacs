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

;; Dirvish (功能更强的文件管理器)
(use-package dirvish
	     :ensure t
	     :init
	     ;; 将 extensions/ 子目录加入 load-path，以便加载扩展模块
	     (let ((ext-dir (expand-file-name "extensions"
                                              (file-name-directory (locate-library "dirvish")))
                  ))
	      (when (file-directory-p ext-dir)
                    (add-to-list 'load-path ext-dir)
              )
	     )
	     (dirvish-override-dired-mode)   ;; 全局接管 dired，所有 dired 调用都走 dirvish

	     :custom
             (dirvish-quick-access-entries    ;; 快速访问目录（`a' 键）
               '(("h" "~/"         "Home")
                 ("d" "~/Downloads" "Downloads"))
	     )
	     (dirvish-mode-line-format        ;; 状态栏信息
               '(:left (sort symlink) :right (omit yank index))
             )
	     (dirvish-attributes              ;; 显示属性：图标 + 文件大小 + 修改时间
               '(nerd-icons file-size collapse subtree-state vc-state git-msg))
	     (delete-by-moving-to-trash t)   ;; 删除移入回收站

             :config
             (require 'dirvish-quick-access)
             (require 'dirvish-history)
             (require 'dirvish-subtree)
             (require 'dirvish-narrow)
             (require 'dirvish-yank)
             (require 'dirvish-vc)
             (require 'dirvish-emerge)
             (require 'dirvish-ls)

             :bind
             (("C-c f" . dirvish)             ;; 打开 dirvish
              :map dirvish-mode-map
              ("a"   . dirvish-quick-access)
              ("f"   . dirvish-file-info-menu)
              ("y"   . dirvish-yank-menu)
              ("N"   . dirvish-narrow)
              ("^"   . dirvish-history-last)
              ("h"   . dirvish-history-jump)
              ("s"   . dirvish-quicksort)
              ("v"   . dirvish-vc-menu)
              ("TAB" . dirvish-subtree-toggle)
              ("M-f" . dirvish-history-go-forward)
              ("M-b" . dirvish-history-go-backward)
              ("M-l" . dirvish-ls-switches-menu)
              ("M-m" . dirvish-mark-menu)
              ("M-t" . dirvish-layout-switch)
              ("M-s" . dirvish-setup-menu)
              ("M-e" . dirvish-emerge-menu)
              ("M-j" . dirvish-fd-jump))
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
             (recentf-exclude (list (expand-file-name "elpa/" user-emacs-directory)))  ;; 排除插件目录

             :config
             (recentf-mode 1)
)

(provide 'init-misc-pkg)
;;; init-misc-pkg.el ends here
