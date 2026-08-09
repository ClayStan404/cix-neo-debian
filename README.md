# Debian Packaging

This directory will contain the Debian packaging metadata for the modules
managed by the new build system. Packaging metadata is kept separate from the
upstream source checkouts under `sources/`.

The Linux kernel uses its own `scripts/package/mkdebian` implementation through
the `bindeb-pkg` make target. No kernel configuration or duplicate kernel
packaging metadata is stored here.

Temporary downstream kernel fixes live in `kernel/patches/` and are applied in
`series` order to a disposable Git worktree. Each patch must be removed when
the equivalent fix reaches the manifest-managed kernel branch.

The current external packaging metadata is:

- `kernel/patches/`: temporary downstream fixes required by the native build;
- `gpu-dkms/`: overlaid as `debian/` onto a temporary copy of the GPU source
  before the source package is passed to `sbuild`.

The GPU package owns its installed `dkms.conf`. It always builds against the
kernel source directory selected by DKMS and restricts builds to ARM64 kernels
with `CONFIG_ARCH_CIX`. Generic upstream kernels are intentionally unsupported.

Package build relationships belong in the source stanza `Build-Depends`,
`Build-Depends-Arch`, and `Build-Depends-Indep` fields. Build scripts must not
declare or invoke dependencies on other module build scripts.
