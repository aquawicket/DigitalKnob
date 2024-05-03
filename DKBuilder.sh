#!/bin/sh

#echo "$0($*)"


###### DK_SETUP ######
[ ! -e DKBash ] && mkdir DKBash
[ ! -e DKBash/functions ] && mkdir DKBash/functions
[ ! -e DKBash/functions/DK ] && wget -P DKBash/functions https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/DK
[ ! -e DKBash/functions/DK ] && curl -o DKBash/functions/DK https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/DK

###### DK_INIT ######
. DKBash/functions/DK


###### generated global variables ######
echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
echo "DKBASH_DIR = ${DKBASH_DIR}"


###### Load Main Program ######
[ "$#" -gt "0" ] && "$@"
dk_buildMain "$*"