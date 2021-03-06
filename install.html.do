exec >&2
. ./config.rc
redo-ifchange "$ORG" htmlize/htmlize.el flatui/flatui-theme.el

cp "$ORG" "$3.org"
trap 'rm -f $3.html $3.org' EXIT INT

# Org HTML export is a bit of a mess from the command line. I have added flatui
# and htmlize repositories as a submodule so that we don't rely on packages.
${EMACS} "$3.org" --eval \
'(progn
(load-file "flatui/flatui-theme.el")
(add-to-list '"'"'custom-theme-load-path (concat default-directory "flatui/"))
(load-theme '"'"'flatui t)
(load-file "htmlize/htmlize.el") (org-mode)
(replace-regexp "^* Installation" "* Carbs Linux Installation Guide")
(setq org-export-with-toc nil)
(org-html-export-to-html nil t nil t)
(revert-buffer nil t)
)'

printf '%s\n' "<h1>Carbs Linux Installation Guide</h1>" > "$3"
cat "$3.html" >> "$3"
