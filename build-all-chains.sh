#!/bin/bash

if [ "${PWD##*/}" != "dc-chain" ]; then
  echo "This script must be run inside the dc-chain directory."
  exit 1
fi

for file in profiles/profile.*.mk; do
  if [ -f "$file" ]; then
    profile_name="${file#*/profile.}"
    profile_name="${profile_name%.mk}"
    sh_toolchain_path="/opt/toolchains/dc/kos-toolchains/${profile_name}"

    make_cmd="make"
    make_cmd+=" toolchain_profile=${profile_name}"
    make_cmd+=" makejobs=6"
    make_cmd+=" verbose=0"
    make_cmd+=" sh_toolchain_path=${sh_toolchain_path}"
    make_cmd+=" default_precision=m4-single"
    make_cmd+=" newlib_iconv_encodings=us_ascii,utf8,utf16,ucs_2_internal,ucs_4_internal"
    make_cmd+=" newlib_multibyte=1"

    if [[ "$profile_name" == *"-dev" ]]; then
      if [[ "$profile_name" != "13."* ]]; then
        make_cmd+=" enable_rust=1"
      fi
    fi

    if [[ "$profile_name" == "rustc-dev" ]]; then
      make_cmd+=" enable_libgccjit=1"
    fi

    echo "***************************************"
    echo "+++ Building $profile_name toolchain..."
    echo "${make_cmd}"
    echo "***************************************"
    echo "${make_cmd}" | bash
    echo "Build completed at $(date '+%Y-%m-%d %r')" >> $sh_toolchain_path/build_date.txt
    echo "***********************************************"
    echo "+++ Cleaning up after building $profile_name..."
    echo "***********************************************"
    echo "${make_cmd} clean" | bash
    echo "***********************************************"
  fi
done
