#!/bin/bash

build_dev_toolchains_only=false
make_jobs=2

while [[ $# -gt 0 ]]; do
    case "$1" in
        --dev-only)
            build_dev_toolchains_only=true
            ;;
        -j*)
            if [[ "$1" == "-j" && -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
                make_jobs="$2"
                shift
            elif [[ "$1" =~ ^-j([0-9]+)$ ]]; then
                make_jobs="${BASH_REMATCH[1]}"
            else
                echo "Error: -j option requires a numeric argument"
                exit 1
            fi
            ;;
        *)
            ;;
    esac
    shift
done

if [ "${PWD##*/}" != "dc-chain" ]; then
  echo "This script must be run inside the dc-chain directory."
  exit 1
fi

for file in profiles/profile.*.mk; do
  if [ -f "$file" ]; then
    profile_name="${file#*/profile.}"
    profile_name="${profile_name%.mk}"
    sh_toolchain_path="/opt/toolchains/dc/toolchains/${profile_name}"

    make_cmd="make"
    make_cmd+=" toolchain_profile=${profile_name}"
    make_cmd+=" makejobs=${make_jobs}"
    make_cmd+=" verbose=0"
    make_cmd+=" sh_toolchain_path=${sh_toolchain_path}"
    make_cmd+=" newlib_iconv_encodings=us_ascii,utf8,utf16,ucs_2_internal,ucs_4_internal"
    make_cmd+=" newlib_multibyte=1"
    make_cmd+=" build-sh4"

    if [[ "$profile_name" == *"-dev" ]]; then
      if [[ "$profile_name" != "13."* ]]; then
        make_cmd+=" enable_rust=1"
      fi
    fi

    if [ "$build_dev_toolchains_only" = true ]; then
        if [[ "$profile_name" != *"-dev" ]]; then
            continue
        fi
    fi

    echo "***************************************"
    echo "+++ Building $profile_name toolchain..."
    echo "${make_cmd}"
    echo "***************************************"
    echo "${make_cmd}" | bash
    echo "$(date '+%Y-%m-%d %r')" >> $sh_toolchain_path/build_date.txt
    echo "***********************************************"
    echo "+++ Cleaning up after building $profile_name..."
    echo "***********************************************"
    echo "${make_cmd} clean" | bash
    echo "***********************************************"
  fi
done
