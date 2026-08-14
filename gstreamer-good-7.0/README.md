# CIX GStreamer Good for Linux 7.0

This directory is an overlay for Debian's `gst-plugins-good1.0` Salsa source,
not a copy of Debian packaging. The build flow prepends `changelog`, imports
the patches below `patches/`, and appends `patches/series` to Debian's series
inside an isolated work directory.

The `control` fragment adds only CIX-owned build dependencies to Salsa's
source stanza. The build and CI dependency planners merge it with Debian's
complete control file; binary package metadata remains owned by Debian.

The `debian/` patch directory preserves stable and security updates that are
published for Debian 13 but are not represented by the pinned Salsa tag. The
`cix/` directory retains the logical V4L2 commits from the CIX GStreamer
1.26.2 branch. GTK-only changes and the temporary remove/revert pair for
source-change support are intentionally excluded.
