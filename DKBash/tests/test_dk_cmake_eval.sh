#!/bin/sh

###### Load Function files ######
. ../functions/DK.sh

echo "**** GLOBAL VARIABLES ***"
dk_debug DKBASH_DIR
dk_debug SCRIPT_PATH
dk_debug SCRIPT_DIR
dk_debug SCRIPT_NAME

# dk_cmake_eval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
dk_cmake_eval "dk_debug('sent with dk_cmake_eval')" "CMAKE_CURRENT_LIST_DIR"
dk_debug CMAKE_CURRENT_LIST_DIR

exec $SHELL #keep window open