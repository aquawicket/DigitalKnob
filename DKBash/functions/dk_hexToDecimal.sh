#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


####################################################################
# dk_hexToDecimal(<hex> <OUTPUT>)
#
#    reference: https://www.ascii-code.com
#               https://stackoverflow.com/a/13280173
#
dk_hexToDecimal () {
	dk_debugFunc
	
	#hex=$1
	#decimal=$(printf "%d\n" $hex)
	
	#echo     dk_hexToDecimal $hex = $decimal
	#eval "$2=$decimal"
	
	eval "$2=$(printf "%d\n" $1)"
}






################################ DKTEST #########################################
DKTEST () {

	dk_hexToDecimal 0x1b decimal
	dk_debug decimal

	exec $SHELL
}
[ -n "$DKTEST" ] && DKTEST


