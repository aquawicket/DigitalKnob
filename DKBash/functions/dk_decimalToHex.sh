<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

####################################################################
# dk_decimalToHex(<decimal> hex)
#
#    reference: https://www.ascii-code.com
#
dk_decimalToHex() {
	dk_debugFunc 2

	dk_call dk_todo
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	myDecimal="45"
	dk_call dk_decimalToHex "${myDecimal}" myHex
	dk_call dk_printVar myHex
}
