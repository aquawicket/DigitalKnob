#echo "$0($*)"

###### Set and check posix mode ######
$(set -o posix) && set -o posix && case :$SHELLOPTS: in
  *:posix:*) echo "POSIX mode enabled" ;;
  *)         echo "POSIX mode not enabled" ;;
esac
$(set -o pipefail) && set -o pipefail  	# trace ERR through pipes
$(set -o errtrace) && set -o errtrace 	# trace ERR through 'time command' and other functions
#$(set -o nounset) && set -o nounset  	# set -u : exit the script if you try to use an uninitialised variable
#$(set -o errexit) && set -o errexit  	# set -e : exit the script if any statement returns a non-true
	
SCRIPT_PATH=$(realpath $0)
SCRIPT_DIR=$(dirname $SCRIPT_PATH)
SCRIPT_NAME=$(basename $SCRIPT_PATH)

#export PS4=$'+\e[33m ${BASH_SOURCE[0]:-nofile}:${BASH_LINENO[0]:-noline} ${FUNCNAME[0]:-nofunc}()\e[0m  '

###### Reload Main Script with bash ######
if [ ${RELOAD_WITH_BASH-1} = 1 ]; then # && ! dk_defined BASH; then
	export RELOAD_WITH_BASH=0
	if [ -n "$(command -v bash)" ]; then
		exec /bin/bash "$0"
	else
		echo ""
		echo "ERROR: This script requires bash. Please install it and try again.";
		read -rp 'Press enter to exit...' key;
		exit 1
	fi
fi

[ -n "$DKINIT" ] && return || readonly DKINIT=1     # dk_include_guard()

###### Global Script Variables ######
export LOG_VERBOSE=1
export LOG_DEBUG=1
export TRACE_ON_WARNINGS=0
export HALT_ON_WARNINGS=1
export CONTINUE_ON_ERRORS=0
readonly true=0
readonly false=1


###### Script internal setup ######
[ -d "/proc" ] && shell_type=$(basename $(readlink /proc/$$/exe))
[ "$SHELL" = "/bin/zsh" ] && shell_type="zsh"
#echo "shell_type = $shell_type"
[ $shell_type = sh ] && export DKSH=1 && export ext=sh
[ $shell_type = dash ] && export DKDASH=1 && export ext=sh
[ $shell_type = zsh ] && export DKZSH=1 && export ext=sh
[ $shell_type = bash ] && export DKBASH=1 && export ext=bash

#[ $DKSH ]   && echo "DKSH"
#[ $DKDASH ] && echo "DKDASH"
#[ $DKZSH ] && echo "DKZSH"
#[ $DKBASH ] && echo "DKBASH"

###### get DKBASH_DIR ######
export BASH_SOURCE_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )
export DKBASH_DIR=$( cd -- "$(dirname "$BASH_SOURCE_DIR")" >/dev/null 2>&1 ; pwd -P )

###### Script loader ######
. ${DKBASH_DIR}/functions/array.sh
. ${DKBASH_DIR}/functions/dk_load.${ext}
. ${DKBASH_DIR}/functions/dk_color.sh
