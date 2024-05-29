#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_return()
#
#
dk_source(){
	[ -e ${DKBASH_DIR}/functions/$1.sh ] || dk_command curl -Lo DKBash/functions/$1.sh https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/$1.sh
	chmod 777 ${DKBASH_DIR}/functions/$1.sh
	. ${DKBASH_DIR}/functions/$1.sh
}