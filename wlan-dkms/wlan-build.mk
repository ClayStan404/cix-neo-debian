KERNEL_SOURCE ?= /lib/modules/$(KERNELRELEASE)/build

.PHONY: all qca rtl

all: qca rtl

qca:
	$(MAKE) -C AIO/build \
		ARCH=arm64 \
		CROSS_COMPILE= \
		KERNELPATH=$(KERNEL_SOURCE) \
		KERNELARCH=arm64 \
		CONFIG_PERF_BUILD=y \
		drivers

rtl:
	$(MAKE) -C rtl-wlan \
		ARCH=arm64 \
		CROSS_COMPILE= \
		KSRC=$(KERNEL_SOURCE) \
		KERNELPATH=$(KERNEL_SOURCE)
