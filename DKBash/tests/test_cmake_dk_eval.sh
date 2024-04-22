#!/bin/sh

###### Load Function files ######
dk_realpath() {
    [ $1 = /* ] && echo "$1" || echo "$PWD/${1#./}"
}
. ../functions/DK.sh

# dk_cmake_eval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
dk_cmake_eval "dk_debug('sent with dk_cmake_eval')" "CMAKE_CURRENT_LIST_DIR"
dk_debug CMAKE_CURRENT_LIST_DIR

dk_pause