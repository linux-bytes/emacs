;;; package -- Summury
;;; Just for some customise of other misc packages

;; graphviz-dot
(setq-default graphviz-dot-auto-indent-on-braces t)
(setq-default graphviz-dot-auto-indent-on-semi t)
(setq-default graphviz-dot-auto-preview-on-save t)

;; image
(eimp-mode 1)
(add-hook 'image-mode-hook 'eimp-mode)
(eval-after-load 'image-dired '(require 'image-dired+))
(eval-after-load 'image-dired+ '(image-diredx-async-mode 1))
(eval-after-load 'image-dired+ '(image-diredx-adjust-mode 1))

;; plantuml
(setq plantuml-default-exec-mode (quote jar))
(setq plantuml-executable-path "/opt/plantuml")
(setq plantuml-jar-path "/opt/plantuml/plantuml.jar")

(add-to-list 'auto-mode-alist '("\\.\\(pu\\)\\'" . plantuml-mode))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

(provide 'init-misc-pkg)
