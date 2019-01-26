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
(global-set-key (kbd "C-c b")    'org-switchb)

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

;; For ace-window
(global-set-key (kbd "M-q") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(defvar aw-dispatch-alist
  '((?x aw-delete-window "Delete Window")
	(?m aw-swap-window "Swap Windows")
	(?M aw-move-window "Move Window")
	(?r aw-switch-buffer-in-window "Select Buffer")
	(?n aw-flip-window)
	(?u aw-switch-buffer-other-window "Switch Buffer Other Window")
	(?c aw-split-window-fair "Split Fair Window")
	(?v aw-split-window-vert "Split Vert Window")
	(?b aw-split-window-horz "Split Horz Window")
	(?o delete-other-windows "Delete Other Windows")
	(?? aw-show-dispatch-help))
  "List of actions for `aw-dispatch-default'.")

(global-set-key (kbd "M-s") 'ace-jump-buffer)

(provide 'init-keybindings)
