#!/bin/sh

###### Load Function files ######
. ../functions/DK.sh

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

dk_wait_for_key