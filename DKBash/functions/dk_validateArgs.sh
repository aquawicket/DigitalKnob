#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


###############################################################################
# dkValidateArgs(...)
#
dkValidateArgs() {
	dk_debugFunc
	echo -e "$(__FILE__ 2):$(__LINE__ 2)  $(__FUNCTION__ 2)($(__ARGC__ 2):$(__ARGV__ 2))"
}


alias dk_validateArgs='dkValidateArgs'


DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_todo
}
