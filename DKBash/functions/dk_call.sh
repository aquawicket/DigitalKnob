#include_guard()

##################################################################################
# dk_call(args)
#
#
dk_call () {
	if [ -z "$1" ]; then
		dk_error "call <command args> requires at least 1 parameter"
		return $false
	fi
	
	echo -e "${magenta} $ $@ ${CLR}"
	"$@"
}