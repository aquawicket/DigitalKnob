#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard

[ -z $ENABLE_dk_debugFunc ] && ENABLE_dk_debugFunc=0
##################################################################################
# dk_debugFunc()
#
#
alias dk_debugFunc='{
	if [ $ENABLE_dk_debugFunc -eq 1 ]; then
		if [ "$(echo -e)" = "" ]; then
			echo -e "$(basename ${BASH_SOURCE[1]}:${BASH_LINENO[0]}) ${blue}${FUNCNAME[0]}($*)${clr}"
		else
			echo "$(basename ${BASH_SOURCE[1]}:${BASH_LINENO[0]}) ${blue}${FUNCNAME[0]}($*)${clr}"
		fi
	fi
}'




################################ DKTEST #########################################
main () {
	dk_debugFunc
	
	func1 1 "2" '3'
}

func1 () {
	dk_debugFunc
}
	
DKTEST () {
	ENABLE_dk_debugFunc=1
	
	#clear
	dk_debugFunc
	main
	
	exec $SHELL	
}
[ -n "$DKTEST" ] && DKTEST