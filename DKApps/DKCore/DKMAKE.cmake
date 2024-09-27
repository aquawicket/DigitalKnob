#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)

dk_depend(zlib)   #use for testing
dk_depend(DK)
#dk_depend(DKDebug)