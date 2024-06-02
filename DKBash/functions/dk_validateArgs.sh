#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


###############################################################################
# dkValidateArgs(...)
#
dkValidateArgs() {
	dk_debugFunc
	echo -e "$(__FILE__ 2):$(__LINE__ 2)  $(__FUNCTION__ 2)($(__ARGC__ 2):$(__ARGV__ 2))"
	
	echo "requiredARGC = $#: got $(__ARGC__ 2)"
	
	for arg in "$@"
	do
		if [ $arg = "array" ]; then
			echo "$arg" 
		elif [ $arg = "rtn_var" ]; then
			echo "$arg" 
		else
			dk_error "$arg is invalid. Acceptable types are ( array, rtn_var )"
		fi
	done
	
}


alias dk_validateArgs='dkValidateArgs'


DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_todo
}
