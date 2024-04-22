#!/bin/sh

###### Load Function files ######
. ../functions/DK.sh

echo ""
echo ""
echo "This is a normal echo commmand"
dk_echo "This is a dk_echo line"
dk_echo "${cyan} This is dk_echo with color ${clr}"

dk_pause