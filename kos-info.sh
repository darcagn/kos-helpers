#!/bin/bash

if [[ "${KOS_ARCH}" == "" ]]; then
  echo "Please set up a KOS environment first!"
  return 1
fi
echo -e "KOS_ARCH\t   ${KOS_ARCH}"
echo -e "KOS_SUBARCH\t   ${KOS_SUBARCH}"
echo -e "KOS_BASE\t   ${KOS_BASE}"
echo -e "KOS_PORTS\t   $(readlink -f ${KOS_PORTS})"
echo -e "KOS_GCCVER\t   ${KOS_GCCVER}"
echo -e "KOS_CHAIN\t   ${KOS_CHAIN}"
echo -e "KOS_CHAIN_DIR\t   ${KOS_CHAIN_DIR}"
echo -e "KOS_SH4_PRECISION  ${KOS_SH4_PRECISION}"
echo -e "DC_ARM_BASE\t   ${DC_ARM_BASE}"
echo -e "KOS_LOADER\t   ${KOS_LOADER}"
echo -e "KOS_CFLAGS\t  ${KOS_CFLAGS}"
echo -e "KOS_LDFLAGS\t  ${KOS_LDFLAGS}"
echo -e "KOS_AFLAGS\t  ${KOS_AFLAGS}"
echo -e "KOS_CPPFLAGS\t ${KOS_CPPFLAGS}"
if [[ $(readlink -f $(which sh-elf-gcc)) == ${KOS_CHAIN_DIR}/bin/sh-elf-gcc ]]; then
  echo "KOS environment compiler matches \$PATH: ✅"
else
  echo "KOS environment compiler matches \$PATH: ❌"
fi
