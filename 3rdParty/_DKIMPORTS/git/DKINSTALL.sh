#!/usr/bin/env bash
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
if [ ! -e "${DKIMPORTS_DIR}/git/dkconfig.txt" ];then
	dk_call dk_download "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt"  "${DKIMPORTS_DIR}/git/dkconfig.txt"
fi
dk_call dk_getFileParams "${DKIMPORTS_DIR}/git/dkconfig.txt"


#:: https://stackoverflow.com/a/67714373
dk_call dk_validate DKCACHE_DIR "dk_call dk_DKCACHE_DIR"
[ -z "${GIT_CONFIG_SYSTEM-}" ] && export GIT_CONFIG_SYSTEM="${DKCACHE_DIR}/.gitSystem"
[ -z "${GIT_CONFIG_GLOBAL-}" ] && export GIT_CONFIG_GLOBAL="${DKCACHE_DIR}/.gitGlobal"

####################################################################
# DKINSTALL
#
DKINSTALL() {
	#dk_call dk_debugFunc 0	
	#echo "DKINSTALL($*)"
	
	dk_call dk_validate Host_Tuple "dk_call dk_Host_Tuple"

	GIT_IMPORT_VAR="Git_${Host_Tuple}_Import"
	export GIT_IMPORT="${!GIT_IMPORT_VAR}"
    dk_call dk_assertVar GIT_IMPORT
  
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
	#[ -z "${GIT-}" ] && dk_call dk_importVariables ${GIT_IMPORT} NAME git ROOT ${DKTOOLS_DIR}
	[ -z "${GIT-}" ] && dk_call dk_importVariables ${GIT_IMPORT} ROOT ${DKTOOLS_DIR}
	dk_call dk_assertVar GIT
	
	# https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	############ DO NOT USE GIT_DIR ############
	[ -n "${GIT_DIR-}" ] && dk_call dk_fatal "ERROR: GIT_DIR should not be set."   # https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	############ DO NOT USE GIT_DIR ############
	
    export GIT_EXE="${GIT}/bin/git.exe"
	export GIT_BASH_EXE="${GIT}/bin/bash.exe"
    # export GIT-BASH_EXE="${GIT}/git-bash.exe"
	# export GIT_PATCH_EXE="${GIT}/usr/bin/patch.exe"
    [ -e "${GIT_EXE}" ] && return
	
	###### INSTALL ######
    dk_call dk_echo 
    dk_call dk_info "Installing git . . ."
	dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
    dk_call dk_download ${GIT_IMPORT}
    "${DKDOWNLOAD_DIR}/${GIT_IMPORT_FILE}" -y -o "${GIT}"
	
    ###### Install Git Context Menu ######
    #dk_call dk_depend git/contextMenu  
	 
    [ ! -e "${GIT_EXE}" ] && dk_call dk_error "cannot find git"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_call dk_debugFunc 0

	dk_call DKINSTALL
	dk_call dk_echo "GIT = ${GIT}"
	dk_call dk_echo "GIT_EXE = ${GIT_EXE}"
}
