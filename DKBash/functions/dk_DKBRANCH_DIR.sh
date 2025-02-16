#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_DKBRANCH_DIR()
#
#
dk_DKBRANCH_DIR() {
	dk_debugFunc 0 1

	#[ -n "${DKBRANCH_DIR}" ] && return 0
	
	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKBRANCH_DIR="${1}" 
	
	############ GET ############
	else
		# If the current folder matches the current branch set DKBRANCH, default to Development
		FOLDER="$(dk_call dk_basename $(pwd))"
		[ -z "${DKBRANCH-}" ] && export DKBRANCH="Development"
		
		dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR"
		if dk_call dk_pathExists "${DIGITALKNOB_DIR}"/"${FOLDER}"/.git; then
			dk_call dk_validate GIT_EXE "dk_call dk_installGit"
			branch="$(${GIT_EXE} rev-parse --abbrev-ref HEAD)"
			if [ "${branch}" = "${FOLDER}" ]; then
				[ -z "${DKBRANCH-}" ] && export DKBRANCH="${FOLDER}"
			fi
		fi
		#dk_call dk_printVar DKBRANCH
		
		[ -z "${DKBRANCH_DIR-}" ] && export DKBRANCH_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}"
	

		
		[ -z "${DKBASH_DIR-}" ] && export DKBASH_DIR="${DKBRANCH_DIR}/DKBash"
			[ -z "${DKBASH_FUNCTIONS_DIR-}" ] && export DKBASH_FUNCTIONS_DIR="${DKBASH_DIR}/functions"
			[ -z "${DKBASH_FUNCTIONS_DIR_-}" ] && export DKBASH_FUNCTIONS_DIR_="${DKBASH_FUNCTIONS_DIR}/"
			
		[ -z "${DKBATCH_DIR-}" ] && export DKBATCH_DIR="${DKBRANCH_DIR}/DKBatch"
			[ -z "${DKBATCH_FUNCTIONS_DIR-}" ] && export DKBATCH_FUNCTIONS_DIR="${DKBATCH_DIR}/functions"
			[ -z "${DKBATCH_FUNCTIONS_DIR_-}" ] && export DKBATCH_FUNCTIONS_DIR_="${DKBATCH_FUNCTIONS_DIR}/"
			
		[ -z "${DKC_DIR-}" ] && export DKC_DIR="${DKBRANCH_DIR}/DKC"
			[ -z "${DKC_FUNCTIONS_DIR-}" ] && export DKC_FUNCTIONS_DIR="${DKC_DIR}/functions"
			[ -z "${DKC_FUNCTIONS_DIR_-}" ] && export DKC_FUNCTIONS_DIR_="${DKC_FUNCTIONS_DIR}/"
		
		[ -z "${DKCMAKE_DIR-}" ] && export DKCMAKE_DIR="${DKBRANCH_DIR}/DKCMake"
			[ -z "${DKCMAKE_FUNCTIONS_DIR-}" ] && export DKCMAKE_FUNCTIONS_DIR="${DKCMAKE_DIR}/functions"
			[ -z "${DKCMAKE_FUNCTIONS_DIR_-}" ] && export DKCMAKE_FUNCTIONS_DIR_="${DKCMAKE_FUNCTIONS_DIR}/"
			
		[ -z "${DKCPP_DIR-}" ] && export DKCPP_DIR="${DKBRANCH_DIR}/DKCpp"
			[ -z "${DKCPP_APPS_DIR-}" ] && export DKCPP_APPS_DIR="${DKCPP_DIR}/apps"	
			[ -z "${DKCPP_FUNCTIONS_DIR-}" ] && export DKCPP_FUNCTIONS_DIR="${DKCPP_DIR}/functions"
			[ -z "${DKCPP_FUNCTIONS_DIR_-}" ] && export DKCPP_FUNCTIONS_DIR_="${DKCPP_FUNCTIONS_DIR}/"
			
		[ -z "${DKCSHARP_DIR-}" ] && export DKCSHARP_DIR="${DKBRANCH_DIR}/DKCSharp"
			[ -z "${DKCSHARP_FUNCTIONS_DIR-}" ] && export DKCSHARP_FUNCTIONS_DIR="${DKCSHARP_DIR}/functions"
			[ -z "${DKCSHARP_FUNCTIONS_DIR_-}" ] && export DKCSHARP_FUNCTIONS_DIR_="${DKCSHARP_FUNCTIONS_DIR}/"
			
		[ -z "${DKHTA_DIR-}" ] && export DKHTA_DIR="${DKBRANCH_DIR}/DKHta"
			[ -z "${DKHTA_FUNCTIONS_DIR-}" ] && export DKHTA_FUNCTIONS_DIR="${DKHTA_DIR}/functions"
			[ -z "${DKHTA_FUNCTIONS_DIR_-}" ] && export DKHTA_FUNCTIONS_DIR_="${DKHTA_FUNCTIONS_DIR}/"
		
		[ -z "${DKHTML_DIR-}" ] && export DKHTML_DIR="${DKBRANCH_DIR}/DKHta"
			[ -z "${DKHTML_FUNCTIONS_DIR-}" ] && export DKHTML_FUNCTIONS_DIR="${DKHTML_DIR}/functions"
			[ -z "${DKHTML_FUNCTIONS_DIR_-}" ] && export DKHTML_FUNCTIONS_DIR_="${DKHTML_FUNCTIONS_DIR}/"
		
		[ -z "${DKJAVA_DIR-}" ] && export DKJAVA_DIR="${DKBRANCH_DIR}/DKJava"
			[ -z "${DKJAVA_FUNCTIONS_DIR-}" ] && export DKJAVA_FUNCTIONS_DIR="${DKJAVA_DIR}/functions"
			[ -z "${DKJAVA_FUNCTIONS_DIR_-}" ] && export DKJAVA_FUNCTIONS_DIR_="${DKJAVA_FUNCTIONS_DIR}/"
		
		[ -z "${DKJAVASCRIPT_DIR-}" ] && export DKJAVASCRIPT_DIR="${DKBRANCH_DIR}/DKJavascript"
			[ -z "${DKJAVASCRIPT_FUNCTIONS_DIR-}" ] && export DKJAVASCRIPT_FUNCTIONS_DIR="${DKJAVASCRIPT_DIR}/functions"
			[ -z "${DKJAVASCRIPT_FUNCTIONS_DIR_-}" ] && export DKJAVASCRIPT_FUNCTIONS_DIR_="${DKJAVASCRIPT_FUNCTIONS_DIR}/"
		
		[ -z "${DKPHP_DIR-}" ] && export DKPHP_DIR="${DKBRANCH_DIR}/DKPhp"
			[ -z "${DKPHP_FUNCTIONS_DIR-}" ] && export DKPHP_FUNCTIONS_DIR="${DKPHP_DIR}/functions"
			[ -z "${DKPHP_FUNCTIONS_DIR_-}" ] && export DKPHP_FUNCTIONS_DIR_="${DKPHP_FUNCTIONS_DIR}/"
		
