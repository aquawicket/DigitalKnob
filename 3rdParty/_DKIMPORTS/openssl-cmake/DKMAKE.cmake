#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/viaduck/openssl-cmake.git

#dk_import(https://github.com/viaduck/openssl-cmake.git)
dk_import(https://github.com/viaduck/openssl-cmake/archive/refs/heads/v3.zip)

