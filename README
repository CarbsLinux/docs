Carbs Linux User Manual
--------------------------------------------------------------------------------

This is the Carbs Linux documentation written with Texinfo. It can be viewed
offline by installing the `carbs-docs` package. Distribution tarballs comes with
prebuilt info and plaintext pages, so they don't depend on the `texinfo`
package.

There are two packages in the repository for viewing info files, `texinfo` and
`info`. The `info` package only comes with the statically linked documentation
reader, so you don't need `perl` to install it.

    cpt-build info carbs-docs

To generate pages from the git repository you will need to install `texinfo`.

    git clone git://git.carbslinux.org/docs
    cpt-build texinfo && cpt-install texinfo
    make
    make PREFIX=/usr install
    install-info /usr/share/info/carbslinux.info /usr/share/info/dir
