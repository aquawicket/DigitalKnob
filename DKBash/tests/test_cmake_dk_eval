#!/bin/sh

###### Load Function files ######
dk_realpath() {
    [ $1 = /* ] && echo "$1" || echo "$PWD/${1#./}"
}
. ../functions/DK

# dk_cmakeEval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
dk_cmakeEval "dk_debug('sent with dk_cmakeEval')" "CMAKE_CURRENT_LIST_DIR"
dk_printVar CMAKE_CURRENT_LIST_DIR

dk_pause