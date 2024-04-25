#!/bin/sh

###### Load Function files ######
. ../functions/DK.sh

. ${DKBASH_DIR}/functions/dk_debug.sh
. ${DKBASH_DIR}/functions/dk_debug.sh

dk_debug "testing dk_includeGuard. loading of dk_debug.sh should have been stopped twice."
dk_pause