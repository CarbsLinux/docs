Carbs Linux User Manual
--------------------------------------------------------------------------------

This is the Carbs Linux documentation written with Emacs Org-mode. It can be
viewed offline by installing the `carbs-docs` package. Distribution tarballs
come with a prebuilt info page and plaintext pages, so neither `emacs` nor
`texinfo` is necessary.

You can view offline documentation by doing one of the following:

    less /usr/share/doc/carbslinux.txt

Or:

    info carbslinux

There are two packages in the repository for viewing info files, `texinfo` and
`info`. The `info` package only comes with the statically linked documentation
reader, so you don't need `perl` to install it.

    cpt-build info carbs-docs


To generate info pages from the git repository, you will need to install
`texinfo`. For your convenience, the plaintext and texinfo files are committed
directly on the repository, but those files are generated directly from Emacs.

    git clone git://git.carbslinux.org/docs
    cpt-build texinfo && cpt-install texinfo
    redo
    PREFIX=/usr redo install
    install-info /usr/share/info/carbslinux.info /usr/share/info/dir
