;;; package --- Summary
;;; Commentary:

;;; Code:

;; 修改被修改后, 自动加载修改后的文件
(global-auto-revert-mode t)

;; 空格代替Tab
(setq-default indent-tabs-mode nil)

;; 关闭备份文件
(setq make-backup-files nil)
(setq auto-save-default nil)

;; (electric-indent-mode t)   default
;; (delete-selection-mode t)  default

(fset 'yes-or-no-p 'y-or-n-p)

;(setq initial-buffer-choice (lambda ()
;                              (org-agenda-list)
;                              (kill-buffer "*scratch*")
;                              (kill-buffer "*Messages*")
;                              (get-buffer "*Org Agenda*")))

(provide 'init-change-defaults)
;;; init-change-defaults.el ends here
