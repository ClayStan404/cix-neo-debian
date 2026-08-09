# Debian Packaging

This directory will contain the Debian packaging metadata for the modules
managed by the new build system. Packaging metadata is kept separate from the
upstream source checkouts under `sources/`.

The Linux kernel uses its own `scripts/package/mkdebian` implementation through
the `bindeb-pkg` make target. No kernel configuration or duplicate kernel
packaging metadata is stored here.

The current external packaging metadata is:

- `gpu-dkms/`: overlaid as `debian/` onto a temporary copy of the GPU source
  before the source package is passed to `sbuild`.

Package build relationships belong in the source stanza `Build-Depends`,
`Build-Depends-Arch`, and `Build-Depends-Indep` fields. Build scripts must not
declare or invoke dependencies on other module build scripts.
