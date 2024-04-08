#!/bin/bash
clear && clear
export DKBASH_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )
echo "DKBASH_DIR: $DKBASH_DIR"

###### Load DK Function files (DKINIT) ######
. ${DKBASH_DIR}/functions/DK.sh

###### Load Main Program ######
#! [ "$@" = "" ] && "$@"
dk_build_main "$*"

exec $SHELL		# keep terminal open