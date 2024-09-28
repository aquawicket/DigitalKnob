#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/tsaarni/cpp-subprocess

# NOTE:		Header only library
#			Use #include "subprocess.hpp"

### IMPORT ###
#dk_import(https://github.com/tsaarni/cpp-subprocess.git)
dk_import(https://github.com/tsaarni/cpp-subprocess/archive/refs/heads/master.zip)



### LINK ###
dk_include(${CPP_SUBPROCESS}/include)
