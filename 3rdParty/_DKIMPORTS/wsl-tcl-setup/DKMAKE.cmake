#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
# https://github.com/zkedem/wsl-tcl-setup


dk_import(https://github.com/zkedem/wsl-tcl-setup/archive/2467e4ee6d2370dc15690d67d47b2097aae18cae.zip)

set(TINYCORELINUX_X86_64 "http://www.tinycorelinux.net/15.x/x86_64/release/CorePure64-current.iso")