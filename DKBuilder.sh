#!/bin/sh

###### DK_SETUP ######
[ ! -e DKBash ] && mkdir DKBash
[ ! -e DKBash/functions ] && mkdir DKBash/functions
if [ ! -e DKBash/functions/DK.sh ]; then
	[ -z "$(command -v "curl")" ] && [ -n "$(command -v "tce-load")" ] && tce-load -wil curl
	curl -Lo DKBash/functions/DK.sh https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/DK.sh
fi

###### DK_INIT ######
. DKBash/functions/DK.sh


###### Load Main Program ######
[ $# -gt 0 ] && "$@" || dk_buildMain