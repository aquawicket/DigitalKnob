#!/bin/bash

###### Load Function files ######
export DKBASH_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )/../
#. ${DKBASH_DIR}/functions/DK.sh
. ${DKBASH_DIR}/functions/dk_verbose.sh
. ${DKBASH_DIR}/functions/dk_string_contains.sh
. ${DKBASH_DIR}/functions/dk_debug.sh
. ${DKBASH_DIR}/functions/dk_error.sh
. ${DKBASH_DIR}/functions/dk_print_var.sh
. ${DKBASH_DIR}/functions/dk_get_host_triple.sh



echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
dk_get_host_triple
echo "HOST_TRIPLE = $HOST_TRIPLE"

exec $SHELL #keep window open

