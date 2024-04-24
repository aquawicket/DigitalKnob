#!bin/bash
#echo "$0($*)"

#echo "The script you are running has:"
echo "0		  : $0"
echo "basename: [$(basename "$0")]"
echo "dirname : [$(dirname "$0")]"
echo "pwd     : [$(pwd)]"
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


###### get SCRIPT_ variables  ######
#. DKBash/functions/dk_realpath.sh
dk_realpath() {
    [ $1 = /* ] && echo "$1" || echo "$PWD/${1#./}"
}
#readonly SCRIPT_PATH=$(dk_realpath $0)
SCRIPT_PATH=$(pwd)/$(basename $0)
[ ! -e $SCRIPT_PATH ] && dk_error "SCRIPT_PATH does not exist"
echo "SCRIPT_PATH = $SCRIPT_PATH"
[ -n "$(command -v "cygpath")" ] && SCRIPT_PATH=$(cygpath -u "$SCRIPT_PATH")
SCRIPT_DIR=$(dirname $SCRIPT_PATH)
echo "SCRIPT_DIR = $SCRIPT_DIR"
SCRIPT_NAME=$(basename $SCRIPT_PATH)
echo "SCRIPT_NAME = $SCRIPT_NAME"


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


###### get shell type ######
[ -d "/proc" ] && shell_type=$(basename $(readlink /proc/$$/exe))
[ "$SHELL" = "/bin/zsh" ] && shell_type="zsh"
#echo "shell_type = $shell_type"
[ $shell_type = sh ] && export DKSH=1 && export ext=sh
[ $shell_type = dash ] && export DKDASH=1 && export ext=sh
[ $shell_type = zsh ] && export DKZSH=1 && export ext=bash
[ $shell_type = bash ] && export DKBASH=1 && export ext=bash
#[ $DKSH ]   && echo "DKSH"
#[ $DKDASH ] && echo "DKDASH"
#[ $DKZSH ] && echo "DKZSH"
#[ $DKBASH ] && echo "DKBASH"


###### get DKBASH_DIR ######
export BASH_SOURCE_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )
export DKBASH_DIR=$( cd -- "$(dirname "$BASH_SOURCE_DIR")" >/dev/null 2>&1 ; pwd -P )


###### Script loader ######
. ${DKBASH_DIR}/functions/dk_load.${ext}
#dk_load $SCRIPT_PATH
dk_load dk_escapeSequences
