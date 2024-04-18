#!/bin/sh
clear && clear
#echo "$0($*)"




###### Load DK Function files (DKINIT) ######
. DKBash/functions/DK.sh

	
###### Load Main Program ######
#! [ "$@" = "" ] && "$@"
dk_build_main "$*"

exec $SHELL		# keep terminal open