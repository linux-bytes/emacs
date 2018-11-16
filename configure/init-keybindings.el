;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>")     'open-init-file)

(global-set-key (kbd "C-s")      'swiper)
(global-set-key (kbd "M-x")      'counsel-M-x)
(global-set-key (kbd "C-x C-f")  'counsel-find-file)
(global-set-key (kbd "C-h f")    'counsel-describe-function)
(global-set-key (kbd "C-h v")    'counsel-describe-variable)
(global-set-key (kbd "C-h C-f")  'find-function)
(global-set-key (kbd "C-h C-v")  'find-variable)
(global-set-key (kbd "C-h C-k")  'find-function-on-key)
(global-set-key (kbd "C-c C-r")  'ivy-resume)
(global-set-key (kbd "C-c p f")  'counsel-git)

(global-set-key (kbd "C-x C-r")  'recentf-open-files)

(global-set-key (kbd "C-c l")    'org-store-link)
(global-set-key (kbd "C-c a")    'org-agenda)
(global-set-key (kbd "C-c c")    'org-capture)
(global-set-key (kbd "C-c b")    'org-iswitchb)

;; For Youdao
(setq url-automatic-caching t)
(global-set-key (kbd "C-q")      'youdao-dictionary-search-at-point+)

;; key to begin cycling buffers.  Global key.
(global-set-key (kbd "M-<next>") 'buffer-flip)
;; transient keymap used once cycling starts
(setq buffer-flip-map
      (let ((map (make-sparse-keymap)))
        (define-key map (kbd "M-<next>")   'buffer-flip-forward)
        (define-key map (kbd "M-<prior>")  'buffer-flip-backward)
        (define-key map (kbd "M-ESC")      'buffer-flip-abort)
        map))

(provide 'init-keybindings)
