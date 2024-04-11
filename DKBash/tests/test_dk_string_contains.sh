#!/bin/bash

###### Load Function files ######
export DKBASH_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )/../
#. ${DKBASH_DIR}/functions/DK.sh
. ${DKBASH_DIR}/functions/dk_verbose.sh
. ${DKBASH_DIR}/functions/dk_string_contains.sh
. ${DKBASH_DIR}/functions/dk_debug.sh
. ${DKBASH_DIR}/functions/dk_error.sh
. ${DKBASH_DIR}/functions/dk_print_var.sh

echo ""
echo ""
echo ""
echo ""
echo ""
echo ""

if dk_string_contains "1one1" "one"; then
	echo "1one1 contains one"
else
	echo "1one1 does not contains one"
fi

if dk_string_contains "2two2" "tow"; then
	echo "2two2 contains tow"
else
	echo "2two2 does not contain tow"
fi

exec $SHELL #keep window open