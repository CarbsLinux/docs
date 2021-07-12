include config.mk
ORG      = carbslinux.org fdl.org
TEXI     = carbslinux.texi

TARGET   = carbslinux.info install.txt carbslinux.txt

all: ${TARGET}

carbslinux.info: carbslinux.texi
	${MAKEINFO} -o $@ carbslinux.texi

install.txt: ${ORG}
	${EMACS} carbslinux.org -f docs-install-txt

carbslinux.txt: ${ORG}
	${EMACS} carbslinux.org -f org-ascii-export-to-ascii

carbslinux.texi: ${ORG}
	${EMACS} carbslinux.org -f org-texinfo-export-to-texinfo

clean:
	rm -f carbslinux.info

allclean: clean
	rm -f carbslinux.txt install.txt carbslinux.texi

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
	install -Dm644 carbslinux.info "${DESTDIR}${INFODIR}/carbslinux.info"
	install -Dm644 carbslinux.txt  "${DESTDIR}${DOCDIR}/carbslinux/carbslinux.txt"

uninstall:
	rm -f "${DESTDIR}${INFODIR}/carbslinux.info"
	rm -f "${DESTDIR}${DOCDIR}/carbslinux/carbslinux.txt"

dist: ${TARGET}
	mkdir -p carbs-docs-${VERSION}
	cp README.md Makefile config.mk ${ORG} ${TEXI} ${TARGET} carbs-docs-${VERSION}
	tar cf carbs-docs-${VERSION}.tar carbs-docs-${VERSION}
	xz -z carbs-docs-${VERSION}.tar
	rm -r carbs-docs-${VERSION}

.PHONY: all dist htmldocs install clean uninstall
