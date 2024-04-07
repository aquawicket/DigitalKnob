#!/bin/bash
clear && clear

###### Load DK Function files (DKINIT) ######
source functions/DK.sh

###### Load Main Program ######
! [[ "$@" == "" ]] && "$@"
dk_build_main "$@"