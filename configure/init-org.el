(setq org-edit-src-content-indentation 0)
(setq org-fontify-whole-heading-line   t)
(setq org-support-shift-select         t)
(setq org-refile-targets               nil)
(setq org-tags-column                  80)

(setq org-agenda-files
      (quote
       ("~/org/work/prj.org" "~/org/work/work.org"
        "~/org/study/study.org" "~/org/study/ideas.org"
        "~/org/misc/misc.org")))
(setq org-capture-templates
      (quote
       (("t" "Create a new misc task." entry
         (file+headline "~/org/misc/misc.org" "Tasks")
         "** %?
 %U" :empty-lines-after 1)
        ("i" "Create a new idea." entry
         (file+headline "~/org/study/study.org" "Ideas")
         "** %i
 %U" :empty-lines-after 1)
        ("p" "Create a temp project task." entry
         (file+headline "~/org/work/prj.org" "Temp")
         "** %?
 %U" :empty-lines-after 1))))

(setq org-html-head
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"/home/jerry/org/style/style.css\" />")

(provide 'init-org)
