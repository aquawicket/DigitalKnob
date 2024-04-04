#!/bin/sh

#[ -n "$dk_load" ] && return || readonly dk_load=1     #include_guard()

###### Global Script Variables ######
export DKBASH_DIR=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )
export SCRIPT_NAME=$(basename "$0")
shell_type=$(basename $(readlink /proc/$$/exe))
[ $shell_type = dash ] && export SH=1 && export DASH=1 && unset BASH
[ $shell_type = bash ] && export BASH=1 && unset SH && unset DASH
[ $SH ]   && echo "SH"
[ $DASH ] && echo "DASH"
[ $BASH ] && echo "BASH"
[ $SH ]   && export echo="echo "
[ $BASH ] && export echo="echo -e"


###### Global Script Variables ######
export LOG_VERBOSE=0
export LOG_DEBUG=1
export HALT_ON_WARNINGS=1
export HALT_ON_ERRORS=1
export true=0
export false=1


. functions/dk_load.sh
dk_load dk_color
