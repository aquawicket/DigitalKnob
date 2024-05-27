#!/bin/sh

echo "0 = $0"
echo "\$(readlink \$0) = $(readlink $0)"
echo "\$(readlink -f \$0) = $(readlink -f $0)"
echo "\$(realpath \$0) = $(realpath $0)"
echo "pwd = $(pwd)"
echo "pwd -P = $(pwd -P)"




###### DK_SETUP ######
[ ! -e DKBash ] && mkdir DKBash
[ ! -e DKBash/functions ] && mkdir DKBash/functions
[ ! -e DKBash/functions/DK.sh ] && curl -Lo DKBash/functions/DK.sh https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/DK.sh
#[ ! -e DKBash/functions/DK.sh ] && wget -P DKBash/functions https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/DK.sh

###### DK_INIT ######
. DKBash/functions/DK.sh


###### Load Main Program ######
[ $# -gt 0 ] && "$@" || dk_buildMain