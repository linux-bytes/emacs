;;; package --- Summary
;;; Commentary:

;;; Code:
(use-package flycheck
             :ensure t
             :defer t
             :ensure flycheck-cstyle
             :ensure flycheck-pycheckers
             :ensure flycheck-pyflakes
             :ensure flycheck-plantuml

             :hook (prog-mode . flycheck-mode)   ; 只在编程模式启用

             ;; :init
             ;; (add-hook 'after-init-hook #'global-flycheck-mode)
)

(provide 'init-flycheck)
;;; init-flycheck.el ends here
