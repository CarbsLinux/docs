VERSION = 2024.03

# System and build directories
PREFIX   = /usr/local
SHAREDIR = ${PREFIX}/share
INFODIR  = ${SHAREDIR}/info
DOCDIR   = ${SHAREDIR}/doc
HTMLDIR  = ./carbslinux

EMACS    = emacs --batch -l docs.el
MAKEINFO = makeinfo

INSTALLSH = ./tools/install.sh
