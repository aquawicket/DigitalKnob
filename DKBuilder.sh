#!/bin/sh
#clear && clear
echo "$0($*)"


###### DK_INIT ######
. DKBash/functions/DK.sh


###### Global variables ######
echo SCRIPT_PATH = $SCRIPT_PATH
echo DKBASH_DIR = $DKBASH_DIR


###### Load Main Program ######
[ -n "$@" ] && "$@"
dk_buildMain "$*"