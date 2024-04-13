#!/bin/sh

###### Load Function files ######
export DKBASH_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )/../
#. ${DKBASH_DIR}/functions/DK.sh
. ${DKBASH_DIR}/functions/dk_color.sh
. ${DKBASH_DIR}/functions/dk_echo.sh


echo "This is a normal echo commmand"
dk_echo "This is a dk_echo line"
dk_echo "${cyan} This is dk_echo with color ${clr}"

exec $SHELL #keep window open