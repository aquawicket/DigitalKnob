#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_debugFunc()
#
#

#alias dk_debugFunc='{
#	[ ${ENABLE_dk_debugFunc-0} -eq 1 ] && echo "${Blue-}$(__FILE__ 1):$(__LINE__ 1)  ${blue-}$(__FUNCTION__ 1)($(__ARGV__ 1))${clr-}"
#}'

alias dk_debugFunc='{
	if [ ${ENABLE_dk_debugFunc-0} -eq 1 ]; then
		if [ "$(echo -e)" = "" ]; then
			echo -e "${Blue-}$(__FILE__ 1):$(__LINE__ 1)  ${blue-}$(__FUNCTION__ 1)($(__ARGV__ 1))${clr-}"
		else
			echo "${Blue-}$(__FILE__ 1):$(__LINE__ 1)  ${blue-}$(__FUNCTION__ 1)($(__ARGV__ 1))${clr-}"
		fi
	fi
}'


DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	main () {
		dk_debugFunc
		func1 1 "2" '3'
	}

	func1 () {
		dk_debugFunc
	}
		

	ENABLE_dk_debugFunc=1
	main
}