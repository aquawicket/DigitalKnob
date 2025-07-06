#!/usr/bin/env bash
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_createSymlink(src_path, symlink_path)
#
#
dk_createSymlink() {
	dk_debugFunc 2
	echo "dk_createSymlink($*)"
	
	[ ! -e ${1} ] && (dk_call dk_error "${1} does not exist"; return)
	[ -e ${2} ] && (dk_call dk_error "${2} already exists"; return)
	dk_call dk_basename ${2}
	[ ! -e ${dk_basename} ] && (dk_call dk_error "${dk_basename} not found" & return)
	
	LN_EXE=$(command -v ln)
	${LN_EXE} -s ${1} ${2}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	### Create a directory symlink ###
    dk_call dk_createSymlink "${DKHOME_DIR}/DigitalKnob" "${DKHOME_DIR}/Desktop/DigitalKnob"
	
	### Create a file symlink ###
	#dk_call dk_createSymlink "${DKHOME_DIR}/DigitalKnob/Development/DKBatch/apps/DKBuilder/DKBuilder.sh" "${DKHOME_DIR}/Desktop/DKBuilder.sh" # OVERWRITE
	
	### Test Non-Existent Error ###
    #dk_call dk_createSymlink "${DKHOME_DIR}/Non-Existent" "${DKHOME_DIR}/Desktop/Non-Existent" 
}
