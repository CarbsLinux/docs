exec >&2
. ./config.rc

fn=${1%.*}

date=$(date +%Y%m%d)
export date

case "$1" in
    *.txt|*.texi)
        [ -f "$fn.org" ] || {
            printf '%s\n' "Don't know how to build $1"
            exit 1
        }
        redo-ifchange "$fn.org" fdl.org
        trap 'rm -f $3.org' EXIT INT
        cp "$fn.org" "$3.org"
esac

case "$1" in
    all) redo-ifchange carbslinux.info install.txt carbslinux.txt ;;
    allclean)
        rm -f carbslinux.texi install.txt carbslinux.txt
        redo clean
        PHONY
        ;;
    htmldocs)
        redo-ifchange carbslinux.org carbslinux.texi install.txt install.html
        rm -f "${HTMLDIR:?}/"*
        makeinfo --html -o "${HTMLDIR}" "${TEXI}"
        cp install.txt "${HTMLDIR}/install.txt"
        cp install.html "${HTMLDIR}/install.html"
        PHONY
        ;;
    *.txt)
        ${EMACS} "$3.org" -f org-ascii-export-to-ascii
        mv "$3.txt" "$3"
        ;;
    *.texi)
        ${EMACS} "$3.org" -f org-texinfo-export-to-texinfo
        mv "$3.texi" "$3"
        ;;
    *.info)
        redo-ifchange "$fn.texi"
        ${MAKEINFO} "$fn.texi" -o "$3"
        ;;
    "carbs-docs-$date.tar.xz")
        target=$1 dest=$3
        set -- README.md ./*.do ./*.org config.rc lib.rc carbslinux.info \
               install.txt carbslinux.txt
        redo-ifchange "$@"
        trap 'rm -rf carbs-docs-$date carbs-docs-$date.tar' EXIT INT
        mkdir -p "carbs-docs-$date"
        cp README.md ./*.do ./*.org config.rc lib.rc \
            carbslinux.info install.txt carbslinux.txt "carbs-docs-$date"
        tar cf "carbs-docs-$date.tar" "carbs-docs-$date"
        xz -cz "carbs-docs-$date.tar" > "$dest"
        ;;
    install)
        redo-ifchange carbslinux.info carbslinux.txt
        "$INSTALLSH" -Dm644 carbslinux.info "${DESTDIR}${INFODIR}/carbslinux.info"
        "$INSTALLSH" -Dm644 carbslinux.txt  "${DESTDIR}${DOCDIR}/carbslinux.txt"
        ;;
    dist)
        redo-ifchange "carbs-docs-$date.tar.xz"
        ;;
    *) printf '%s\n' "Unknown operation $1"; exit 1
esac
