;;; package --- Summary
;;; Commentary:

;;; Code:
(setq c-default-style (quote ((c-mode . "linux")
                              (java-mode . "java")
                              (awk-mode . "awk")
                              (other . "gnu")))
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
	     ((plantuml-mode . company-mode)
	      (plantuml-mode . flycheck-mode)
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
	     (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

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

(use-package ag
             :ensure t
)

;; GN
(use-package gn-mode
	     :ensure t
	     :mode ("\\.gni?\\'" . gn-mode)
	     :config
	     (with-eval-after-load 'org
                                   (add-to-list 'org-src-lang-modes '("gn" . gn)))
)

;; Ninja
(use-package ninja-mode
	     :ensure t
	     :mode ("\\.ninja\\'" . ninja-mode)
	     :config
	     (with-eval-after-load 'org
                                   (add-to-list 'org-src-lang-modes '("ninja" . ninja)))
)

;; (use-package ecb
;;              :ensure t
;;              )

(use-package xcscope
             :ensure t

             :config
             (setq cscope-close-window-after-select t)
             (setq cscope-display-times nil)
             (setq cscope-edit-single-match nil)
             (setq cscope-option-do-not-update-database t)

             (setq c-mode-hook (quote (cscope-minor-mode)))
             ;; (add-hook 'c-mode-common-hook '(lambda() (require 'xcscope)))
             ;; (add-hook 'c-mode-common-hook '(lambda() (cscope-minor-mode)))
)

(provide 'init-program)
;;; init-program.el ends here
