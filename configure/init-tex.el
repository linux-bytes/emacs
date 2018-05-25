(setq TeX-command-extra-options "-shell-escape")
(setq TeX-engine (quote xetex))

(setq TeX-auto-save       t)
(setq TeX-clean-confirm   nil)

(setq TeX-electric-escape t)
(setq TeX-fold-auto       t)
(setq TeX-fold-mode       t)
(setq TeX-fold-type-list  (quote (env math)))
(setq TeX-parse-self      t)
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
(setq LaTeX-mode-hook     (quote (preview-mode-setup turn-on-reftex)))

(setq reftex-plug-into-AUCTeX t)

(provide 'init-tex)