#		[ -z "${DKPLUGINS_DIR-}" ] && export DKPLUGINS_DIR="${DKBRANCH_DIR}/DKPlugins"
		
		[ -z "${DKPOWERSHELL_DIR-}" ] && export DKPOWERSHELL_DIR="${DKBRANCH_DIR}/DKPowershell"
			[ -z "${DKPOWERSHELL_FUNCTIONS_DIR-}" ] && export DKPOWERSHELL_FUNCTIONS_DIR="${DKPOWERSHELL_DIR}/functions"
			[ -z "${DKPOWERSHELL_FUNCTIONS_DIR_-}" ] && export DKPOWERSHELL_FUNCTIONS_DIR_="${DKPOWERSHELL_FUNCTIONS_DIR}/"
		
		[ -z "${DKPYTHON_DIR-}" ] && export DKPYTHON_DIR="${DKBRANCH_DIR}/DKPython"
			[ -z "${DKPYTHON_FUNCTIONS_DIR-}" ] && export DKPYTHON_FUNCTIONS_DIR="${DKPYTHON_DIR}/functions"
			[ -z "${DKPYTHON_FUNCTIONS_DIR_-}" ] && export DKPYTHON_FUNCTIONS_DIR_="${DKPYTHON_FUNCTIONS_DIR}/"
	fi
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKBRANCH_DIR . . ."
	dk_call dk_DKBRANCH_DIR
	dk_call dk_printVar DKBRANCH_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKBRANCH_DIR . . ."
	dk_call dk_DKBRANCH_DIR "/C/DK/Development"
	dk_call dk_printVar DKBRANCH_DIR 
}
