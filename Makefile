include config.mk
ORG      = carbslinux.org fdl.org
TEXI     = carbslinux.texi

TARGET   = carbslinux.info install.txt carbslinux.txt install.org

all: ${TARGET}

carbslinux.info: carbslinux.texi
	${MAKEINFO} -o $@ carbslinux.texi

install.txt: ${ORG}
	${EMACS} carbslinux.org -f docs-install-txt

install.org: ${ORG}
	${EMACS} carbslinux.org -f docs-install-org

carbslinux.txt: ${ORG}
	${EMACS} carbslinux.org -f org-ascii-export-to-ascii

carbslinux.texi: ${ORG}
	${EMACS} carbslinux.org -f org-texinfo-export-to-texinfo

clean:
	rm -f carbslinux.info carbslinux-docs-${VERSION}.tar.xz

allclean: clean
	rm -f install.org carbslinux.txt install.txt carbslinux.texi

htmldocs:
	mkdir -p "${HTMLDIR}"
	rm -rf ${HTMLDIR}/carbslinux \
		${HTMLDIR}/carbslinux.html \
		${HTMLDIR}/install.html.in \
		${HTMLDIR}/install.txt
	${MAKEINFO} --html -o ${HTMLDIR}/carbslinux ${TEXI}
	${MAKEINFO} --html --no-split -o ${HTMLDIR}/carbslinux.html ${TEXI}
	cp install.txt ${HTMLDIR}/install.txt

install:
	${INSTALLSH} -Dm644 carbslinux.info "${DESTDIR}${INFODIR}/carbslinux.info"
	${INSTALLSH} -Dm644 carbslinux.txt  "${DESTDIR}${DOCDIR}/carbslinux/carbslinux.txt"

uninstall:
	rm -f "${DESTDIR}${INFODIR}/carbslinux.info"
	rm -f "${DESTDIR}${DOCDIR}/carbslinux/carbslinux.txt"

dist: ${TARGET}
	pax -ws ,^,carbs-docs-${VERSION}/, \
		LICENSE README.md Makefile config.mk ${ORG} ${TEXI} ${TARGET} \
		tools | \
	xz -cz > carbs-docs-${VERSION}.tar.xz

.PHONY: all dist htmldocs install allclean clean uninstall
