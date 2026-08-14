# Debian Packaging

This directory contains the Debian packaging metadata for the modules
managed by the new build system. Packaging metadata is kept separate from the
upstream source checkouts under `sources/`.

The Linux kernel uses its own `scripts/package/mkdebian` implementation through
the `bindeb-pkg` make target. No kernel configuration or duplicate kernel
packaging metadata is stored here.

Temporary downstream kernel fixes live in `kernel/patches/` and are applied in
`series` order to a disposable Git worktree. Each patch must be removed when
the equivalent fix reaches the manifest-managed kernel branch.

The current packaging metadata is:

- `kernel/patches/`: temporary downstream fixes required by the native build;
- `gpu-dkms/`: overlaid as `debian/` onto a temporary copy of the GPU source
  before the source package is passed to `sbuild`;
- `bt-dkms/`: external Debian metadata for the Realtek Bluetooth DKMS package;
- `vpu-dkms/`: external Debian metadata for `cix-vpu-driver-dkms`;
- `vpu-firmware/`: external Debian metadata for the proprietary
  `cix-vpu-firmware` payload;
- `npu-dkms/`: external Debian metadata for `cix-npu-driver-dkms`;
- `grub-config/`: native Debian source for `cix-grub-config`;
- `alsa-conf/`: native Debian source for the CIX ALSA UCM profiles and
  board-profile selector;
- `cix-env/`: native Debian source for CIX userspace environment defaults,
  module blacklists, and device permission rules;
- `cix-firmware/`: external Debian metadata for the CIX sensor-hub, WLAN, and
  Bluetooth firmware payloads;
- `audio-dsp/`, `dpu-ddk/`, `gpu-umd/`, `isp-umd/`, `noe-umd/`, and
  `npu-umd/`: external Debian metadata for manifest-managed proprietary
  userspace payloads.
- `audio-sof/`: native Debian metadata used by the direct SOF flow to package
  generated Sky1/Sky1P firmware, log dictionaries, and topology files.
- `libdrm/`: external Debian metadata for the CIX libdrm extension library,
  private diagnostics, and development files.
- `libva/`: external Debian metadata for the private CIX VA-API runtime and
  development packages.
- `ffmpeg/`: external Debian metadata for the private CIX FFmpeg executables,
  runtime libraries, and development files.
- `libcme/`: external Debian metadata for the CIX Media Engine runtime and
  development packages.
- `cix-vaapi/`: external Debian metadata for the CIX VA-API hardware video
  driver.
- `isp-v4l2-dkms/`: external Debian metadata for the CIX ISP V4L2 DKMS
  package.
- `isp-dkms/`: external Debian metadata for the CIX kernel-tree ISP DKMS
  package.
- `ai-engine/`: external Debian metadata for the CIX unified AI inference
  adapters and NOE C++ engine.
- `mnn/`: external Debian metadata for the native MNN runtime, utilities, and
  Debian 13 Python bindings.
- `gstreamer/`: external Debian metadata for the Linux 6.6 private CIX
  GStreamer runtime overlay, CIX plugins, and private video interface.
- `gstreamer-base-7.0/` and `gstreamer-good-7.0/`: downstream changelog and
  quilt patch overlays for the revision-pinned Debian Salsa packages used by
  the Linux 7.0 standard media stack. Debian owns the package split, control,
  rules, copyright, and source format; these directories do not duplicate
  that metadata. A small `control` fragment may add CIX-owned Build-Depends
  without copying Debian's complete control file.
- `nnstreamer/`: external Debian metadata for the CIX NNStreamer runtime,
  Python integration, and private development files.
- `wlan-dkms/`: external Debian metadata for the combined QCA FC6XE and
  Realtek RTL8852B WLAN DKMS source package.

The GPU package owns its installed `dkms.conf`. It always builds against the
kernel source directory selected by DKMS and restricts builds to ARM64 kernels
with `CONFIG_ARCH_CIX`. Generic upstream kernels are intentionally unsupported.

The Bluetooth package follows the same source-only DKMS model and depends on
`cix-firmware` for the Realtek firmware and configuration payloads requested by
the module at runtime.

The WLAN package combines two independently tracked source repositories into
one source-only DKMS package. Both repository changes map to `wlan-dkms`; the
package depends on `cix-firmware` at runtime and builds only for CIX ARM64
kernels.

The VPU package declares its real runtime dependency on `cix-vpu-firmware`.
The firmware payload comes from `cix_proprietary/cix_proprietary`, not from the
open-source VPU driver repository. Only the `.fwb` files staged under
`cix-vpu-umd/usr/lib/firmware` are included in the firmware source package.

Package build relationships belong in the source stanza `Build-Depends`,
`Build-Depends-Arch`, and `Build-Depends-Indep` fields. Build scripts must not
declare or invoke dependencies on other module build scripts.

The CIX kernel's generated `linux-libc-dev` package provides
`cix-linux-libc-dev`. Multimedia packages use that package when they
require CIX-only UAPI definitions, avoiding accidental use of Debian's generic
kernel headers.
