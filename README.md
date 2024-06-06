# kos-helpers

## Purpose
This repo contains several helper scripts that assist KOS power users in managing multiple KOS dirs, toolchains, etc. while avoiding configuration issues that may creep up attempting this.

Instead of juggling multiple `environ.sh` scripts in each KOS dir, the scripts provide a global environment setting mechanism that can be modified and applied using provided commands. Switching KOS dirs or toolchains also updates all of the symlinks within the toolchain to point to the KOS dir's resources to keep KOS dir and toolchain dir synchronized.

## Install
* Clone: `git clone https://github.com/darcagn/kos-helpers /opt/toolchains/dc/kos-helpers`
* Add `/opt/toolchains/dc/kos-helpers/kos-shell.sh` to your shell's `.bashrc`, `.zshrc`, etc.
* `mkdir -p /opt/toolchains/dc/kos-toolchains`
* Place move your KOS toolchain directories to `/opt/toolchains/dc/kos-toolchains`, giving each directory a name you'll use later in your environment settings

## Building toolchains
If you'd like to build various toolchains to go with this configuration, complete the following steps:
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

<img width="675" alt="image" src="https://github.com/darcagn/kos-helpers/assets/5105103/48080da2-c87f-4464-bde5-7a8ad141cf9a">
