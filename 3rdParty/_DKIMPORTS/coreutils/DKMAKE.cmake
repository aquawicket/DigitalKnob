#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://formulae.brew.sh/formula/coreutils


MAC_HOST_dk_command(brew install coreutils)
