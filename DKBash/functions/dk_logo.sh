#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_logo()
#
dk_logo (){
	dk_debugFunc
	
	
	echo "${lblue-}   ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______     "
	echo "${lblue-}   |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____]    "
	echo "${blue-}   |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]     "
    echo "${magenta-}                                                                    __     __         "
    echo "${magenta-}                                                                   |  \|_/|__) _  _|_ "
    echo "${magenta-}                                                                   |__/| \|__)(_|_)| )"
    echo "${clr-}"                     
     
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_logo
}
