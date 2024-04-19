#!/bin/sh

###### Load Function files ######
. ../functions/DK.sh


echo ""
echo ""
dk_get_host_triple
echo "HOST_TRIPLE = $HOST_TRIPLE"
echo ""

dk_wait_for_key

