#!/bin/bash

export KOS_INC_PATHS=""
export KOS_CFLAGS=""
export KOS_CPPFLAGS=""
export KOS_LDFLAGS=""
export KOS_AFLAGS=""
export DC_ARM_LDFLAGS=""

kos_check_dir() {
  if [ -z "${1}" ]; then
    echo "Error: Provide a path to your KOS directory!"
    return 1
  else
    if ! [ -f "${1}/environ_base.sh" ]; then
      echo "Error: No environ_base.sh exists at ${1}/environ_base.sh!"
      echo "Is this a valid KOS directory?"
      return 1
    fi
  fi
}

kos_check_toolchain_dir() {
  if ! [ -d "${KOS_MULTICHAIN_PATH}/${KOS_CHAIN}" ]; then
    echo "Error: No ${KOS_CHAIN} toolchain exists at ${KOS_MULTICHAIN_PATH}/${KOS_CHAIN}!"
    return 1
  else
    export KOS_CHAIN_DIR="${KOS_MULTICHAIN_PATH}/${KOS_CHAIN}"
  fi
}

kos_adjust_toolchain_dir() {
  ln -nsf "${KOS_CHAIN_DIR}" "${KOS_CC_BASE}"

  ln -nsf "${KOS_BASE}/kernel/arch/dreamcast/include/arch" "${KOS_CHAIN_DIR}/sh-elf/include/arch"
  ln -nsf "${KOS_BASE}/include/kos" "${KOS_CHAIN_DIR}/sh-elf/include/kos"

  rm "${KOS_CHAIN_DIR}/sh-elf/include/pthread.h"
  ln -nsf "${KOS_BASE}/include/pthread.h" "${KOS_CHAIN_DIR}/sh-elf/include/pthread.h"

  rm "${KOS_CHAIN_DIR}/sh-elf/include/sys/_pthreadtypes.h"
  ln -nsf "${KOS_BASE}/include/sys/_pthreadtypes.h" "${KOS_CHAIN_DIR}/sh-elf/include/sys/_pthreadtypes.h"

  rm "${KOS_CHAIN_DIR}/sh-elf/include/sys/_pthread.h"
  ln -nsf "${KOS_BASE}/include/sys/_pthread.h" "${KOS_CHAIN_DIR}/sh-elf/include/sys/_pthread.h"

  rm "${KOS_CHAIN_DIR}/sh-elf/include/sys/lock.h"
  ln -nsf "${KOS_BASE}/include/sys/lock.h" "${KOS_CHAIN_DIR}/sh-elf/include/sys/lock.h"
}

