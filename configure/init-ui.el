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

(use-package all-the-icons
             :ensure t
             :ensure all-the-icons-gnus
             :ensure all-the-icons-dired
             :config

             (all-the-icons-gnus-setup)
             )

(use-package centaur-tabs
             :ensure t
             :config

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

             (setq centaur-tabs-show-navigation-buttons t)

             ;; Disable centaur-tabs in dired mode
             (add-hook 'dired-mode-hook 'centaur-tabs-local-mode)
             (add-hook 'dashboard-mode-hook 'centaur-tabs-local-mode)
             (add-hook 'calendar-mode-hook 'centaur-tabs-local-mode)
             (add-hook 'org-agenda-mode-hook 'centaur-tabs-local-mode)
             (add-hook 'custom-mode-hook 'centaur-tabs-local-mode)
             (add-hook 'cscope-minor-mode-hook 'centaur-tabs-local-mode)
             (add-hook 'helpful-mode-hook 'centaur-tabs-local-mode)
             (add-hook 'term-mode-hook 'centaur-tabs-local-mode)
             (add-hook 'image-mode-hook 'centaur-tabs-local-mode)

             ;; (setq centaur-tabs--buffer-show-groups t)
             (setq centaur-tabs-cycle-scope 'tabs)
             )

(use-package dashboard
             :ensure t
             :config
             (dashboard-setup-startup-hook)

             ;; Set the title
             (setq dashboard-banner-logo-title "Come on! Jerry")
             ;; Set the banner
             (setq dashboard-startup-banner "~/.emacs.d/configure/mylogo.png")

             ;; (setq dashboard-startup-banner 'logo)
             ;; Value can be
             ;; 'official which displays the official emacs logo
             ;; 'logo which displays an alternative emacs logo
             ;; 1, 2 or 3 which displays one of the text banners
             ;; "path/to/your/image.png" which displays whatever image you would prefer

             ;; Content is not centered by default. To center, set
             (setq dashboard-center-content t)

             ;; To disable shortcut "jump" indicators for each section, set
             (setq dashboard-show-shortcuts nil)
             (setq dashboard-items '((recents  . 5)
                                     (bookmarks . 5)
                                     (projects . 5)
                                     (agenda . 5)
                                     (registers . 5)))

             (setq dashboard-set-heading-icons t)
             (setq dashboard-set-file-icons t)

             ;; (dashboard-modify-heading-icons '((recents . "file-text")
             ;;                                   (bookmarks . "book")))

             ;; (setq dashboard-set-navigator t)
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

(use-package modus-themes
             :ensure t
             :config
             ;; Add all your customizations prior to loading the themes
             (setq modus-themes-italic-constructs t
                   modus-themes-bold-constructs nil)

             ;; Maybe define some palette overrides, such as by using our presets
             (setq modus-themes-common-palette-overrides
                   modus-themes-preset-overrides-intense)

             (setq modus-themes-mixed-fonts t
                   modus-themes-variable-pitch-ui nil
                   modus-themes-custom-auto-reload t
                   modus-themes-disable-other-themes t

                   ;; Options for `modus-themes-prompts' are either nil (the
                   ;; default), or a list of properties that may include any of those
                   ;; symbols: `italic', `WEIGHT'
                   modus-themes-prompts '(italic bold)

                   ;; The `modus-themes-completions' is an alist that reads two
                   ;; keys: `matches', `selection'.  Each accepts a nil value (or
                   ;; empty list) or a list of properties that can include any of
                   ;; the following (for WEIGHT read further below):
                   ;;
                   ;; `matches'   :: `underline', `italic', `WEIGHT'
                   ;; `selection' :: `underline', `italic', `WEIGHT'
                   ;; modus-themes-completions
                   ;; '((matches . (extrabold))
                   ;;   (selection . (semibold italic text-also)))

                   modus-themes-completions '((t . (thin italic)))

                   modus-themes-org-blocks  'gray-background ; {nil,'gray-background,'tinted-background}

                   ;; The `modus-themes-headings' is an alist: read the manual's
                   ;; node about it or its doc string.  Basically, it supports
                   ;; per-level configurations for the optional use of
                   ;; `variable-pitch' typography, a height value as a multiple of
                   ;; the base font size (e.g. 1.5), and a `WEIGHT'.
                   ;; modus-themes-headings
                   ;;    '((1 . (thin 1.2))
                   ;;      (2 . (1.1))
                   ;;      (agenda-date . (1.2))
                   ;;      (agenda-structure . (variable-pitch light 1.8))
                   ;;      (t . (1.1)))
                   )

             ;; (setq modus-themes-common-palette-overrides
             ;;        '((prose-done green-faint)   ; OR replace `green-faint' with `olive'
             ;;          (prose-todo red-faint)))   ; OR replace `red-faint' with `rust'
             ;; (setq org-priority-faces
             ;;       '((?A . (:inherit (bold org-priority)))
             ;;         (?B . org-priority)
             ;;         (?C . (:inherit (shadow org-priority)))))

             ;; (setq modus-themes-common-palette-overrides
             ;;       '((prose-done green-intense)
             ;;         (prose-todo red-intense)))

             ;; (setq modus-themes-common-palette-overrides
             ;;         '((prose-done fg-dim)))

             ;;  (setq modus-themes-common-palette-overrides
             ;;        '((prose-block fg-dim)
             ;;          (prose-code green-cooler)
             ;;          (prose-done green)
             ;;          (prose-macro magenta-cooler)
             ;;          (prose-metadata fg-dim)
             ;;          (prose-metadata-value fg-alt)
             ;;          (prose-table fg-alt)
             ;;          (prose-tag magenta-faint)
             ;;          (prose-todo red)
             ;;          (prose-verbatim magenta-warmer)))
             ;;  (setq modus-themes-common-palette-overrides
             ;;        '((border-mode-line-active unspecified)
             ;;          (border-mode-line-inactive unspecified)))

             ;;  (setq modus-themes-common-palette-overrides
             ;;        '((border-mode-line-active bg-mode-line-active)
             ;;          (border-mode-line-inactive bg-mode-line-inactive)))

             ;;  (setq modus-themes-common-palette-overrides
             ;;        '((bg-heading-1 bg-dim)
             ;;          (overline-heading-1 blue)
             ;;          (underline-heading-1 green)))

             ;; (setq modus-themes-common-palette-overrides
             ;;       '((fg-heading-1 blue-warmer)
             ;;         (bg-heading-1 bg-blue-nuanced)
             ;;         (overline-heading-1 blue)))

             (setq modus-themes-common-palette-overrides
                   '((bg-heading-1 "#c0deff")
                     (bg-heading-2 bg-red-nuanced)
                     (bg-heading-3 bg-green-nuanced)
                     (overline-heading-1 nil)))

             ;; (setq modus-themes-headings
             ;;          '((1 . (variable-pitch 1.5))
             ;;            (2 . (1.3))
             ;;            (agenda-date . (1.3))
             ;;            (agenda-structure . (variable-pitch light 1.8))
             ;;            (t . (1.1))))

             ;; (setq modus-themes-headings
             ;;          '((1 . t)           ; keep the default style
             ;;            (2 . (semibold 0.0))
             ;;            (t . (rainbow)))) ; style for all other headings

             ;; (setq modus-themes-variable-pitch-ui t)
             ;; (setq modus-themes-org-blocks 'gray-background) ;; {nil,'gray-background,'tinted-background} 

             ;; Load the theme of your choice.
             (load-theme 'modus-operandi t)
             ;; (load-theme 'modus-vivendi t)
             (define-key global-map (kbd "<f5>") #'modus-themes-toggle)
             )

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(provide 'init-ui)
;;; init-ui.el ends here
