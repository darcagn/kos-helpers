#!/bin/bash

# Include associated functions
. $(dirname $(readlink -f "${0}"))/environ-fn.sh

if ! kos_check_dir "${1}"; then return 1; else export KOS_BASE=$(readlink -f "${1}"); fi

# kos-ports install directory
export KOS_PORTS="${KOS_BASE}/ports"

# Build Architecture and Subarchitecture
export KOS_ARCH="dreamcast"
export KOS_SUBARCH="pristine"

# SH Compiler Symlink, Prefix, and Multichain Path
export KOS_CC_BASE="/opt/toolchains/dc/sh-elf"
export KOS_CC_PREFIX="sh-elf"
export KOS_MULTICHAIN_PATH="/opt/toolchains/dc/toolchains"

# SH Toolchain Profile
# stable toolchain (13.2.0 with newlib 4.3.0)
export KOS_CHAIN="stable"

# alt toolchain profiles
#export KOS_CHAIN="16.0.0-dev"
#export KOS_CHAIN="15.2.1-dev"
#export KOS_CHAIN="15.2.0"
#export KOS_CHAIN="15.0.0-lra"
#export KOS_CHAIN="14.3.1-dev"
#export KOS_CHAIN="14.3.0"
#export KOS_CHAIN="13.4.1-dev"
#export KOS_CHAIN="13.4.0"
#export KOS_CHAIN="9.5.0-winxp"

# current dreamshell toolchain (stable with fastmem patch)
#export KOS_CHAIN="dreamshell"

if ! kos_check_toolchain_dir; then return 1; fi
if ! kos_adjust_toolchain_dir; then return 1; fi

# Loader Utilities
export KOS_LOADER_SER="dc-tool-ser -t /dev/ttyUSB0 -b 1562500 -x"
export KOS_LOADER_IP="dc-tool-ip -x"
export KOS_LOADER=${KOS_LOADER_IP}

# Make jobs
export KOS_MAKE_JOBS="$(getconf _NPROCESSORS_ONLN)"

# SH4 Floating Point Precision
export KOS_SH4_PRECISION="-m4-single"
#export KOS_SH4_PRECISION="-m4-single-only"

# Debug Builds
#export KOS_CFLAGS="${KOS_CFLAGS} -DNDEBUG"
#export KOS_CFLAGS="${KOS_CFLAGS} -DDBGLOG_DISABLED"

# Optimization Level
export KOS_CFLAGS="${KOS_CFLAGS} -O2"
#export KOS_CFLAGS="${KOS_CFLAGS} -O3"
#export KOS_CFLAGS="${KOS_CFLAGS} -Os"

# Additional Optimizations
#export KOS_CFLAGS="${KOS_CFLAGS} -freorder-blocks-algorithm=simple"
#export KOS_CFLAGS="${KOS_CFLAGS} -fipa-pta"
#export KOS_CFLAGS="${KOS_CFLAGS} -flto=auto"
#export KOS_CFLAGS="${KOS_CFLAGS} -ffat-lto-objects"

# Frame Pointers
export KOS_CFLAGS="${KOS_CFLAGS} -fomit-frame-pointer"
#export KOS_CFLAGS="${KOS_CFLAGS} -fno-omit-frame-pointer -DFRAME_POINTERS"

# Disable GCC builtins - Builtins may interfere with Newlib/KOS implementations
export KOS_CFLAGS="${KOS_CFLAGS} -fno-builtin"

# Fast Math - Enable fssra, fsca, fsqrt - Not IEEE compliant! Overrides -fno-builtin!
#export KOS_CFLAGS="${KOS_CFLAGS} -fbuiltin -ffast-math -ffp-contract=fast -mfsrra -mfsca"

# Position-Independent Code -- Comment out when building dylibs
export KOS_CFLAGS="${KOS_CFLAGS} -fno-PIC -fno-PIE"

# Use LRA or reload
#export KOS_CFLAGS="${KOS_CFLAGS} -mlra" # LRA
export KOS_CFLAGS="${KOS_CFLAGS} -mno-lra" # reload

# Stack smashing protection
#export KOS_CFLAGS="${KOS_CFLAGS} -fstack-protector-all"

# Make Utility - FreeBSD change to "gmake"
export KOS_MAKE="make"

# CMake Toolchain Path
export KOS_CMAKE_TOOLCHAIN="${KOS_BASE}/utils/cmake/kallistios.toolchain.cmake"

# ARM Compiler Prefixes
export DC_ARM_BASE="/opt/toolchains/dc/arm-eabi"
export DC_ARM_PREFIX="arm-eabi"

# Genromfs Utility Path
export KOS_GENROMFS="${KOS_BASE}/utils/genromfs/genromfs"

# DC Tools dir
export DC_TOOLS_BASE="/opt/toolchains/dc/bin"

# Shared Compiler Configuration
. ${KOS_BASE}/environ_base.sh
