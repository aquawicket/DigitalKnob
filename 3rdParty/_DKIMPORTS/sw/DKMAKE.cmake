#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/SoftwareNetwork/sw

#WIN_dk_import(https://github.com/SoftwareNetwork/sw.git)
WIN_dk_import(https://github.com/SoftwareNetwork/sw/archive/refs/heads/b0.4.5.zip)
