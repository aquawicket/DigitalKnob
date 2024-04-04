#!/bin/bash

echo "clear" && clear && clear

###### Load DK Function files ######
source functions/DK.sh || echo "SOURCE_LOAD_ERROR"

### Load Main Program ###
dk_build_main

if ! [[ "$@" == "" ]]; then
	"$@"
fi

dk_build_main "$@"