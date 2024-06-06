#!/bin/bash

if [[ "${KOS_ARCH}" == "" ]]; then
  echo "Please set up a KOS environment first!"
  return 1
fi
echo -e "KOS_ARCH\t   ${KOS_ARCH}"
echo -e "KOS_SUBARCH\t   ${KOS_SUBARCH}"
echo -e "KOS_BASE\t   ${KOS_BASE}"
echo -e "KOS_PORTS\t   $(readlink -f ${KOS_PORTS})"
if ! [ -z "${DC_TOOLS_BASE}" ] ; then
  echo -e "DC_TOOLS_BASE\t   ${DC_TOOLS_BASE}"
fi
echo -e "KOS_GCCVER\t   ${KOS_GCCVER}"
echo -e "KOS_CHAIN\t   ${KOS_CHAIN}"
echo -e "KOS_CHAIN_DIR\t   ${KOS_CHAIN_DIR}"
if [ -f "${KOS_CHAIN_DIR}/build_date.txt" ]; then
  echo -en "Toolchain build date: "
  cat "${KOS_CHAIN_DIR}/build_date.txt"
fi
echo -e "KOS_CFLAGS\t  ${KOS_CFLAGS}"
echo -e "KOS_LDFLAGS\t  ${KOS_LDFLAGS}"
echo -e "KOS_AFLAGS\t  ${KOS_AFLAGS}"
echo -e "KOS_CPPFLAGS\t ${KOS_CPPFLAGS}"
echo -e "KOS_SH4_PRECISION  ${KOS_SH4_PRECISION}"
echo -e "KOS_LOADER\t   ${KOS_LOADER}"
if [ -f "${DC_ARM_BASE}/bin/arm-eabi-gcc" ]; then
  echo -e "DC_ARM_BASE\t   ${DC_ARM_BASE} [installed ✅]"
else
  echo -e "DC_ARM_BASE\t   ${DC_ARM_BASE} [installed ❌]"
fi
echo -e "PATH\t\t   ${PATH}"
if [[ $(readlink -f $(which sh-elf-gcc)) == ${KOS_CHAIN_DIR}/bin/sh-elf-gcc ]]; then
  echo "KOS environment compiler matches \$PATH: ✅"
else
  echo "KOS environment compiler matches \$PATH: ❌"
fi
echo -en "kos-ports installed: "
if [ ! -d "${KOS_PORTS}/lib/.kos-ports" ]; then
  echo -e "none"
else
  for FILE in "${KOS_PORTS}/lib/.kos-ports"/*; do
    FILENAME=$(basename "$FILE")
    if [ "${FILENAME}" != "README" ]; then
      echo -n "${FILENAME}-"
      echo -n "$(cat ${FILE}) "
    fi
  done
echo ""
fi
