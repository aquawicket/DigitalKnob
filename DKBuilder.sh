#!/bin/sh
#clear && clear
echo "$0($*)"
[ -n "$@" ] && "$@"


###### DK_INIT ######
. DKBash/functions/DK.sh


###### Global variables ######
echo SCRIPT_PATH = $SCRIPT_PATH
echo DKBASH_DIR = $DKBASH_DIR


###### Load Main Program ######
dk_buildMain "$*"