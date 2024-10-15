#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

################################################################################
# dk_logo()
#
dk_logo() {
	dk_debugFunc 0
	
	
	echo "${lblue-}   ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______     "
	echo "${lblue-}   |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____]    "
	echo "${blue-}   |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]     "
    echo "${magenta-}                                                                    __     __         "
    echo "${magenta-}                                                                   |  \|_/|__) _  _|_ "
    echo "${magenta-}                                                                   |__/| \|__)(_|_)| )"
    echo "${clr-}"                     
     
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_logo
}
