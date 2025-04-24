<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

################################################################################
# dk_logo()
#
dk_logo() {
	dk_debugFunc 0
<<<<<<< HEAD
	
	
	echo "${lblue-}   ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______     "
	echo "${lblue-}   |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____]    "
	echo "${blue-}   |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]     "
    echo "${magenta-}                                                                    __     __         "
    echo "${magenta-}                                                                   |  \|_/|__) _  _|_ "
    echo "${magenta-}                                                                   |__/| \|__)(_|_)| )"
    echo "${clr-}"                     
     
=======


	echo    "${lblue-} ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______ "
	echo    "${lblue-} |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____]"
	echo     "${blue-} |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]"
	echo "${lmagenta-}                                                               __     __          "
	echo "${lmagenta-}                                                              |  \|_/|__) _  _|_  "
	echo  "${magenta-}                                                              |__/| \|__)(_|_)| ) "
	echo      "${clr-}"
>>>>>>> Development
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
<<<<<<< HEAD
	
=======

>>>>>>> Development
	dk_logo
}
