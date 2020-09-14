# This Makefile is meant to generate a dist tarball in order to avoid installing
# texinfo on the target system.
TARBALL=carbs-docs-`date +%Y-%m-%d`
DESTDIR=./docs

all:

dist:
	mkdir -p ${TARBALL}
	makeinfo -o ${TARBALL}/carbslinux.info top.texi
	makeinfo --plaintext top.texi > ${TARBALL}/carbslinux.txt
	cp extMakefile ${TARBALL}/Makefile
	tar -cf ${TARBALL}.tar ${TARBALL}
	gzip -9 ${TARBALL}.tar
	rm -rf ${TARBALL}.tar ${TARBALL}

htmldocs:
	rm -rf -- ${DESTDIR}
	makeinfo --html -o ${DESTDIR} top.texi
	makeinfo --plaintext -o ${DESTDIR}/install.txt install.texi

.PHONY: all dist htmldocs
