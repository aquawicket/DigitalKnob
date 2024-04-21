#!/bin/sh

###### Load Function files ######
. ../functions/DK.sh

# dk_cmake_eval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
dk_cmake_eval "dk_debug('test dk_debug message')"


dk_pause