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

(use-package ivy
             :ensure t
             :ensure swiper

             :config
             ;; 开启 swiper 功能
             (ivy-mode t)
             (setq ivy-use-virtual-buffers t)
             (global-set-key (kbd "C-s")      'swiper)
             (global-set-key (kbd "C-c C-r")  'ivy-resume)
             )

(use-package counsel
             :ensure t

             :config
             (global-set-key (kbd "M-x")      'counsel-M-x)
             (global-set-key (kbd "C-x C-f")  'counsel-find-file)
             (global-set-key (kbd "C-h f")    'counsel-describe-function)
             (global-set-key (kbd "C-h v")    'counsel-describe-variable)
             (global-set-key (kbd "C-c g")    'counsel-git)
             (global-set-key (kbd "C-c j")    'counsel-git-grep)
             (global-set-key (kbd "C-c s")    'counsel-ag)
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
