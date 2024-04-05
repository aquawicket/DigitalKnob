#!/bin/bash

echo "clear" && clear && clear

###### Load DK Function files ######
source functions/DK.sh

### Load Main Program ###

#if ! [[ "$@" == "" ]]; then
#	"$@"
#fi

dk_build_main "$@"