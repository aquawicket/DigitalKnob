#!/bin/sh


###### DK_SETUP ######
[ ! -e DKBash ] && mkdir DKBash
[ ! -e DKBash/functions ] && mkdir DKBash/functions
[ ! -e DKBash/functions/DK.sh ] && curl -Lo DKBash/functions/DK.sh https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/DK.sh
#[ ! -e DKBash/functions/DK.sh ] && wget -P DKBash/functions https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/DK.sh

###### DK_INIT ######
. DKBash/functions/DK.sh


###### Load Main Program ######
[ $# -gt 0 ] && "$@" || dk_buildMain