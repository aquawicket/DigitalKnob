#!/bin/sh
clear && clear
echo "$0($*)"
DKBASH_DIR=$HOME/digitalknob/Development/DKBash


###### Load DK Function files (DKINIT) ######
. $DKBASH_DIR/functions/DK.sh

	
###### Load Main Program ######
#! [ "$@" = "" ] && "$@"
dk_build_main "$*"

exec $SHELL		# keep terminal open