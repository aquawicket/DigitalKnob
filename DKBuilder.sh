#!/bin/sh
#echo "$0($*)"


###### Settings ######
#ENABLE_dk_debugFunc=1
#ENABLE_dk_verbose=0
#TRACE_ON_VERBOSE=1
#PAUSE_ON_VERBOSE=1
#HALT_ON_VERBOSE=1
#ENABLE_dk_debug=0
#TRACE_ON_DEBUG=1
#PAUSE_ON_DEBUG=1
#HALT_ON_DEBUG=1
#ENABLE_dk_warning=0
#TRACE_ON_WARNING=1
#PAUSE_ON_WARNING=1
#HALT_ON_WARNING=1
#ENABLE_dk_error=0
#TRACE_ON_ERROR=0
#PAUSE_ON_ERROR=0
#HALT_ON_ERROR=1


###### DK_INIT ######
. DKBash/functions/DK.sh


###### generated global variables ######
echo DKSCRIPT_PATH = $DKSCRIPT_PATH
echo DKBASH_DIR = $DKBASH_DIR


###### Load Main Program ######
[ "$#" -gt "0" ] && "$@"
dk_buildMain "$*"