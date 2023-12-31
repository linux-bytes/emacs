;;; package -- Summury
;;; Commentary:

;;; Code:
(require 'package)

;; (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                          ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;; (add-to-list 'package-archives '("melpa-cn" . "http://elpa.emacs-china.org/melpa/") t)
;; (add-to-list 'package-archives '("gnu-cn" . "http://elpa.emacs-china.org/gnu/") t)
(add-to-list 'package-archives '("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
(add-to-list 'package-archives '("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(require 'use-package)

(use-package exec-path-from-shell
             :ensure t
             :config
             (exec-path-from-shell-initialize)
             ;; Find Executable Path on OS X
             ;; (when (memq window-system '(mac ns))
             ;;   (exec-path-from-shell-initialize))
             )

(use-package htmlize
             :ensure t
             )

(use-package nlinum
             :ensure t
             :config
             ;; 显示行号
             (global-nlinum-mode 1)
             )

(use-package popwin
             :ensure t
             :config
             ;; 开启 popwin
             (popwin-mode t)
             )

(use-package smartparens
             :ensure t
             :config
             ;; 括号, 双引号等, 自动补上
             (smartparens-global-mode t)
             ;; 在 lisp mode 下, 不要自动插入另一个单引号
             (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
             (add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
             )

(use-package hungry-delete
             :ensure t
             :config
             ;; (require 'hungry-delete-mode)
             (global-hungry-delete-mode t)
             )

(use-package company
             :ensure jedi
             :ensure jedi-core
             :ensure company-jedi
             :ensure company-auctex
  
             :init nil
             :config
             ;; 开启全局 Company 补全
             (global-company-mode 1)
             (setq company-idle-delay 0.08)
             (setq company-minimum-prefix-length 1)
             )

(use-package pdf-tools
             :ensure t
             :config
             ;; Install pdf-tools
             (pdf-tools-install)
             )

(use-package dts-mode
             :ensure t
             )

(use-package sphinx-frontend
             :ensure t
             )

(use-package yasnippet
             :ensure yasnippet
             :ensure yasnippet-snippets
             )

(use-package markdown-mode
             :ensure markdown-toc
             )

;; (use-package magit
;;              :ensure magit
;;              :ensure magithub
;;              :ensure magit-imerge
;;              :ensure magit-todos
;;              :ensure magit-gitflow
;;              :ensure magit-gerrit
;;              :ensure magit-find-file
;; 
;;              :config
;;              ;; magic-find-file
;;              (global-set-key (kbd "C-c p") 'magit-find-file-completing-read)
;; 
;;              ;; magic-flow
;;              (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
;;              )

(provide 'init-packages)
;;; init-packages.el ends here
