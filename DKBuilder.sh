#!/bin/sh

# wget http://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBuilder.sh
# chmod 777 DKBuilder.sh
# ./DKBuilder.sh

###### DK_SETUP ######
export DKHTTP_DKBASH_FUNCTIONS_DIR="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions"
export DKBASH_DIR="$PWD/DKBash"
export DKBASH_FUNCTIONS_DIR="${DKBASH_DIR}/functions"
[ ! -e ${DKBASH_DIR} ] && mkdir ${DKBASH_DIR}
[ ! -e ${DKBASH_FUNCTIONS_DIR} ] && mkdir ${DKBASH_FUNCTIONS_DIR}
if [ ! -e ${DKBASH_FUNCTIONS_DIR}/DK.sh ]; then
	[ -z "$(command -v "curl")" ] && [ -n "$(command -v "tce-load")" ] && tce-load -wil curl
	curl -Lo ${DKBASH_FUNCTIONS_DIR}/DK.sh ${DKHTTP_DKBASH_FUNCTIONS_DIR}/DK.sh
fi

###### DK_INIT ######
. ${DKBASH_FUNCTIONS_DIR}/DK.sh


###### Load Main Program ######
[ $# -gt 0 ] && "$@" || dk_buildMain