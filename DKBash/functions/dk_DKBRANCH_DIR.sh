#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_DKBRANCH_DIR()
#
#
dk_DKBRANCH_DIR() {
	dk_debugFunc 0

	#[ -n "${DKBRANCH_DIR}" ] && return 0
	
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
	#dk_call dk_printVar DKBRANCH_DIR
	
		[ -z "${DK3RDPARTY_DIR-}" ] && export DK3RDPARTY_DIR="${DKBRANCH_DIR}/3rdParty"
		#dk_call dk_printVar DK3RDPARTY_DIR
			[ -z "${DKIMPORTS_DIR-}" ] && export DKIMPORTS_DIR="${DK3RDPARTY_DIR}/_DKIMPORTS"
			#dk_call dk_printVar DKIMPORTS_DIR
		
		[ -z "${DKAPPS_DIR-}" ] && export DKAPPS_DIR="${DKBRANCH_DIR}/DKApps"
		#dk_call dk_printVar DKAPPS_DIR
		
		[ -z "${DKBASH_DIR-}" ] && export DKBASH_DIR="${DKBRANCH_DIR}/DKBash"
		#dk_call dk_printVar DKBASH_DIR
			[ -z "${DKBASH_FUNCTIONS_DIR-}" ] && export DKBASH_FUNCTIONS_DIR="${DKBASH_DIR}/functions"
			#dk_call dk_printVar DKBASH_FUNCTIONS_DIR
			[ -z "${DKBASH_FUNCTIONS_DIR_-}" ] && export DKBASH_FUNCTIONS_DIR_="${DKBASH_DIR}/functions/"
			#dk_call dk_printVar DKBASH_FUNCTIONS_DIR_
			
		[ -z "${DKBATCH_DIR-}" ] && export DKBATCH_DIR="${DKBRANCH_DIR}/DKBatch"
		#dk_call dk_printVar DKBATCH_DIR
			[ -z "${DKBATCH_FUNCTIONS_DIR-}" ] && export DKBATCH_FUNCTIONS_DIR="${DKBATCH_DIR}/functions"
			#dk_call dk_printVar DKBATCH_FUNCTIONS_DIR
			[ -z "${DKBATCH_FUNCTIONS_DIR_-}" ] && export DKBATCH_FUNCTIONS_DIR_="${DKBATCH_DIR}/functions/"
			#dk_call dk_printVar DKBATCH_FUNCTIONS_DIR_
			
		[ -z "${DKC_DIR-}" ] && export DKC_DIR="${DKBRANCH_DIR}/DKC"
		#dk_call dk_printVar DKC_DIR
			[ -z "${DKC_FUNCTIONS_DIR-}" ] && export DKC_FUNCTIONS_DIR="${DKC_DIR}/functions"
			#dk_call dk_printVar DKC_FUNCTIONS_DIR
			[ -z "${DKC_FUNCTIONS_DIR_-}" ] && export DKC_FUNCTIONS_DIR_="${DKC_DIR}/functions/"
			#dk_call dk_printVar DKC_FUNCTIONS_DIR_
		
		[ -z "${DKCMAKE_DIR-}" ] && export DKCMAKE_DIR="${DKBRANCH_DIR}/DKCMake"
		#dk_call dk_printVar DKCMAKE_DIR
			[ -z "${DKCMAKE_FUNCTIONS_DIR-}" ] && export DKCMAKE_FUNCTIONS_DIR="${DKCMAKE_DIR}/functions"
			#dk_call dk_printVar DKCMAKE_FUNCTIONS_DIR
			[ -z "${DKCMAKE_FUNCTIONS_DIR_-}" ] && export DKCMAKE_FUNCTIONS_DIR_="${DKCMAKE_DIR}/functions/"
			#dk_call dk_printVar DKCMAKE_FUNCTIONS_DIR_
			
		[ -z "${DKCPP_DIR-}" ] && export DKCPP_DIR="${DKBRANCH_DIR}/DKCpp"
		#dk_call dk_printVar DKCPP_DIR
			[ -z "${DKCPP_FUNCTIONS_DIR-}" ] && export DKCPP_FUNCTIONS_DIR="${DKCPP_DIR}/functions"
			#dk_call dk_printVar DKCPP_FUNCTIONS_DIR
			[ -z "${DKCPP_FUNCTIONS_DIR_-}" ] && export DKCPP_FUNCTIONS_DIR_="${DKCPP_DIR}/functions/"
			#dk_call dk_printVar DKCPP_FUNCTIONS_DIR_
			
		[ -z "${DKCSHARP_DIR-}" ] && export DKCSHARP_DIR="${DKBRANCH_DIR}/DKCSharp"
		#dk_call dk_printVar DKCSHARP_DIR
			[ -z "${DKCSHARP_FUNCTIONS_DIR-}" ] && export DKCSHARP_FUNCTIONS_DIR="${DKCSHARP_DIR}/functions"
			#dk_call dk_printVar DKCSHARP_FUNCTIONS_DIR
			[ -z "${DKCSHARP_FUNCTIONS_DIR_-}" ] && export DKCSHARP_FUNCTIONS_DIR_="${DKCSHARP_DIR}/functions/"
			#dk_call dk_printVar DKCSHARP_FUNCTIONS_DIR_
			
		[ -z "${DKHTA_DIR-}" ] && export DKHTA_DIR="${DKBRANCH_DIR}/DKHta"
		#dk_call dk_printVar DKHTA_DIR
			[ -z "${DKHTA_FUNCTIONS_DIR-}" ] && export DKHTA_FUNCTIONS_DIR="${DKHTA_DIR}/functions"
			#dk_call dk_printVar DKHTA_FUNCTIONS_DIR
			[ -z "${DKHTA_FUNCTIONS_DIR_-}" ] && export DKHTA_FUNCTIONS_DIR_="${DKHTA_DIR}/functions/"
			#dk_call dk_printVar DKHTA_FUNCTIONS_DIR_
		
		[ -z "${DKHTML_DIR-}" ] && export DKHTML_DIR="${DKBRANCH_DIR}/DKHta"
		#dk_call dk_printVar DKHTML_DIR
			[ -z "${DKHTML_FUNCTIONS_DIR-}" ] && export DKHTML_FUNCTIONS_DIR="${DKHTML_DIR}/functions"
			#dk_call dk_printVar DKHTML_FUNCTIONS_DIR
			[ -z "${DKHTML_FUNCTIONS_DIR_-}" ] && export DKHTML_FUNCTIONS_DIR_="${DKHTML_DIR}/functions/"
			#dk_call dk_printVar DKHTML_FUNCTIONS_DIR_
		
		[ -z "${DKJAVA_DIR-}" ] && export DKJAVA_DIR="${DKBRANCH_DIR}/DKJava"
		#dk_call dk_printVar DKJAVA_DIR
			[ -z "${DKJAVA_FUNCTIONS_DIR-}" ] && export DKJAVA_FUNCTIONS_DIR="${DKJAVA_DIR}/functions"
			#dk_call dk_printVar DKJAVA_FUNCTIONS_DIR
			[ -z "${DKJAVA_FUNCTIONS_DIR_-}" ] && export DKJAVA_FUNCTIONS_DIR_="${DKJAVA_DIR}/functions/"
			#dk_call dk_printVar DKJAVA_FUNCTIONS_DIR_
		
		[ -z "${DKJAVASCRIPT_DIR-}" ] && export DKJAVASCRIPT_DIR="${DKBRANCH_DIR}/DKJavascript"
		#dk_call dk_printVar DKJAVASCRIPT_DIR
			[ -z "${DKJAVASCRIPT_FUNCTIONS_DIR-}" ] && export DKJAVASCRIPT_FUNCTIONS_DIR="${DKJAVASCRIPT_DIR}/functions"
			#dk_call dk_printVar DKJAVASCRIPT_FUNCTIONS_DIR
			[ -z "${DKJAVASCRIPT_FUNCTIONS_DIR_-}" ] && export DKJAVASCRIPT_FUNCTIONS_DIR_="${DKJAVASCRIPT_DIR}/functions/"
			#dk_call dk_printVar DKJAVASCRIPT_FUNCTIONS_DIR_
		
		[ -z "${DKPHP_DIR-}" ] && export DKPHP_DIR="${DKBRANCH_DIR}/DKPhp"
		#dk_call dk_printVar DKPHP_DIR
			[ -z "${DKPHP_FUNCTIONS_DIR-}" ] && export DKPHP_FUNCTIONS_DIR="${DKPHP_DIR}/functions"
			#dk_call dk_printVar DKPHP_FUNCTIONS_DIR
			[ -z "${DKPHP_FUNCTIONS_DIR_-}" ] && export DKPHP_FUNCTIONS_DIR_="${DKPHP_DIR}/functions/"
			#dk_call dk_printVar DKPHP_FUNCTIONS_DIR_
		
		[ -z "${DKPLUGINS_DIR-}" ] && export DKPLUGINS_DIR="${DKBRANCH_DIR}/DKPlugins"
		#dk_call dk_printVar DKPLUGINS_DIR
		
		[ -z "${DKPOWERSHELL_DIR-}" ] && export DKPOWERSHELL_DIR="${DKBRANCH_DIR}/DKPowershell"
		#dk_call dk_printVar DKPOWERSHELL_DIR
			[ -z "${DKPOWERSHELL_FUNCTIONS_DIR-}" ] && export DKPOWERSHELL_FUNCTIONS_DIR="${DKPOWERSHELL_DIR}/functions"
			#dk_call dk_printVar DKPOWERSHELL_FUNCTIONS_DIR
			[ -z "${DKPOWERSHELL_FUNCTIONS_DIR_-}" ] && export DKPOWERSHELL_FUNCTIONS_DIR_="${DKPOWERSHELL_DIR}/functions/"
			#dk_call dk_printVar DKPOWERSHELL_FUNCTIONS_DIR_
		
		[ -z "${DKPYTHON_DIR-}" ] && export DKPYTHON_DIR="${DKBRANCH_DIR}/DKPython"
		#dk_call dk_printVar DKPYTHON_DIR
			[ -z "${DKPYTHON_FUNCTIONS_DIR-}" ] && export DKPYTHON_FUNCTIONS_DIR="${DKPYTHON_DIR}/functions"
			#dk_call dk_printVar DKPYTHON_FUNCTIONS_DIR
			[ -z "${DKPYTHON_FUNCTIONS_DIR_-}" ] && export DKPYTHON_FUNCTIONS_DIR_="${DKPYTHON_DIR}/functions/"
			#dk_call dk_printVar DKPYTHON_FUNCTIONS_DIR_	
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_DKBRANCH_DIR
}
