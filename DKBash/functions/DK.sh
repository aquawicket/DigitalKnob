#!/bin/sh

###### Global Script Variables ######
export DKBASH_DIR=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )
shell_type=$(basename $(readlink /proc/$$/exe))
[ $shell_type = dash ] && export SH=1 && export DASH=1 && unset BASH
[ $shell_type = bash ] && export BASH=1 && unset SH && unset DASH
[ $SH ]   && echo "SH"
[ $DASH ] && echo "DASH"
[ $BASH ] && echo "BASH"
[ $SH ]   && export echo="echo "
[ $BASH ] && export echo="echo -e"
export true=0
export false=1