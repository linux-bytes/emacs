(require 'reftex)

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

(add-hook 'LaTeX-mode-hook (lambda()
                               (turn-on-reftex)
                               (yas-minor-mode)
                               (yas-reload-all t)
;;                               (latex-preview-pane-mode)
                               (latex-extra-mode)
;;                               (magic-latex-buffer)
                           ))

(setq latex-preview-pane-multifile-mode (quote auctex))
(setq pdf-latex-command "xelatex")
(setq preview-orientation (quote right))
(setq shell-escape-mode "-shell-escape")

(setq reftex-plug-into-AUCTeX t)

(provide 'init-tex)
