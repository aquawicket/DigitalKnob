[ -n "$DKINIT" ] && return || readonly DKINIT=1     # dk_include_guard()
#clear && clear

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
echo "shell_type = $shell_type"
[ $shell_type = sh ] && export DKSH=1 && export ext=sh
[ $shell_type = dash ] && export DKDASH=1 && export ext=sh
[ $shell_type = zsh ] && export DKZSH=1 && export ext=sh
[ $shell_type = bash ] && export DKBASH=1 && export ext=bash

[ $DKSH ]   && echo "DKSH"
[ $DKDASH ] && echo "DKDASH"
[ $DKZSH ] && echo "DKZSH"
[ $DKBASH ] && echo "DKBASH"

###### get DKBASH_DIR ######
export BASH_SOURCE_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )
export DKBASH_DIR=$( cd -- "$(dirname "$BASH_SOURCE_DIR")" >/dev/null 2>&1 ; pwd -P )

###### Script loader ######
. ${DKBASH_DIR}/functions/array.sh
. ${DKBASH_DIR}/functions/dk_load.${ext}
