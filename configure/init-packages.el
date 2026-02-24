;;; package -- Summury
;;; Commentary:

;;; Code:
(require 'package)

;; (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                          ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;; (add-to-list 'package-archives '("melpa-cn" . "http://elpa.emacs-china.org/melpa/") t)
;; (add-to-list 'package-archives '("gnu-cn" . "http://elpa.emacs-china.org/gnu/") t)

;; 使用清华镜像源（一次性覆盖，避免重复添加）
(setq package-archives
      '(("gnu-cn"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("nongnu-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
        ("melpa-cn"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ("gnu"       . "https://elpa.gnu.org/packages/")
        ("nongnu"    . "https://elpa.nongnu.org/nongnu/")
        ("melpa"     . "https://melpa.org/packages/")
       )
)

;; 设置优先级：GNU > NonGNU > MELPA
(setq package-archive-priorities
      '(("gnu-cn"    . 10)
        ("nongnu"    . 10)
        ("nongnu-cn" . 9)
        ("melpa-cn"  . 5)
       )
)

;; 初始化包管理系统
(package-initialize)

;; 确保包列表非空（首次运行或长期未更新时刷新）
(unless package-archive-contents (package-refresh-contents))

;; 确保 use-package 已安装
(unless (package-installed-p 'use-package)
        (package-refresh-contents)   ; 刷新以保证能获取最新 use-package
        (package-install 'use-package)
)

;; use-package 全局设置（放在 require 之前或之后均可）
(setq use-package-always-ensure t
      use-package-expand-minimally t)

(require 'use-package)

;; (use-package esup
;;              :ensure t
;; )

;; (use-package benchmark-init
;;              :ensure t
;;              :config
;;              ;; 启用记录
;;              (benchmark-init/activate)
;;              ;; 可选：在关闭 Emacs 时保存记录到文件（便于后续分析）
;;              (add-hook 'after-init-hook 'benchmark-init/deactivate)
;; )

;; 配置 exec-path-from-shell（仅在 macOS 上启用，若需要 Linux 也可去除条件）
(use-package exec-path-from-shell
             :ensure t

             :if (memq system-type '(darwin))   ; 仅 macOS 启用，Linux 通常无需

             :config
             (exec-path-from-shell-initialize)
)

;; =========================================
;; 基础行为优化
;; =========================================

;; 当文件在外部被修改时，自动在缓冲区中重载
(global-auto-revert-mode 1)           ; 启用全局自动重载模式

;; 缩进使用空格代替 Tab（全局默认值）
(setq-default indent-tabs-mode nil)   ; 所有新缓冲区的缩进均为空格

;; 关闭 Emacs 自动生成的备份文件 (~ 文件)
(setq make-backup-files nil)          ; 禁止创建 #file# 备份
(setq auto-save-default nil)          ; 禁止自动保存（每 300 击键的临时保存）

;; 以下两项在 Emacs 25+ 中默认已启用，无需显式开启
;; (electric-indent-mode 1)   ; 自动缩进（如键入 } 后自动对齐）
;; (delete-selection-mode 1)  ; 选中文本后直接输入可替换选中内容

;; 将冗长的 yes/no 确认简化为 y/n
(fset 'yes-or-no-p 'y-or-n-p)         ; 所有需要“yes/no”的地方变成“y/n”

(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000))) ; 默认值

;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/configure/init-packages.el")
)

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>")     'open-init-file)


(require 'init-ui)
(require 'init-input)
(require 'init-flycheck)
(require 'init-misc-pkg)
(require 'init-org)
(require 'init-tex)
(require 'init-program)

(provide 'init-packages)
;;; init-packages.el ends here
