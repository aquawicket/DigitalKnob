#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_DKBRANCH_DIR()
#
#
dk_DKBRANCH_DIR() {
	dk_debugFunc 0

	#[ -n "${DKBRANCH_DIR}" ] && return 0
	
	# If the current folder matches the current branch set DKBRANCH, default to Development
	FOLDER="$(dk_call dk_basename $(pwd))"
	DKBRANCH="Development"
	
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR"
	if dk_call dk_pathExists "${DIGITALKNOB_DIR}"/"${FOLDER}"/.git; then
		BRANCH="$(${GIT_EXE} rev-parse --abbrev-ref HEAD)"
		if [ "${BRANCH}" = "${FOLDER}" ]; then
			DKBRANCH="${FOLDER}"
		fi
	fi
	dk_call dk_printVar DKBRANCH
	
	DKBRANCH_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}"
	dk_call dk_printVar DKBRANCH_DIR
	
		DK3RDPARTY_DIR="${DKBRANCH_DIR}/3rdParty"
		dk_call dk_printVar DK3RDPARTY_DIR
			DKIMPORTS_DIR="${DK3RDPARTY_DIR}/_DKIMPORTS"
			dk_call dk_printVar DKIMPORTS_DIR
		
		export DKAPPS_DIR="${DKBRANCH_DIR}/DKApps"
		dk_call dk_printVar DKAPPS_DIR
		
		DKBASH_DIR="${DKBRANCH_DIR}/DKBash"
		dk_call dk_printVar DKBASH_DIR
			DKBASH_FUNCTIONS_DIR="${DKBASH_DIR}/functions"
			dk_call dk_printVar DKBASH_FUNCTIONS_DIR
			DKBASH_FUNCTIONS_DIR_="${DKBASH_DIR}/functions/"
			dk_call dk_printVar DKBASH_FUNCTIONS_DIR_
			
		DKBATCH_DIR="${DKBRANCH_DIR}/DKBatch"
		dk_call dk_printVar DKBATCH_DIR
			DKBATCH_FUNCTIONS_DIR="${DKBATCH_DIR}/functions"
			dk_call dk_printVar DKBATCH_FUNCTIONS_DIR
			DKBATCH_FUNCTIONS_DIR_="${DKBATCH_DIR}/functions/"
			dk_call dk_printVar DKBATCH_FUNCTIONS_DIR_
			
		DKC_DIR="${DKBRANCH_DIR}/DKC"
		dk_call dk_printVar DKC_DIR
			DKC_FUNCTIONS_DIR="${DKC_DIR}/functions"
			dk_call dk_printVar DKC_FUNCTIONS_DIR
			DKC_FUNCTIONS_DIR_="${DKC_DIR}/functions/"
			dk_call dk_printVar DKC_FUNCTIONS_DIR_
		
		DKCMAKE_DIR="${DKBRANCH_DIR}/DKCMake"
		dk_call dk_printVar DKCMAKE_DIR
			DKCMAKE_FUNCTIONS_DIR="${DKCMAKE_DIR}/functions"
			dk_call dk_printVar DKCMAKE_FUNCTIONS_DIR
			DKCMAKE_FUNCTIONS_DIR_="${DKCMAKE_DIR}/functions/"
			dk_call dk_printVar DKCMAKE_FUNCTIONS_DIR_
			
		DKCPP_DIR="${DKBRANCH_DIR}/DKCpp"
		dk_call dk_printVar DKCPP_DIR
			DKCPP_FUNCTIONS_DIR="${DKCPP_DIR}/functions"
			dk_call dk_printVar DKCPP_FUNCTIONS_DIR
			DKCPP_FUNCTIONS_DIR_="${DKCPP_DIR}/functions/"
			dk_call dk_printVar DKCPP_FUNCTIONS_DIR_
			
		DKCSHARP_DIR="${DKBRANCH_DIR}/DKCSharp"
		dk_call dk_printVar DKCSHARP_DIR
			DKCSHARP_FUNCTIONS_DIR="${DKCSHARP_DIR}/functions"
			dk_call dk_printVar DKCSHARP_FUNCTIONS_DIR
			DKCSHARP_FUNCTIONS_DIR_="${DKCSHARP_DIR}/functions/"
			dk_call dk_printVar DKCSHARP_FUNCTIONS_DIR_
			
		DKHTA_DIR="${DKBRANCH_DIR}/DKHta"
		dk_call dk_printVar DKHTA_DIR
			DKHTA_FUNCTIONS_DIR="${DKHTA_DIR}/functions"
			dk_call dk_printVar DKHTA_FUNCTIONS_DIR
			DKHTA_FUNCTIONS_DIR_="${DKHTA_DIR}/functions/"
			dk_call dk_printVar DKHTA_FUNCTIONS_DIR_
		
		DKHTML_DIR="${DKBRANCH_DIR}/DKHta"
		dk_call dk_printVar DKHTML_DIR
			DKHTML_FUNCTIONS_DIR="${DKHTML_DIR}/functions"
			dk_call dk_printVar DKHTML_FUNCTIONS_DIR
			DKHTML_FUNCTIONS_DIR_="${DKHTML_DIR}/functions/"
			dk_call dk_printVar DKHTML_FUNCTIONS_DIR_
		
		DKJAVA_DIR="${DKBRANCH_DIR}/DKJava"
		dk_call dk_printVar DKJAVA_DIR
			DKJAVA_FUNCTIONS_DIR="${DKJAVA_DIR}/functions"
			dk_call dk_printVar DKJAVA_FUNCTIONS_DIR
			DKJAVA_FUNCTIONS_DIR_="${DKJAVA_DIR}/functions/"
			dk_call dk_printVar DKJAVA_FUNCTIONS_DIR_
		
		DKJAVASCRIPT_DIR="${DKBRANCH_DIR}/DKJavascript"
		dk_call dk_printVar DKJAVASCRIPT_DIR
			DKJAVASCRIPT_FUNCTIONS_DIR="${DKJAVASCRIPT_DIR}/functions"
			dk_call dk_printVar DKJAVASCRIPT_FUNCTIONS_DIR
			DKJAVASCRIPT_FUNCTIONS_DIR_="${DKJAVASCRIPT_DIR}/functions/"
			dk_call dk_printVar DKJAVASCRIPT_FUNCTIONS_DIR_
		
		DKPHP_DIR="${DKBRANCH_DIR}/DKPhp"
		dk_call dk_printVar DKPHP_DIR
			DKPHP_FUNCTIONS_DIR="${DKPHP_DIR}/functions"
			dk_call dk_printVar DKPHP_FUNCTIONS_DIR
			DKPHP_FUNCTIONS_DIR_="${DKPHP_DIR}/functions/"
			dk_call dk_printVar DKPHP_FUNCTIONS_DIR_
			
		DKPOWERSHELL_DIR="${DKBRANCH_DIR}/DKPowershell"
		dk_call dk_printVar DKPOWERSHELL_DIR
			DKPOWERSHELL_FUNCTIONS_DIR="${DKPOWERSHELL_DIR}/functions"
			dk_call dk_printVar DKPOWERSHELL_FUNCTIONS_DIR
			DKPOWERSHELL_FUNCTIONS_DIR_="${DKPOWERSHELL_DIR}/functions/"
			dk_call dk_printVar DKPOWERSHELL_FUNCTIONS_DIR_
		
		DKPYTHON_DIR="${DKBRANCH_DIR}/DKPython"
		dk_call dk_printVar DKPYTHON_DIR
			DKPYTHON_FUNCTIONS_DIR="${DKPYTHON_DIR}/functions"
			dk_call dk_printVar DKPYTHON_FUNCTIONS_DIR
			DKPYTHON_FUNCTIONS_DIR_="${DKPYTHON_DIR}/functions/"
			dk_call dk_printVar DKPYTHON_FUNCTIONS_DIR_
			
		DKPLUGINS_DIR="${DKBRANCH_DIR}/DKPlugins"
		dk_call dk_printVar DKPLUGINS_DIR
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_DKBRANCH_DIR
}
