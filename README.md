# kos-helpers

## Install
* Clone: `git clone https://github.com/darcagn/kos-helpers /opt/toolchains/dc/kos-helpers`
* Add `/opt/toolchains/dc/kos-helpers/kos-shell.sh` to your shell's `.bashrc`, `.zshrc`, etc.
* `mkdir -p /opt/toolchains/dc/kos-toolchains`
* Clone a KOS repo: `git clone https://github.com/KallistiOS/KallistiOS.git /opt/toolchains/dc/kos-build`
* Enter the `dc-chain` directory: `cd /opt/toolchains/dc/kos-build/utils/dc-chain`
* Build all toolchain profiles by running `/opt/toolchains/dc/kos-helpers/build-all-chains.sh`
  * Each toolchain profile will be built to `/opt/toolchains/dc/kos-toolchains/<PROFILE_NAME>` 

## Use
* `kos-editenv`: Bring up text editor to modify KOS environment settings.
* `kos-environ <PATH>`: Apply KOS environment using `<PATH>` as `$KOS_BASE`. Toolchain symlinks will be updated to point to the proper locations within `$KOS_BASE`.
* `kos-build <PATH>`: Apply KOS environment using `<PATH>` as `$KOS_BASE` and build KOS.
* `kos-rebuild <PATH>`: Apply KOS environment using `<PATH>` as `$KOS_BASE`, make clean, and build KOS.
* `kos-info`: Dump information about your current KOS environment to stdout.
