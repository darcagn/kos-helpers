# Include associated functions
. $(dirname $(readlink -f "${0}"))/environ-fn.sh

if ! kos_check_dir "${1}"; then return 1; fi

# Get desired KOS path
export KOS_BASE=$(readlink -f "${1}")
# kos-ports install directory
export KOS_PORTS="${KOS_BASE}/../kos-ports"

# Build Architecture and Subarchitecture
export KOS_ARCH="dreamcast"
export KOS_SUBARCH="pristine"

# SH Compiler Symlink, Prefix, and Multichain Path
export KOS_CC_BASE="/opt/toolchains/dc/sh-elf"
export KOS_CC_PREFIX="sh-elf"
export KOS_MULTICHAIN_PATH="/opt/toolchains/dc/kos-toolchains"

# SH Toolchain Profile
# stable toolchain (13.2.0 with newlib 4.3.0)
export KOS_CHAIN="stable"

# alt toolchains using newlib 4.4.0
#export KOS_CHAIN="15.0.0-dev"
#export KOS_CHAIN="14.1.1-dev"
#export KOS_CHAIN="14.1.0"
#export KOS_CHAIN="13.3.1-dev"
#export KOS_CHAIN="13.3.0"
#export KOS_CHAIN="12.3.0"
#export KOS_CHAIN="11.4.0"
#export KOS_CHAIN="10.5.0"
#export KOS_CHAIN="9.5.0"         # binutils 2.34

# legacy toolchains
#export KOS_CHAIN="9.3.0-legacy"  # newlib 3.3.0
#export KOS_CHAIN="4.7.4-legacy"  # newlib 2.0.0

# specialty toolchains
# GCCRS with newlib 4.4.0
#export KOS_CHAIN="gccrs-dev"
# GCC for libgccjit for rustc
#export KOS_CHAIN="rustc-dev"
# current dreamshell toolchain (stable with fastmem patch)
#export KOS_CHAIN="dreamshell"

if ! kos_check_toolchain_dir; then return 1; fi
if ! kos_adjust_toolchain_dir; then return 1; fi

# Loader Utilities
export KOS_LOADER_SER="dc-tool-ser -t /dev/ttyUSB0 -b 1562500 -x"
export KOS_LOADER_IP="dc-tool-ip -x"
export KOS_LOADER=${KOS_LOADER_IP}

# SH4 Floating Point Precision
#export KOS_SH4_PRECISION="-m4-single"
export KOS_SH4_PRECISION="-m4-single-only"

# Optimization Level
export KOS_CFLAGS="${KOS_CFLAGS} -O2"
#export KOS_CFLAGS="${KOS_CFLAGS} -O3"

# Additional Optimizations
#export KOS_CFLAGS="${KOS_CFLAGS} -freorder-blocks-algorithm=simple"
#export KOS_CFLAGS="${KOS_CFLAGS} -flto=auto"

# Frame Pointers
export KOS_CFLAGS="${KOS_CFLAGS} -fomit-frame-pointer"
#export KOS_CFLAGS="${KOS_CFLAGS} -fno-omit-frame-pointer -DFRAME_POINTERS"

# Disable GCC builtins - Builtins may interfere with Newlib/KOS implementations
export KOS_CFLAGS="${KOS_CFLAGS} -fno-builtin"

# Fast Math - Enable fssra, fsca, fsqrt - Not IEEE compliant! Overrides -fno-builtin!
#export KOS_CFLAGS="${KOS_CFLAGS} -fbuiltin -ffast-math -ffp-contract=fast -mfsrra -mfsca"

# Use LRA or reload
#export KOS_CFLAGS="${KOS_CFLAGS} -mlra" # LRA
export KOS_CFLAGS="${KOS_CFLAGS} -mno-lra" # reload

# Stack smashing protection
export KOS_CFLAGS="${KOS_CFLAGS} -fstack-protector-all"

# Make Utility - FreeBSD change to "gmake"
export KOS_MAKE="make"

# CMake Toolchain Path
export KOS_CMAKE_TOOLCHAIN="${KOS_BASE}/utils/cmake/dreamcast.toolchain.cmake"

# ARM Compiler Prefixes
export DC_ARM_BASE="/opt/toolchains/dc/arm-eabi"
export DC_ARM_PREFIX="arm-eabi"

# Genromfs Utility Path
export KOS_GENROMFS="${KOS_BASE}/utils/genromfs/genromfs"

# Additional Tools Path
if [[ ":$PATH:" != *":${KOS_CC_BASE}/bin:/opt/toolchains/dc/bin:"* ]]; then
  export PATH="${PATH}:${KOS_CC_BASE}/bin:/opt/toolchains/dc/bin"
fi

# Shared Compiler Configuration
. ${KOS_BASE}/environ_base.sh
