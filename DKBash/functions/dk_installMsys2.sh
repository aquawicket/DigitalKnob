<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development


##################################################################################
# dk_installMsys2()
#
#
dk_installMsys2() {
	dk_debugFunc 0


<<<<<<< HEAD
	dk_cmakeEval "include('${DKIMPORTS_DIR}/msys2/DKMAKE.cmake')" "MSYS2"
=======
	dk_cmakeEval "include('${DKIMPORTS_DIR}/msys2/DKINSTALL.cmake')" "MSYS2"
>>>>>>> Development
	dk_printVar MSYS2
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_installMsys2
}