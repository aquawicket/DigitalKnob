#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##############################################################################
# dk_isFunction(name) -> rtn_var
# 
#	Test if a string is a function name
#
#	@name	- The name to test
#	@rtn_var: 	- True if the string is the name of a function, False if otherwise.
#
#	https://stackoverflow.com/a/85932/688352
#
dk_isFunction() {
	dk_debugFunc 1
	
	 $(declare -F "${1}" > /dev/null)	
}



test_function() {
	dk_info "..."
}

###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_echo "testing dk_isFunction(test_function)"
	dk_isFunction "test_function" && dk_echo "true" || dk_echo "false"
	
	dk_echo
	dk_echo "testing dk_isFunction(nonExistentFunction)" 
	dk_isFunction "nonExistentFunction" && dk_echo "true" || dk_echo "false"
}
