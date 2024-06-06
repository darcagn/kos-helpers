#!/bin/bash

export KOS_HELPERS_DIR=/opt/toolchains/dc/kos-helpers

kos-environ () {
  source ${KOS_HELPERS_DIR}/environ.sh
}

kos-editenv () {
  ${EDITOR} ${KOS_HELPERS_DIR}/environ.sh
}

kos-build () {
  kos-environ "${1}" && make -C "${KOS_BASE}"
}

kos-rebuild () {
  kos-environ "${1}" && make -C "${KOS_BASE}" clean && make -C "${KOS_BASE}"
}

kos-info () {
  ${KOS_HELPERS_DIR}/kos-info.sh
}
