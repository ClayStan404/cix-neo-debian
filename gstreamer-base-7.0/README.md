# CIX GStreamer Base for Linux 7.0

This directory is an overlay for Debian's `gst-plugins-base1.0` Salsa source,
not a copy of Debian packaging. The build flow prepends `changelog`, imports
the patches below `patches/`, and appends `patches/series` to Debian's series
inside an isolated work directory.

The `debian/` patch directory preserves stable or security updates that are
published for Debian 13 but are not represented by the pinned Salsa tag. The
`cix/` directory contains the minimal AFBC and GL integration selected from
the CIX GStreamer 1.26.2 branch. The unrelated CIX color-balance change is
intentionally excluded.

AFBC formats are advertised only in passthrough caps because GStreamer's
generic software pack, conversion, and scaling paths cannot interpret their
compressed layout. The accompanying test changes preserve Debian's test suite
while enforcing that boundary.

The Lintian overrides document three existing Salsa packaging findings that
are unrelated to the CIX source changes: one duplicate copyright pattern and
two GStreamer registration-only modules with no libc references.
