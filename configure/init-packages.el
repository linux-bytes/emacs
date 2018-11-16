(require 'cl)          ;; cl - Common Lisp Extension, needs by follow functions
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://elpa.emacs-china.org/melpa/") t)
;; (add-to-list 'package-archives '(
;; 				("gnu" . "https://elpa.gnu.org/packages/")
;; 				("melpa-cn" . "http://elpa.emacs-china.org/melpa/")
;; 				("gnu-cn" . "http://elpa.emacs-china.org/gnu/")
;; 				))

;; Add Packages
(defvar jerry/packages '(
                         ;; --- Auto-completion ---
                         ;; --- Better Editor ---
                         hungry-delete
                         ;; smex
                         swiper
                         counsel
                         buffer-flip
                         htmlize
                         nlinum
                         org
                         org-gnome
                         jedi
                         jedi-core
                         company
			 company-jedi
                         company-auctex
                         smartparens
                         yasnippet
                         yasnippet-snippets
                         youdao-dictionary
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
			 org2ctex
			 pdf-tools
			 ecb
			 ;; thing-at-point
			 xcscope
                         ;; org-pdfview
                         pdf-tools
                         youdao-dictionary
                         ;; --- Major Mode ---
                         auctex
                         ;; --- Minor Mode ---
                         ;; nodejs-repl
                         ;; exec-path-from-shell
                         ;; --- Themes ---
                         monokai-theme
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

;; Config the YASnippet
; (yas/load-directory "/usr/share/emacs/etc/yasnippet/snippets/text-mode/")
;; (yas/load-directory "~/.emacs.d/snippets/")

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

;; 加载 monokai 主题
(load-theme 'monokai t)

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

;; For org2ctex
(require 'org2ctex)
(org2ctex-toggle t)

(provide 'init-packages)
