;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 高亮当前的行
(global-hl-line-mode t)

;; 更改光标的样式（不能生效，解决方案见第二集）
(setq-default cursor-type 'bar)

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

;; 默认全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
;; (set-face-attribute 'default nil :height 120)

(require 'kaolin-themes)
(load-theme 'kaolin-dark t)

;; Apply treemacs customization for Kaolin themes, requires the all-the-icons package.
(kaolin-treemacs-theme)

;; Or if you have use-package installed
;;(use-package kaolin-themes
;;             :config
;;             (load-theme 'kaolin-dark t)
;;             (kaolin-treemacs-theme))

;;  Custom theme settings

;; The following set to t by default
(setq kaolin-themes-bold t       ; If nil, disable the bold style.
      kaolin-themes-italic t     ; If nil, disable the italic style.
      kaolin-themes-underline t) ; If nil, disable the underline style.

;; If t, use the wave underline style instead of regular underline.
(setq kaolin-themes-underline-wave t)

;; When t, will display colored hl-line style
(setq kaolin-themes-hl-line-colored t)

;; 加载 monokai 主题
;; (load-theme 'monokai t)
(provide 'init-ui)
