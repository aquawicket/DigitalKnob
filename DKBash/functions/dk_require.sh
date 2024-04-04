#include_guard()

##################################################################################
# dk_require()
#
#
function dk_require() {
	#echo "dk_require($@)"
	if [ -z "$1" ]; then
		dk_error "dk_require(<func_name> <$n>) requires 2 parameters. Example dk_require my_func \$1"
		return $false
	fi
	if [ -z "$2" ]; then
		dk_error "$1() requires at least 1 parameter"
		return $false
	fi
}