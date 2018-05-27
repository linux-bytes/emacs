(setq org-edit-src-content-indentation 0)
(setq org-fontify-whole-heading-line   t)
(setq org-support-shift-select         t)
(setq org-refile-targets               nil)
(setq org-tags-column                  80)


(setq my-gtd-dir "~/custom/GTD")
(setq my-gtd-misc-file
      (expand-file-name "misc.org" my-gtd-dir))
(setq my-gtd-proj-file
      (expand-file-name "proj.org" my-gtd-dir))
(setq my-gtd-study-file
      (expand-file-name "study.org" my-gtd-dir))

(setq org-default-notes-file (expand-file-name "misc.org" my-gtd-dir))

(setq my-gtd-files
      (append (directory-files my-gtd-dir t ".org$")
              (list (expand-file-name "misc.org" my-gtd-dir)
                    (expand-file-name "proj.org" my-gtd-dir)
                    (expand-file-name "study.org" my-gtd-dir))))

;; (list my-gtd-misc-file my-gtd-proj-file my-gtd-study-file)))

(delete-dups my-gtd-files)

(setq org-agenda-files   my-gtd-files)
(setq org-refile-targets
      (quote ((org-agenda-files :maxlevel . 2))))

(defun my-gtd-misc-template ()
  (list my-gtd-misc-file "Tasks"))

(my-gtd-misc-template)

(setq org-capture-templates
      '(("t" "Create a new misc task." entry (file+headline "" "Misc Tasks")
         "** %?\n %U" :empty-lines-after 1)
        ("i" "Create a new idea." entry (file+headline "" "Ideas")
         "** %i\n %U" :empty-lines-after 1)
        ("p" "Create a temp project task." entry (file+headline "" "Temp Project")
         "** %?\n %U" :empty-lines-after 1)))

(setq org-html-head
      (format
       "<link rel=\"stylesheet\" type=\"text/css\" href=\"%s\"/>"
       (expand-file-name "configure/org_style/style.css" user-emacs-directory)))

;; (setq org-agenda-files
;;       (quote
;;        ("~/org/work/prj.org" "~/org/work/work.org"
;;         "~/org/study/study.org" "~/org/study/ideas.org"
;;         "~/org/misc/misc.org")))
;; (expand-file-name "configure/custom.el" user-emacs-directory)

(provide 'init-org)
