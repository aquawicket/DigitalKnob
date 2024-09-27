#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/neurobin/shc.git

#dk_import(https://github.com/neurobin/shc.git)
dk_import(https://github.com/neurobin/shc/archive/refs/heads/master.zip)
