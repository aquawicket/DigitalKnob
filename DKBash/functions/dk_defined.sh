#include_guard()

##################################################################################
# dk_defined(var)
#
#	Check if a variable name is defined
#
#	@var	- The name of the variable to check
#
#	reference: https://stackoverflow.com/a/13864829/688352
#
dk_defined () {
	#dk_defined "dk_defined("$@")"
	if [ -z "$1" ]; then
		return 1
	fi
	var=$1
	! [ -z ${!var+x} ]
}