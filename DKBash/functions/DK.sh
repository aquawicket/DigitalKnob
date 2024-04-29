#!bin/bash

#export PS4=$'+\e[33m ${BASH_SOURCE[0]:-nofile}:${BASH_LINENO[0]:-noline} ${FUNCNAME[0]:-nofunc}()\e[0m  '

###### Reload Main Script with bash ######
if [ ${RELOAD_WITH_BASH-1} = 1 ]; then
	export RELOAD_WITH_BASH=0
	if [ -n "$(command -v bash)" ]; then
		echo "reloading with /bin/bash . . ."
		exec /bin/bash "$0"
	else
		echo ""
		echo "ERROR: This script requires bash. Please install it and try again.";
		read -rp 'Press enter to exit...' key;
		exit 1
	fi
fi

###### include guard ######
[ -n "$DKINIT" ] && return || readonly DKINIT=1


###### get DKSCRIPT_ variables  ######
DKSCRIPT_PATH=$(pwd)/$(basename $0)
[ ! -e $DKSCRIPT_PATH ] && dk_error "DKSCRIPT_PATH does not exist"
echo "DKSCRIPT_PATH = $DKSCRIPT_PATH"
[ -n "$(command -v "cygpath")" ] && DKSCRIPT_PATH=$(cygpath -u "$DKSCRIPT_PATH")
DKSCRIPT_DIR=$(dirname $DKSCRIPT_PATH)
echo "DKSCRIPT_DIR = $DKSCRIPT_DIR"
DKSCRIPT_NAME=$(basename $DKSCRIPT_PATH)
echo "DKSCRIPT_NAME = $DKSCRIPT_NAME"


###### Set and check posix mode ######
$(set -o posix) && set -o posix && case :$SHELLOPTS: in
  *:posix:*) echo "POSIX mode enabled" ;;
  *)         echo "POSIX mode not enabled" ;;
esac


###### Set error trace options ######
$(set -o pipefail) && set -o pipefail  	# trace ERR through pipes
$(set -o errtrace) && set -o errtrace 	# trace ERR through 'time command' and other functions
#$(set -o nounset) && set -o nounset  	# set -u : exit the script if you try to use an uninitialised variable
#$(set -o errexit) && set -o errexit  	# set -e : exit the script if any statement returns a non-true


###### set true and false variables ######
readonly true=0
readonly false=1


###### get DKBASH_DIR ######
export BASH_SOURCE_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )
export DKBASH_DIR=$( cd -- "$(dirname "$BASH_SOURCE_DIR")" >/dev/null 2>&1 ; pwd -P )
export "PATH=$DKBASH_DIR/functions:$PATH"

###### aquire if missing ######
[ ! -e ${DKBASH_DIR}/functions/dk_load.sh ] && wget -P DKBash/functions https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/dk_load.sh

###### Script loader ######
. ${DKBASH_DIR}/functions/dk_load.sh
dk_load dk_escapeSequences && dk_escapeSequences
dk_load $DKSCRIPT_PATH
