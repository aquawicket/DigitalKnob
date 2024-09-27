#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_DKBRANCH_DIR()
#
#
function(dk_DKBRANCH_DIR)
	dk_debugFunc("\${ARGV}")
	
	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	dk_dirname(${CMAKE_CURRENT_LIST_DIR} FOLDER)
	dk_set(DKBRANCH "Development")
	
	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
	if(EXISTS "${DIGITALKNOB_DIR}/${DKBRANCH}/.git")
#		BRANCH="$(${GIT_EXE} rev-parse --abbrev-ref HEAD)"
#		if [ "${BRANCH}" = "${FOLDER}" ]; then
#			DKBRANCH="${FOLDER}"
#		fi
	endif()
	#dk_printVar(DKBRANCH)
	
	dk_set(DKBRANCH_DIR "${DIGITALKNOB_DIR}/${DKBRANCH}")
	set(ENV{DKBRANCH_DIR} "${DIGITALKNOB_DIR}/${DKBRANCH}")
		
		dk_set(DK3RDPARTY_DIR "${DKBRANCH_DIR}/3rdParty")
		set(ENV{DK3RDPARTY_DIR} "${DKBRANCH_DIR}/3rdParty")
			
			dk_set(DKIMPORTS_DIR "${DK3RDPARTY_DIR}/_DKIMPORTS")
			set(ENV{DKIMPORTS_DIR} "${DK3RDPARTY_DIR}/_DKIMPORTS")
		
		dk_set(DKAPPS_DIR "${DKBRANCH_DIR}/DKApps")
		set(ENV{DKAPPS_DIR} "${DKBRANCH_DIR}/DKApps")
		
		dk_set(DKBASH_DIR "${DKBRANCH_DIR}/DKBash")
		set(ENV{DKBASH_DIR} "${DKBRANCH_DIR}/DKBash")
			dk_set(DKBASH_FUNCTIONS_DIR "${DKBASH_DIR}/functions")
			set(ENV{DKBASH_FUNCTIONS_DIR} "${DKBASH_DIR}/functions")
			dk_set(DKBASH_FUNCTIONS_DIR_ "${DKBASH_DIR}/functions/")
			set(ENV{DKBASH_FUNCTIONS_DIR_} "${DKBASH_DIR}/functions/")
		
		dk_set(DKBATCH_DIR "${DKBRANCH_DIR}/DKBatch")
		set(ENV{DKBATCH_DIR} "${DKBRANCH_DIR}/DKBatch")
			dk_set(DKBATCH_FUNCTIONS_DIR "${DKBATCH_DIR}/functions")
			set(ENV{DKBATCH_FUNCTIONS_DIR} "${DKBATCH_DIR}/functions")
			dk_set(DKBATCH_FUNCTIONS_DIR_ "${DKBATCH_DIR}/functions/")
			set(ENV{DKBATCH_FUNCTIONS_DIR_} "${DKBATCH_DIR}/functions/")
		
		dk_set(DKC_DIR "${DKBRANCH_DIR}/DKC")
		set(ENV{DKC_DIR} "${DKBRANCH_DIR}/DKC")
			dk_set(DKC_FUNCTIONS_DIR "${DKC_DIR}/functions")
			set(ENV{DKC_FUNCTIONS_DIR} "${DKC_DIR}/functions")
			dk_set(DKC_FUNCTIONS_DIR_ "${DKC_DIR}/functions/")
			set(ENV{DKC_FUNCTIONS_DIR_} "${DKC_DIR}/functions/")
			
		dk_set(DKCMAKE_DIR "${DKBRANCH_DIR}/DKCMake")
		set(ENV{DKCMAKE_DIR} "${DKBRANCH_DIR}/DKCMake")
			dk_set(DKCMAKE_FUNCTIONS_DIR "${DKCMAKE_DIR}/functions")
			set(ENV{DKCMAKE_FUNCTIONS_DIR} "${DKCMAKE_DIR}/functions")
			dk_set(DKCMAKE_FUNCTIONS_DIR_ "${DKCMAKE_DIR}/functions/")
			set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_DIR}/functions/")
		
		dk_set(DKCPP_DIR "${DKBRANCH_DIR}/DKCpp")
		set(ENV{DKCPP_DIR} "${DKBRANCH_DIR}/DKCpp")
			dk_set(DKCPP_FUNCTIONS_DIR "${DKCPP_DIR}/functions")
			set(ENV{DKCPP_FUNCTIONS_DIR} "${DKCPP_DIR}/functions")
			dk_set(DKCPP_FUNCTIONS_DIR_ "${DKCPP_DIR}/functions/")
			set(ENV{DKCPP_FUNCTIONS_DIR_} "${DKCPP_DIR}/functions/")
			
		dk_set(DKCSHARP_DIR "${DKBRANCH_DIR}/DKCSharp")
		set(ENV{DKCSHARP_DIR} "${DKBRANCH_DIR}/DKCSharp")
			dk_set(DKCSHARP_FUNCTIONS_DIR "${DKCSHARP_DIR}/functions")
			set(ENV{DKCSHARP_FUNCTIONS_DIR} "${DKCSHARP_DIR}/functions")
			dk_set(DKCSHARP_FUNCTIONS_DIR_ "${DKCSHARP_DIR}/functions/")
			set(ENV{DKCSHARP_FUNCTIONS_DIR_} "${DKCSHARP_DIR}/functions/")
		
		dk_set(DKHTA_DIR "${DKBRANCH_DIR}/DKHta")
		set(ENV{DKHTA_DIR} "${DKBRANCH_DIR}/DKHta")
			dk_set(DKHTA_FUNCTIONS_DIR "${DKHTA_DIR}/functions")
			set(ENV{DKHTA_FUNCTIONS_DIR} "${DKHTA_DIR}/functions")
			dk_set(DKHTA_FUNCTIONS_DIR_ "${DKHTA_DIR}/functions/")
			set(ENV{DKHTA_FUNCTIONS_DIR_} "${DKHTA_DIR}/functions/")
			
		dk_set(DKHTML_DIR "${DKBRANCH_DIR}/DKHtml")
		set(ENV{DKHTML_DIR} "${DKBRANCH_DIR}/DKHtml")
			dk_set(DKHTML_FUNCTIONS_DIR "${DKHTML_DIR}/functions")
			set(ENV{DKHTML_FUNCTIONS_DIR} "${DKHTML_DIR}/functions")
			dk_set(DKHTML_FUNCTIONS_DIR_ "${DKHTML_DIR}/functions/")
			set(ENV{DKHTML_FUNCTIONS_DIR_} "${DKHTML_DIR}/functions/")
			
		dk_set(DKJAVA_DIR "${DKBRANCH_DIR}/DKJava")
		set(ENV{DKJAVA_DIR} "${DKBRANCH_DIR}/DKJava")
			dk_set(DKJAVA_FUNCTIONS_DIR "${DKJAVA_DIR}/functions")
			set(ENV{DKJAVA_FUNCTIONS_DIR} "${DKJAVA_DIR}/functions")
			dk_set(DKJAVA_FUNCTIONS_DIR_ "${DKJAVA_DIR}/functions/")
			set(ENV{DKJAVA_FUNCTIONS_DIR_} "${DKJAVA_DIR}/functions/")
			
		dk_set(DKJAVASCRIPT_DIR "${DKBRANCH_DIR}/DKJavascript")
		set(ENV{DKJAVASCRIPT_DIR} "${DKBRANCH_DIR}/DKJavascript")
			dk_set(DKJAVASCRIPT_FUNCTIONS_DIR "${DKJAVASCRIPT_DIR}/functions")
			set(ENV{DKJAVASCRIPT_FUNCTIONS_DIR} "${DKJAVASCRIPT_DIR}/functions")
			dk_set(DKJAVASCRIPT_FUNCTIONS_DIR_ "${DKJAVASCRIPT_DIR}/functions/")
			set(ENV{DKJAVASCRIPT_FUNCTIONS_DIR_} "${DKJAVASCRIPT_DIR}/functions/")
			
		dk_set(DKPHP_DIR "${DKBRANCH_DIR}/DKJavascript")
		set(ENV{DKPHP_DIR} "${DKBRANCH_DIR}/DKJavascript")
			dk_set(DKPHP_FUNCTIONS_DIR "${DKPHP_DIR}/functions")
			set(ENV{DKPHP_FUNCTIONS_DIR} "${DKPHP_DIR}/functions")
			dk_set(DKPHP_FUNCTIONS_DIR_ "${DKPHP_DIR}/functions/")
			set(ENV{DKPHP_FUNCTIONS_DIR_} "${DKPHP_DIR}/functions/")
			
		dk_set(DKPLUGINS_DIR "${DKBRANCH_DIR}/DKPlugins")
		set(ENV{DKPLUGINS_DIR} "${DKBRANCH_DIR}/DKPlugins")
		
		dk_set(DKPOWERSHELL_DIR "${DKBRANCH_DIR}/DKPowershell")
		set(ENV{DKPOWERSHELL_DIR} "${DKBRANCH_DIR}/DKPowershell")
			dk_set(DKPOWERSHELL_FUNCTIONS_DIR "${DKPOWERSHELL_DIR}/functions")
			set(ENV{DKPOWERSHELL_FUNCTIONS_DIR} "${DKPOWERSHELL_DIR}/functions")
			dk_set(DKPOWERSHELL_FUNCTIONS_DIR_ "${DKPOWERSHELL_DIR}/functions/")
			set(ENV{DKPOWERSHELL_FUNCTIONS_DIR_} "${DKPOWERSHELL_DIR}/functions/")
			
		dk_set(DKPYTHON_DIR "${DKBRANCH_DIR}/DKPowershell")
		set(ENV{DKPYTHON_DIR} "${DKBRANCH_DIR}/DKPowershell")
			dk_set(DKPYTHON_FUNCTIONS_DIR "${DKPYTHON_DIR}/functions")
			set(ENV{DKPYTHON_FUNCTIONS_DIR} "${DKPYTHON_DIR}/functions")
			dk_set(DKPYTHON_FUNCTIONS_DIR_ "${DKPYTHON_DIR}/functions/")
			set(ENV{DKPYTHON_FUNCTIONS_DIR_} "${DKPYTHON_DIR}/functions/")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_DKBRANCH_DIR()
endfunction()
