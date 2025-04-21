#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_createSymlink(src_path, symlink_path)
#
#
dk_createSymlink() {
	dk_debugFunc 2
	
	[ ! -e ${1} ] && dk_call dk_error "${1} does not exist" & return
	[ -e ${2} ] && dk_call dk_error "${2} already exists" & return
	dk_call dk_basename ${2}
	[ ! -e ${dk_basename} ] && dk_error "${dk_basename} not found" & return
	
	LN_EXE=$(command -v ln)
	${LN_EXE} -s ${1} ${2}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	### Create a directory symlink ###
    dk_call dk_createSymlink "${DKHOME_DIR}/digitalknob" "${DKHOME_DIR}/Desktop/digitalknob"
	
	### Create a file symlink ###
	dk_call dk_createSymlink "${DKHOME_DIR}/digitalknob/Development/DKBatch/apps/DKBuilder/DKBuilder.sh" "${DKHOME_DIR}/Desktop/DKBuilder.sh" &rem OVERWRITE
	
	### Test Non-Existent Error ###
    dk_call dk_createSymlink "${DKHOME_DIR}/Non-Existent" "${DKHOME_DIR}/Desktop/Non-Existent" 
}
