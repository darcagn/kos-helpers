#!/bin/bash

export KOS_HELPERS_DIR=/opt/toolchains/dc/kos-helpers

kos-environ () {
  source ${KOS_HELPERS_DIR}/environ.sh
}

kos-editenv () {
  ${EDITOR} ${KOS_HELPERS_DIR}/environ.sh
}

kos-base-check () {
  if [ -z "${KOS_BASE}" ]; then
    echo "Error: You need to source or specify a KOS_BASE!"
    return 1
  fi
  return 0
}

kos-build () {
  if [ -n "${1}" ]; then
    kos-environ "${1}" || return 1
  fi

  kos-base-check || return 1

  make -j${KOS_MAKE_JOBS} -C "${KOS_BASE}" || return 1
}

kos-rebuild () {
  if [ -n "${1}" ]; then
    kos-environ "${1}" || return 1
  fi

  kos-base-check || return 1

  make -C "${KOS_BASE}" clean || return 1
  make -j ${KOS_MAKE_JOBS} -C "${KOS_BASE}" || return 1
}

kos-build-ports () {
  if [ -n "${1}" ]; then
    kos-environ "${1}" || return 1
  fi

  kos-base-check || return 1

  make -C "${KOS_BASE}" kos-ports_all || return 1
}

kos-rebuild-ports () {
  if [ -n "${1}" ]; then
    kos-environ "${1}" || return 1
  fi

  kos-base-check || return 1

  make -C "${KOS_BASE}" kos-ports_clean || return 1
  make -C "${KOS_BASE}" kos-ports_distclean || return 1
  make -C "${KOS_BASE}" kos-ports_all || return 1
}

kos-info () {
  ${KOS_HELPERS_DIR}/kos-info.sh
}
