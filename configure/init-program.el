;;; package --- Summary
;;; Commentary:

;;; Code:

(setq c-default-style (quote ((c-mode . "linux")
                              (java-mode . "java")
                              (awk-mode . "awk")
                              (other . "gnu"))))

;; (setq c-mode-hook (quote (cscope-minor-mode)))
;; (add-hook 'c-mode-common-hook '(lambda() (require 'xcscope)))
;; (add-hook 'c-mode-common-hook '(lambda() (cscope-minor-mode)))

(setq cscope-close-window-after-select t)
(setq cscope-display-times nil)
(setq cscope-edit-single-match nil)
(setq cscope-option-do-not-update-database t)

(provide 'init-program)
;;; init-program.el ends here
