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

;; 当光标移出屏幕外，文本只会滚动一行
(setq scroll-step           1
      scroll-conservatively 10000)

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

(require 'all-the-icons-gnus)
(all-the-icons-gnus-setup)

(require 'zenburn-theme)
(load-theme 'zenburn t)

(centaur-tabs-mode t)
(global-set-key (kbd "C-<prior>") 'centaur-tabs-backward)
(global-set-key (kbd "C-<next>")  'centaur-tabs-forward)

(setq centaur-tabs-style "wave")
(setq centaur-tabs-height 32)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-gray-out-icons 'buffer)
(setq centaur-tabs-set-bar 'over)

;; (setq centaur-tabs-set-bar 'under)
;; (setq x-underline-at-descent-line t)

(setq centaur-tabs-set-modified-marker t)

;; (centaur-tabs-change-fonts "arial" 160)

;; Disable centaur-tabs in dired mode
(add-hook 'dired-mode-hook 'centaur-tabs-local-mode)
(add-hook 'dashboard-mode-hook 'centaur-tabs-local-mode)
(add-hook 'calendar-mode-hook 'centaur-tabs-local-mode)
(add-hook 'org-agenda-mode-hook 'centaur-tabs-local-mode)
(add-hook 'custom-mode-hook 'centaur-tabs-local-mode)
(add-hook 'cscope-minor-mode-hook 'centaur-tabs-local-mode)
(add-hook 'helpful-mode-hook 'centaur-tabs-local-mode)
(add-hook 'term-mode-hook 'centaur-tabs-local-mode)

;; (setq centaur-tabs--buffer-show-groups t)
(setq centaur-tabs-cycle-scope 'tabs)

;; Apply treemacs customization for Kaolin themes, requires the all-the-icons package.
;; (kaolin-treemacs-theme)

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
;;; init-ui.el ends here
