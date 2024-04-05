#!/bin/bash
clear && clear

###### Load DK Function files (DK_INIT) ######
source functions/DK.sh

###### Load Main Program ######
! [[ "$@" == "" ]] && "$@"
dk_build_main "$@"