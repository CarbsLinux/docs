# This Makefile is meant to generate a dist tarball in order to avoid installing
# texinfo on the target system.
PREFIX   = /usr/local
SHAREDIR = ${PREFIX}/share
INFODIR  = ${SHAREDIR}/info
DOCDIR   = ${SHAREDIR}/doc
TARBALL  = carbs-docs-`date +%Y%m%d`
HTMLDIR  = ./carbslinux
TEXI     = contribution.texi cpt.texi init.texi install.texi top.texi
OBJ      = carbslinux.info carbslinux.txt

all: ${OBJ}

clean:
	rm -f ${OBJ} ${TARBALL}.tar.gz

carbslinux.txt: ${TEXI}
	makeinfo --plaintext top.texi -o carbslinux.txt

carbslinux.info: ${TEXI}
	makeinfo top.texi -o carbslinux.info

dist: ${OBJ}
	mkdir -p ${TARBALL}
	cp ${OBJ} ${TEXI} Makefile README ${TARBALL}
	tar -cf ${TARBALL}.tar ${TARBALL}
	gzip -9 ${TARBALL}.tar
	rm  -rf ${TARBALL}.tar ${TARBALL}

htmldocs: ${OBJ}
	rm -f -- ${HTMLDIR}/*
	makeinfo --html -o ${HTMLDIR} top.texi
	makeinfo --plaintext -o ${HTMLDIR}/install.txt install.texi

install: carbslinux.info carbslinux.txt
	install -Dm644 carbslinux.info ${DESTDIR}${INFODIR}/carbslinux.info
	install -Dm644 carbslinux.txt ${DESTDIR}${DOCDIR}/carbslinux.txt

.PHONY: all dist htmldocs install clean
