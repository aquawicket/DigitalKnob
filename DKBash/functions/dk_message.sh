#include_guard()

##################################################################################
# dk_message(msg)
#
#
dk_message () {
	get_func_name funcname
	echo "funcname = $funcname"
	
	if [ -z "$1" ]; then
		dk_error "message <string> requires 1 parameter"
		return $false
	fi
	
	echo "$@"
}