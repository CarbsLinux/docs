exec >&2
. ./config.rc
redo-ifchange "$ORG"

cp "$ORG" "$3.org"
trap 'rm -f $3.org' EXIT INT

${EMACS} "$3.org" --eval \
    '(progn (replace-regexp "^* Installation" "* Carbs Linux Installation Guide")
            (setq org-export-with-toc nil)
            (org-ascii-export-to-ascii nil t))'

mv "$3.txt" "$3"
