#!/bin/sh
# dk_includeGuard

#clear && clear
#echo "$0($*)"


###### global variables ######
#ENABLE_dk_debugFunc=1


###### DK_INIT ######
. DKBash/functions/DK.sh


###### generated global variables ######
echo DKSCRIPT_PATH = $DKSCRIPT_PATH
echo DKBASH_DIR = $DKBASH_DIR


###### Load Main Program ######
[ "$#" -gt "0" ] && "$@"
dk_buildMain "$*"