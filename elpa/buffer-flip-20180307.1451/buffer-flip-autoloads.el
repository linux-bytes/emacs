;;; buffer-flip-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "buffer-flip" "buffer-flip.el" (23288 2899
;;;;;;  43243 224000))
;;; Generated autoloads from buffer-flip.el

(autoload 'buffer-flip "buffer-flip" "\
Begin cycling through buffers.
With prefix ARG, invoke `buffer-flip-other-window'.
ORIGINAL-CONFIGURATION is used internally by
`buffer-flip-other-window' to specify the window configuration to
be restored upon abort.

\(fn &optional ARG ORIGINAL-CONFIGURATION)" t nil)

(autoload 'buffer-flip-other-window "buffer-flip" "\
Switch to another window and begin cycling through buffers in that window.
If there is no other window, one is created first.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("buffer-flip-pkg.el") (23288 2890 642354
;;;;;;  496000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; buffer-flip-autoloads.el ends here
