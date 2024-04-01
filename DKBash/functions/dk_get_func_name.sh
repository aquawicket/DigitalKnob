#include_guard()

##################################################################################
# dk_get_func_name()
#
#
dk_get_func_name () {
	if [ -z "$1" ]; then
		dk_error "get_func_name <variable> requires 1 parameter"
		return $false
	fi
	
	eval "$1=${FUNCNAME[1]}"
	#echo "parameter name = $1"
	#echo "function name = ${FUNCNAME[1]}"
}