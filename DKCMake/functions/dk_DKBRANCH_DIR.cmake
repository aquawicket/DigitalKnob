#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_DKBRANCH_DIR()
#
#
function(dk_DKBRANCH_DIR)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(DKBRANCH_DIR "${ARGV}")
		return()
	endif()
		
	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
	
	dk_set(DKBRANCH "Development")
	if(EXISTS "${DIGITALKNOB_DIR}/${DKBRANCH}/.git")
		# BRANCH="$(${GIT_EXE} rev-parse --abbrev-ref HEAD)"
		# If the current folder matches the current branch set DKBRANCH, otherwise default to Development
		dk_dirname(${CMAKE_CURRENT_LIST_DIR} CURRENT_FOLDER)
		if("${BRANCH}" STREQUAL "${CURRENT_FOLDER}")
			set(DKBRANCH "${CURRENT_FOLDER}")
		endif()
	endif()

	
	dk_set(DKBRANCH_DIR "${DIGITALKNOB_DIR}/${DKBRANCH}")
	set(ENV{DKBRANCH_DIR} "${DIGITALKNOB_DIR}/${DKBRANCH}")

		dk_set(DKBASH_DIR "${DKBRANCH_DIR}/DKBash")
		set(ENV{DKBASH_DIR} "${DKBRANCH_DIR}/DKBash")

			dk_set(DKBATCH_FUNCTIONS_DIR "${DKBASH_DIR}/functions")
			set(ENV{DKBATCH_FUNCTIONS_DIR} "${DKBASH_DIR}/functions")

			dk_set(DKBATCH_FUNCTIONS_DIR_ "${DKBATCH_FUNCTIONS_DIR}/")
			set(ENV{DKBATCH_FUNCTIONS_DIR_} "${DKBATCH_FUNCTIONS_DIR}/")
			
		
		dk_set(DKBATCH_DIR "${DKBRANCH_DIR}/DKBatch")
		set(ENV{DKBATCH_DIR} "${DKBRANCH_DIR}/DKBatch")

			dk_set(DKBATCH_FUNCTIONS_DIR "${DKBATCH_DIR}/functions")
			set(ENV{DKBATCH_FUNCTIONS_DIR} "${DKBATCH_DIR}/functions")

			dk_set(DKBATCH_FUNCTIONS_DIR_ "${DKBATCH_FUNCTIONS_DIR}/")
			set(ENV{DKBATCH_FUNCTIONS_DIR_} "${DKBATCH_FUNCTIONS_DIR}/")

		
		dk_set(DKC_DIR "${DKBRANCH_DIR}/DKC")
		set(ENV{DKC_DIR} "${DKBRANCH_DIR}/DKC")

			dk_set(DKC_FUNCTIONS_DIR "${DKC_DIR}/functions")
			set(ENV{DKC_FUNCTIONS_DIR} "${DKC_DIR}/functions")

			dk_set(DKC_FUNCTIONS_DIR_ "${DKC_FUNCTIONS_DIR}/")
			set(ENV{DKC_FUNCTIONS_DIR_} "${DKC_FUNCTIONS_DIR}/")

			
		dk_set(DKCMAKE_DIR "${DKBRANCH_DIR}/DKCMake")
		set(ENV{DKCMAKE_DIR} "${DKBRANCH_DIR}/DKCMake")

			dk_set(DKCMAKE_FUNCTIONS_DIR "${DKCMAKE_DIR}/functions")
			set(ENV{DKCMAKE_FUNCTIONS_DIR} "${DKCMAKE_DIR}/functions")

			#dk_set(DKCMAKE_FUNCTIONS_DIR_ "${DKCMAKE_FUNCTIONS_DIR}/")
			set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")

		
		dk_set(DKCPP_DIR "${DKBRANCH_DIR}/DKCpp")
		set(ENV{DKCPP_DIR} "${DKBRANCH_DIR}/DKCpp")
			dk_set(DKCPP_APPS_DIR "${DKCPP_DIR}/apps")
			set(ENV{DKCPP_APPS_DIR} "${DKCPP_DIR}/apps")
			
			dk_set(DKCPP_FUNCTIONS_DIR "${DKCPP_DIR}/functions")
			set(ENV{DKCPP_FUNCTIONS_DIR} "${DKCPP_DIR}/functions")

			dk_set(DKCPP_FUNCTIONS_DIR_ "${DKCPP_FUNCTIONS_DIR}/")
			set(ENV{DKCPP_FUNCTIONS_DIR_} "${DKCPP_FUNCTIONS_DIR}/")
			
			dk_set(DKCPP_PLUGINS_DIR "${DKCPP_DIR}/plugins")
			set(ENV{DKCPP_PLUGINS_DIR} "${DKCPP_DIR}/plugins")

			
		dk_set(DKCSHARP_DIR "${DKBRANCH_DIR}/DKCSharp")
		set(ENV{DKCSHARP_DIR} "${DKBRANCH_DIR}/DKCSharp")

			dk_set(DKCSHARP_FUNCTIONS_DIR "${DKCSHARP_DIR}/functions")
			set(ENV{DKCSHARP_FUNCTIONS_DIR} "${DKCSHARP_DIR}/functions")

			dk_set(DKCSHARP_FUNCTIONS_DIR_ "${DKCSHARP_FUNCTIONS_DIR}/")
			set(ENV{DKCSHARP_FUNCTIONS_DIR_} "${DKCSHARP_FUNCTIONS_DIR}/")

		
		dk_set(DKHTA_DIR "${DKBRANCH_DIR}/DKHta")
		set(ENV{DKHTA_DIR} "${DKBRANCH_DIR}/DKHta")

			dk_set(DKHTA_FUNCTIONS_DIR "${DKHTA_DIR}/functions")
			set(ENV{DKHTA_FUNCTIONS_DIR} "${DKHTA_DIR}/functions")

			dk_set(DKHTA_FUNCTIONS_DIR_ "${DKHTA_FUNCTIONS_DIR}/")
			set(ENV{DKHTA_FUNCTIONS_DIR_} "${DKHTA_FUNCTIONS_DIR}/")

			
		dk_set(DKHTML_DIR "${DKBRANCH_DIR}/DKHtml")
		set(ENV{DKHTML_DIR} "${DKBRANCH_DIR}/DKHtml")

			dk_set(DKHTML_FUNCTIONS_DIR "${DKHTML_DIR}/functions")
			set(ENV{DKHTML_FUNCTIONS_DIR} "${DKHTML_DIR}/functions")

			dk_set(DKHTML_FUNCTIONS_DIR_ "${DKHTML_FUNCTIONS_DIR}/")
			set(ENV{DKHTML_FUNCTIONS_DIR_} "${DKHTML_FUNCTIONS_DIR}/")

			
		dk_set(DKJAVA_DIR "${DKBRANCH_DIR}/DKJava")
		set(ENV{DKJAVA_DIR} "${DKBRANCH_DIR}/DKJava")

			dk_set(DKJAVA_FUNCTIONS_DIR "${DKJAVA_DIR}/functions")
			set(ENV{DKJAVA_FUNCTIONS_DIR} "${DKJAVA_DIR}/functions")

			dk_set(DKJAVA_FUNCTIONS_DIR_ "${DKJAVA_FUNCTIONS_DIR}/")
			set(ENV{DKJAVA_FUNCTIONS_DIR_} "${DKJAVA_FUNCTIONS_DIR}/")

			
		dk_set(DKJAVASCRIPT_DIR "${DKBRANCH_DIR}/DKJavascript")
		set(ENV{DKJAVASCRIPT_DIR} "${DKBRANCH_DIR}/DKJavascript")

			dk_set(DKJAVASCRIPT_FUNCTIONS_DIR "${DKJAVASCRIPT_DIR}/functions")
			set(ENV{DKJAVASCRIPT_FUNCTIONS_DIR} "${DKJAVASCRIPT_DIR}/functions")

			dk_set(DKJAVASCRIPT_FUNCTIONS_DIR_ "${DKJAVASCRIPT_FUNCTIONS_DIR}/")
			set(ENV{DKJAVASCRIPT_FUNCTIONS_DIR_} "${DKJAVASCRIPT_FUNCTIONS_DIR}/")

			
		dk_set(DKPHP_DIR "${DKBRANCH_DIR}/DKPhp")
		set(ENV{DKPHP_DIR} "${DKBRANCH_DIR}/DKPhp")

			dk_set(DKPHP_FUNCTIONS_DIR "${DKPHP_DIR}/functions")
			set(ENV{DKPHP_FUNCTIONS_DIR} "${DKPHP_DIR}/functions")

			dk_set(DKPHP_FUNCTIONS_DIR_ "${DKPHP_FUNCTIONS_DIR}/")
			set(ENV{DKPHP_FUNCTIONS_DIR_} "${DKPHP_FUNCTIONS_DIR}/")

			
		dk_set(DKPOWERSHELL_DIR "${DKBRANCH_DIR}/DKPowershell")
		set(ENV{DKPOWERSHELL_DIR} "${DKBRANCH_DIR}/DKPowershell")

			dk_set(DKPOWERSHELL_FUNCTIONS_DIR "${DKPOWERSHELL_DIR}/functions")
			set(ENV{DKPOWERSHELL_FUNCTIONS_DIR} "${DKPOWERSHELL_DIR}/functions")

			dk_set(DKPOWERSHELL_FUNCTIONS_DIR_ "${DKPOWERSHELL_FUNCTIONS_DIR}/")
			set(ENV{DKPOWERSHELL_FUNCTIONS_DIR_} "${DKPOWERSHELL_FUNCTIONS_DIR}/")

			
		dk_set(DKPYTHON_DIR "${DKBRANCH_DIR}/DKPython")
		set(ENV{DKPYTHON_DIR} "${DKBRANCH_DIR}/DKPython")

			dk_set(DKPYTHON_FUNCTIONS_DIR "${DKPYTHON_DIR}/functions")
			set(ENV{DKPYTHON_FUNCTIONS_DIR} "${DKPYTHON_DIR}/functions")

			dk_set(DKPYTHON_FUNCTIONS_DIR_ "${DKPYTHON_FUNCTIONS_DIR}/")
			set(ENV{DKPYTHON_FUNCTIONS_DIR_} "${DKPYTHON_FUNCTIONS_DIR}/")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("Test Getting DKBRANCH_DIR . . .")
	dk_DKBRANCH_DIR()
	dk_printVar(DKBRANCH_DIR)
	
	dk_echo()
	dk_echo("Test Setting DKBRANCH_DIR . . .")
	dk_DKBRANCH_DIR("C:/DK/Development")
	dk_printVar(DKBRANCH_DIR)
endfunction()
