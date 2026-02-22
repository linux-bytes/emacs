;;; package --- Summary
;;; Commentary:

;;; Code:

;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>")     'open-init-file)

(global-set-key (kbd "C-h C-f")  'find-function)
(global-set-key (kbd "C-h C-v")  'find-variable)
(global-set-key (kbd "C-h C-k")  'find-function-on-key)

(global-set-key (kbd "C-]")      'rtags-find-symbol-at-point)
(global-set-key (kbd "C-o")      'switch-to-prev-buffer)

;; Other Packages:
;; hydra
;; ivy-hydra

(use-package recentf
             :ensure t
             :config
             (recentf-mode 1)
             (setq recentf-max-menu-item 10)
             (add-to-list 'recentf-exclude (expand-file-name "~/.emacs.d/elpa/"))
             (global-set-key (kbd "C-x C-o")  'recentf-open-files)
             )

;; (use-package ivy
;;              :ensure t
;;              :ensure swiper
;;
;;              :config
;;              ;; 开启 swiper 功能
;;              (ivy-mode t)
;;              (setq ivy-use-virtual-buffers t)
;;              (global-set-key (kbd "C-s")      'swiper)
;;              (global-set-key (kbd "C-c C-r")  'ivy-resume)
;;              )
;;
;; (use-package counsel
;;              :ensure t
;;
;;              :config
;;              (global-set-key (kbd "M-x")      'counsel-M-x)
;;              (global-set-key (kbd "C-x C-f")  'counsel-find-file)
;;              (global-set-key (kbd "C-h f")    'counsel-describe-function)
;;              (global-set-key (kbd "C-h v")    'counsel-describe-variable)
;;              (global-set-key (kbd "C-c g")    'counsel-git)
;;              (global-set-key (kbd "C-c j")    'counsel-git-grep)
;;              (global-set-key (kbd "C-c s")    'counsel-ag)
;;              )

(use-package vertico
	     :ensure t
	     :config
	     (vertico-mode 1)
	     )

(use-package orderless
	     :ensure t
	     :config
	     ;; 设置默认的补全风格为 orderless
	     (setq completion-styles '(orderless basic))
	     (setq completion-category-defaults nil)
	     (setq completion-category-overrides nil)
	     )

;; 安装 consult 并绑定一些常用命令
(use-package consult
	     :ensure t
	     :bind (("C-x b" . consult-buffer)    ;; 增强版切换缓冲区
                    ("M-y"   . consult-yank-pop)  ;; 增强版查看剪切板历史
                    ("C-s"   . consult-line)      ;; 在当前 buffer 搜索行
                    ("M-g g" . consult-goto-line) ;; 跳转到行
                    ("M-g f" . consult-flymake))  ;; 查看 Flymake 错误列表
	     )

;; 基础库：提供排序和过滤核心功能
(use-package prescient
	     :ensure t
	     :config
	     ;; 频率衰减因子（默认 0.997），数值越小遗忘越快
	     (setq prescient-frequency-decay 0.997)
	     ;; 历史记录长度（默认 1000）
	     (setq prescient-history-length 1000)
	     ;; 启用大小写折叠，忽略大小写差异
	     (setq prescient-use-case-folding t)
	     ;; 将完全匹配的候选项排在最前面
	     (setq prescient-sort-full-matches-first t)
	     ;; 禁用按长度排序（避免最短命令总是排最前，可选）
	     (setq prescient-sort-length-enable nil)
	     )

;; Vertico 的 prescient 适配层
(use-package vertico-prescient
	     :ensure t
	     :after (prescient vertico)
	     :config
	     ;; 启用 vertico-prescient-mode
	     (vertico-prescient-mode 1)

	     ;; 如果你想完全使用 prescient 的过滤替代 orderless，可以启用：
	     ;; (setq vertico-prescient-enable-filtering t)
	     ;; 但通常保留 orderless 的过滤，只用 prescient 的排序

	     ;; 让 prescient 记住历史频率，跨会话持久化
	     (prescient-persist-mode 1)
	    )

;; For Youdao
(use-package youdao-dictionary
             :ensure t

             :config
             (setq url-automatic-caching t)
             (global-set-key (kbd "C-q")      'youdao-dictionary-search-at-point+)
             )

(use-package ace-window
             :ensure t
             :ensure ace-jump-buffer

             :config
             ;; For ace-window
             (global-set-key (kbd "M-q") 'ace-window)
             (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
             (defvar aw-dispatch-alist
               '((?x aw-delete-window "Delete Window")
                 (?m aw-swap-window "Swap Windows")
                 (?M aw-move-window "Move Window")
                 (?r aw-switch-buffer-in-window "Select Buffer")
                 (?n aw-flip-window)
                 (?u aw-switch-buffer-other-window "Switch Buffer Other Window")
                 (?c aw-split-window-fair "Split Fair Window")
                 (?v aw-split-window-vert "Split Vert Window")
                 (?b aw-split-window-horz "Split Horz Window")
                 (?o delete-other-windows "Delete Other Windows")
                 (?? aw-show-dispatch-help))
               "List of actions for `aw-dispatch-default'.")

             (global-set-key (kbd "M-s") 'ace-jump-buffer)
             )

(use-package neotree
             :ensure t

             :config
             (global-set-key (kbd "<f8>") 'neotree-toggle)
             )

(provide 'init-keybindings)
;;; init-keybindings.el ends here
