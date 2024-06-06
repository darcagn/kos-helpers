kos-environ () {
  source /opt/toolchains/dc/kos-helpers/environ.sh
}

kos-editenv () {
  $EDITOR /opt/toolchains/dc/kos-helpers/environ.sh
}

kos-build () {
  kos-environ "${1}" && make -C "${KOS_BASE}"
}

kos-rebuild () {
  kos-environ "${1}" && make -C "${KOS_BASE}" clean && make -C "${KOS_BASE}"
}

kos-info () {
  echo "KOS_ARCH\t   ${KOS_ARCH}"
  echo "KOS_SUBARCH\t   ${KOS_SUBARCH}"
  echo "KOS_BASE\t   ${KOS_BASE}"
  echo "KOS_PORTS\t   $(readlink -f ${KOS_PORTS})"
  echo "KOS_GCCVER\t   ${KOS_GCCVER}"
  echo "KOS_CHAIN\t   ${KOS_CHAIN}"
  echo "KOS_CHAIN_DIR\t   ${KOS_CHAIN_DIR}"
  echo "KOS_SH4_PRECISION  ${KOS_SH4_PRECISION}"
  echo "DC_ARM_BASE\t   ${DC_ARM_BASE}"
  echo "KOS_LOADER\t   ${KOS_LOADER}"
  echo "KOS_CFLAGS\t  ${KOS_CFLAGS}"
  echo "KOS_LDFLAGS\t  ${KOS_LDFLAGS}"
  echo "KOS_AFLAGS\t  ${KOS_AFLAGS}"
  echo "KOS_CPPFLAGS\t ${KOS_CPPFLAGS}"
  if [[ $(readlink -f $(which sh-elf-gcc)) == ${KOS_CHAIN_DIR}/bin/sh-elf-gcc ]]; then
    echo "KOS environment compiler matches \$PATH: ✅"
  else
    echo "KOS environment compiler matches \$PATH: ❌"
  fi
}
