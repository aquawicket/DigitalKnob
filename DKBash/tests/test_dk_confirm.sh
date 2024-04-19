#!/bin/sh

###### Load Function files ######
. ../functions/DK.sh


echo ""
if dk_confirm; then 
	echo "the confimation has passed"
else
	echo "the confimation has failed"
fi

dk_wait_for_key