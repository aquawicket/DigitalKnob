#!/bin/sh
#clear && clear
echo "$0($*)"


###### global variables ######
ENABLE_dk_debugFunc=0


###### DK_INIT ######
. DKBash/functions/DK.sh


###### generated global variables ######
echo SCRIPT_PATH = $SCRIPT_PATH
echo DKBASH_DIR = $DKBASH_DIR


###### Load Main Program ######
[ "$#" -gt "0" ] && "$@"
dk_buildMain "$*"