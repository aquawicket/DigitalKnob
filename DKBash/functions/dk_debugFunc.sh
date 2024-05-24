#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


[ -z ${ENABLE_dk_debugFunc-} ] && export ENABLE_dk_debugFunc=1
##################################################################################
# dk_debugFunc()
#
#
alias dk_debugFunc='{
	if [ ${ENABLE_dk_debugFunc} -eq 1 ]; then
	
		_FRAME_=1
		if [ "$(echo -e)" = "" ]; then
			echo -e "${Blue-}$(__FILE__):$(__LINE__)  ${blue-}$(__FUNCTION__)($(__ARGV__))${clr-}"
		else
			echo "${Blue-}$(__FILE__):$(__LINE__)  ${blue-}$(__FUNCTION__)($(__ARGV__))${clr-}"
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