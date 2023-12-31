;;; package --- Summary
;;; Commentary:

;;; Code:
(use-package tex
             :ensure auctex
             :ensure reftex
             :ensure latex-extra
             :ensure magic-latex-buffer

             :config
             (add-hook 'LaTeX-mode-hook #'latex-extra-mode)

             (setq reftex-plug-into-AUCTeX t)
             (add-hook 'LaTeX-mode-hook (lambda() (turn-on-reftex)))

             (company-auctex-init)

             (add-hook 'LaTeX-mode-hook (lambda()
                                          (yas-minor-mode)
                                          (yas-reload-all t)
                                          ;; (latex-preview-pane-mode)
                                          ;; (magic-latex-buffer)
                                          ))

             (setq TeX-command-extra-options "-shell-escape -synctex=1")
             (setq TeX-engine (quote xetex))

             (setq TeX-clean-confirm   nil)

             (setq TeX-auto-save       t)
             (setq TeX-parse-self      t)
             (setq-default TeX-master  nil)

             (setq TeX-electric-escape t)
             (setq TeX-fold-auto       t)
             (setq TeX-fold-mode       t)
             (setq TeX-fold-type-list  (quote (env math)))
             ;; (setq TeX-shell            "/bin/bash")

             (setq-default TeX-auto-regexp-list 'LaTeX-auto-label-regexp-list)

             (setq LaTeX-fold-env-spec-list
                   (quote
                     (("[figure]"
                       ("figure"))
                      ("[table]"
                       ("table"))
                      ("[Code-minted]"
                       ("minted"))
                      ("[Item List]"
                       ("itemize")))))

             ;; (setq latex-preview-pane-multifile-mode (quote auctex))
             ;; (setq preview-orientation (quote right))
             ;; (setq pdf-latex-command "xelatex")
             ;; (setq shell-escape-mode "-shell-escape")
             )

(provide 'init-tex)
;;; init-tex.el ends here
