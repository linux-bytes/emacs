;;; package -- Summury
;;; Just for some customise of other misc packages
;;; Commentary:
;;; Code:

(use-package graphviz-dot-mode
             :ensure t
             :config
             ;; graphviz-dot
             (setq-default graphviz-dot-auto-indent-on-braces t)
             (setq-default graphviz-dot-auto-indent-on-semi t)
             (setq-default graphviz-dot-auto-preview-on-save t)
             )

(use-package eimp
             :ensure t
             :config
             ;; image
             (eimp-mode 1)
             (add-hook 'image-mode-hook 'eimp-mode)
             )

(use-package diredfl
             :ensure t

             :config
             (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

             (diredfl-global-mode 1)
             (eval-after-load 'image-dired '(require 'image-dired+))
             (eval-after-load 'image-dired+ '(image-diredx-async-mode 1))
             (eval-after-load 'image-dired+ '(image-diredx-adjust-mode 1))
             )

(use-package plantuml-mode
            :ensure t
            :defer t
            :init
            ;; 设置 PlantUML JAR 文件路径（根据实际路径修改）
            (setq plantuml-default-exec-mode (quote jar))
            (setq plantuml-executable-path "/opt/plantuml")
            (setq plantuml-jar-path (expand-file-name "/opt/plantuml/plantuml.jar"))

            ;; 验证路径是否存在
            (unless (file-exists-p plantuml-jar-path)
              (warn "PlantUML JAR not found at: %s" plantuml-jar-path))

            :config
            ;; 文件类型关联
            (add-to-list 'auto-mode-alist '("\\.pu\\'" . plantuml-mode))
            (add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))
            (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
            (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

            ;; 设置默认输出类型
            (setq plantuml-output-type "png")

            ;; 设置预览命令（根据系统选择）
            (setq plantuml-preview-command
                  (cond ((eq system-type 'windows-nt) "start")
                        ((eq system-type 'darwin) "open")
                        (t "xdg-open")))

            ;; 启用缩进支持
            (setq plantuml-indent-level 4)

            ;; 自定义按键绑定
            (with-eval-after-load 'plantuml-mode
                                  (define-key plantuml-mode-map (kbd "C-c C-c") 'plantuml-preview)
                                  (define-key plantuml-mode-map (kbd "C-c C-e") 'plantuml-export)
                                  (define-key plantuml-mode-map (kbd "C-c C-d") 'plantuml-goto-diagram))

            ;; 自动启用某些功能
            (add-hook 'plantuml-mode-hook
                      (lambda ()
                        (setq-local comment-start "'")
                        (setq-local comment-end "")
                        (company-mode t)  ; 启用自动补全
                        (flycheck-mode t) ; 启用语法检查
                        (display-line-numbers-mode t)))

            ;; 可选：设置服务器模式避免启动JVM延迟
            (setq plantuml-server-url "http://www.plantuml.com/plantuml")

            ;; 可选：集成C4模型支持
            ;; (setq plantuml-extra-include-paths
            ;;      (list (expand-file-name "~/.plantuml/c4-plantuml")))
            )

;; For Google Translate
(use-package google-translate
             :ensure t
             :config
             (require 'google-translate-smooth-ui)
             (setq google-translate-output-destination nil)

             ;; English to Chinese Simplified
             (setq-default google-translate-default-source-language "auto")
             (setq-default google-translate-default-target-language "zh-CN")
             (setq-default google-translate-pop-up-buffer-set-focus t)

             (global-set-key (kbd "C-c q") 'google-translate-at-point)
             (global-set-key (kbd "C-c Q") 'google-translate-smooth-translate)
             )

;; (use-package form-feed
;;              :ensure t
;; 
;;              :config
;;              (add-hook 'emacs-lisp-mode-hook 'form-feed-mode)
;;              (add-hook 'dashboard-mode-hook 'form-feed-mode)
;;              )

(use-package page-break-lines
             :ensure t

             :config
             (set-fontset-font "fontset-default"
                               (cons page-break-lines-char page-break-lines-char)
                               (face-attribute 'default :family))
             )

(use-package projectile
             :ensure t
             :config
             (projectile-mode +1)
             (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
             )

(provide 'init-misc-pkg)
;;; init-misc-pkg.el ends here
