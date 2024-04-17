#!/bin/sh
clear && clear
echo "$0($*)"

#echo "$(type [[)"
#echo "$(type declare)"
#echo "$(type local)"

SCRIPT_DIR=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )
SCRIPT_NAME=$(basename "$0")
true=0
false=1
clr="\033[0m"
black="\033[100m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
white="\033[37m"

###### Load DK Function files (DKINIT) ######
. DKBash/functions/DK.sh

###### Load Main Program ######
#! [ "$@" = "" ] && "$@"
dk_build_main "$*"

#exec $SHELL		# keep terminal open