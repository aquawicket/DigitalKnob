<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

################################################################################
# dk_getFileParam(file, var_name) value
#
# todo: add optional 3rd parameter for output value
dk_getFileParam() {
    dk_debugFunc 2
    
	 for line in $(cat "$1"); do
		 IFS='=' read -r A B <<< "$line"
		 # echo "$A = $B"
		 if [ "$A" == "$2" ]; then
			 unset "$2"
			 export "$2=$B"
		 fi
	 done
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
  
<<<<<<< HEAD
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKBRANCH_DIR"
    dk_call dk_getFileParam ${DKIMPORTS_DIR}/git/git.txt VERSION
	dk_call dk_printVar VERSION
=======
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
    dk_call dk_getFileParam ${DKIMPORTS_DIR}/git/dkconfig.txt GIT_DL_VERSION
	dk_call dk_printVar GIT_DL_VERSION
>>>>>>> Development
}
