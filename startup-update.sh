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
if ! [ -f "$STARTUP_FILE" ]; then
  echo "Error: Expected startup file does not exist: $STARTUP_FILE"
  echo "Did you compile your KOS installation?"
  exit 1
fi
CRT1PATH=$(sh-elf-gcc ${KOS_CFLAGS} -print-file-name=crt1.o)
if [ -f "${CRT1PATH}" ]; then
  echo "Updating your startup file at ${CRT1PATH}..."
  cp ${KOS_BASE}/kernel/arch/dreamcast/kernel/startup.o ${CRT1PATH}
else
  echo "Error: Could not determine the path to update your startup file..."
  exit 1
fi
