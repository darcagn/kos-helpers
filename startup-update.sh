#!/bin/bash

STARTUP_FILE="${KOS_BASE}/kernel/arch/dreamcast/kernel/startup.o"

if [ -z "$KOS_BASE" ]; then
  echo "KOS_BASE is not set! Make sure your KOS environment is set up first."
  exit 1
fi
if [ -z "$KOS_CC_BASE" ]; then
  echo "KOS_CC_BASE is not set! Make sure your KOS environment is set up first."
  exit 1
fi
if [ -z "$KOS_SH4_PRECISION" ]; then
  echo "KOS_SH4_PRECISION is not set, assuming -m4-single-only."
  KOS_SH4_PRECISION="-m4-single-only"
fi
if ! [ -f "$STARTUP_FILE" ]; then
  echo "Error: Expected startup file does not exist: $STARTUP_FILE"
  echo "Did you compile your KOS installation?"
  exit 1
fi
CRT1PATH=$(sh-elf-gcc ${KOS_SH4_PRECISION} -print-file-name=crt1.o)
if [ -f "${CRT1PATH}" ]; then
#if [[ "${CRT1PATH}" == "${KOS_CC_BASE}"* ]]; then
  echo "Updating your startup file at ${CRT1PATH}..."
  cp ${KOS_BASE}/kernel/arch/dreamcast/kernel/startup.o ${CRT1PATH}
else
  echo "Error: Could not determine the path to update your startup file..."
  exit 1
fi
