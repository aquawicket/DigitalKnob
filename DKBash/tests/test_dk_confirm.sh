#!/bin/bash

###### Load Function files ######
export DKBASH_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )/../
. ${DKBASH_DIR}/functions/DK.sh



echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
if dk_confirm; then 
	echo "the confimation has passed"
else
	echo "the confimation has failed"
fi

exec $SHELL #keep window open

