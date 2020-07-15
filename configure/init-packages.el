;;; package -- Summury
;;; Commentary:

;;; Code:
(require 'cl)          ;; cl - Common Lisp Extension, needs by follow functions
(require 'package)

;; (add-to-list 'package-archives '("melpa-cn" . "http://elpa.emacs-china.org/melpa/") t)
;; (add-to-list 'package-archives '("gnu-cn" . "http://elpa.emacs-china.org/gnu/") t)

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)

;; Add Packages
(defvar jerry/packages '(
                         dts-mode
                         ;; --- Better Editor ---
                         hungry-delete
                         ;; Draw
                         graphviz-dot-mode
                         ;; Ivy
                         ivy
                         swiper
                         counsel
                         ;;
                         hydra
                         ivy-hydra
                         ;;
                         htmlize
                         nlinum
                         ;; file management
                         diredfl
                         neotree
                         ;; 开机画面
                         dashboard
                         ;; Project
                         projectile
                         ;; rST Document
                         sphinx-frontend
                         ;; For org mode
                         org
                         org2ctex
                         org-alert
                         org-brain
                         org-bullets
                         org-edit-latex
                         org-easy-img-insert
                         org-mime
                         org-msg
                         org-pomodoro
                         org-projectile
                         org-super-agenda
                         org-sidebar
                         ox-rst
                         ;; org-pdfview
                         ;; --- For Language ---
                         plantuml-mode
                         ;; iamge
                         eimp
                         ;; --- Auto-completion ---
                         jedi
                         jedi-core
                         company
                         company-jedi
                         company-auctex
                         smartparens
                         yasnippet
                         yasnippet-snippets
                         ;; flycheck
                         flycheck
                         flycheck-cstyle
                         flycheck-pycheckers
                         flycheck-pyflakes
                         flycheck-plantuml
                         ;;magic-latex-buffer
                         ;;magic
                         ;;magithub
                         ;;magit-imerge
                         ;;magit-todos
                         ;;magit-gitflow
                         ;;magit-gerrit
                         ;;magit-find-file
                         markdown-mode
                         markdown-toc
                         popwin
                         ecb
                         ;; For window jump
                         ace-window
                         ace-jump-buffer
                         centaur-tabs
                         ;; thing-at-point
                         xcscope
                         pdf-tools
                         youdao-dictionary
                         ;; --- Major Mode ---
                         auctex
                         latex-extra
                         magic-latex-buffer
                         ;; --- Minor Mode ---
                         ;; nodejs-repl
                         ;; exec-path-from-shell
                         ;; MISC
                         ag
                         ;; use-package
                         ;; treemacs
                         ;; treemacs-icons-dired
                         ;; treemacs-projectile
                         ;; --- Themes ---
                         zenburn-theme
                         monokai-theme
                         kaolin-themes
                         form-feed
                         all-the-icons
                         all-the-icons-dired
                         all-the-icons-gnus
                         ;; solarized-theme
                         ) "Default packages")

(setq package-selected-packages jerry/packages)

(defun jerry/packages-installed-p ()
  (loop for pkg in jerry/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (jerry/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg jerry/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

 ;; Find Executable Path on OS X
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; 开启 swiper 功能
(ivy-mode t)
(setq ivy-use-virtual-buffers t)

;; 开启 popwin
(require 'popwin)
(popwin-mode t)

;; 括号, 双引号等, 自动补上
(smartparens-global-mode t)
;; 在 lisp mode 下, 不要自动插入另一个单引号
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

;; 显示行号
;; (global-nlinum-mode 1)

;; (require 'hungry-delete-mode)
(global-hungry-delete-mode t)

;; 开启全局 Company 补全
(global-company-mode 1)

;; Install pdf-tools
(pdf-tools-install)

;; magic-latex-buffer
;; (require 'magic-latex-buffer)
;; (add-hook 'latex-mode-hook 'magic-latex-buffer)

;; magic-find-file
;;(require 'magic)
;;(require 'magit-find-file)    ;; if not using the ELPA package
;;(global-set-key (kbd "C-c p") 'magit-find-file-completing-read)

;; magic-flow
;;(require 'magit-gitflow)
;;(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)

(provide 'init-packages)
;;; init-packages.el ends here
