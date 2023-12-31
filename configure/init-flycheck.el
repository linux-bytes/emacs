;;; package --- Summary
;;; Commentary:

;;; Code:
(use-package flycheck
             :ensure t
             :ensure flycheck-cstyle
             :ensure flycheck-pycheckers
             :ensure flycheck-pyflakes
             :ensure flycheck-plantuml

             :init
             (add-hook 'after-init-hook #'global-flycheck-mode)
             )

(provide 'init-flycheck)
;;; init-flycheck.el ends here
