#!/bin/sh
[ -z "${DKBASH_FUNCTIONS_DIR_-}" ] && DKBASH_FUNCTIONS_DIR_=../
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

################################################################################
# Test::test()
#
test() {
    dk_debugFunc 0
 
	echo "Inside Test::test.sh"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
    dk_call Test::test
}