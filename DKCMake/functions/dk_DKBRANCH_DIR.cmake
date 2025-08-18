#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_DKBRANCH_DIR()
#
#
function(dk_DKBRANCH_DIR)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(DKBRANCH_DIR "${ARGV0}")

	###### GET ######
	elseif(DEFINED ENV{DKBRANCH_DIR})	
		dk_set(DKBRANCH_DIR "$ENV{DKBRANCH_DIR}")
		
	else()
		if(NOT DEFINED DKBRANCH)
			dk_set(DKBRANCH "Development")
		endif()
		
		dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
		
		# TODO: If the current folder matches the current branch set DKBRANCH, otherwise default to Development
		# BRANCH="$(${GIT_EXE} rev-parse --abbrev-ref HEAD)"
		if(EXISTS "$ENV{DIGITALKNOB_DIR}/${DKBRANCH}/.git")
			dk_dirname(${CMAKE_CURRENT_LIST_DIR})
			dk_source(dk_basename)
			dk_basename("${dk_dirname}")
			if("${BRANCH}" STREQUAL "${dk_basename}")
				dk_set(DKBRANCH "${dk_basename}")
			endif()
		endif()
	endif()

	###### FINALIZE ######
	### DKBRANCH_DIR ###
	if(NOT EXISTS "${DKBRANCH_DIR}")
		dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
		dk_set(DKBRANCH_DIR "$ENV{DIGITALKNOB_DIR}/${DKBRANCH}")
	endif()

		### DK3RDPARTY ###
		if(NOT EXISTS "${DK3RDPARTY_DIR}")
			dk_set(DK3RDPARTY_DIR "${DKBRANCH_DIR}/3rdParty")
		endif()
			### DKIMPORTS ###
			if(NOT EXISTS "${DKIMPORTS_DIR}")
				dk_set(DKIMPORTS_DIR "${DK3RDPARTY_DIR}/_DKIMPORTS")
			endif()

		### DKBASH ###
		if(NOT EXISTS "${DKBASH_DIR}") 
			dk_set(DKBASH_DIR "${DKBRANCH_DIR}/DKBash")
		endif()
			if(NOT EXISTS "${DKBASH_FUNCTIONS_DIR}") 
				dk_set(DKBASH_FUNCTIONS_DIR "${DKBASH_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKBASH_FUNCTIONS_DIR_}") 
				dk_set(DKBASH_FUNCTIONS_DIR_ "${DKBASH_FUNCTIONS_DIR}/")
			endif()

		### DKBATCH ###
		if(NOT EXISTS "${DKBATCH_DIR}") 
			dk_set(DKBATCH_DIR "${DKBRANCH_DIR}/DKBatch")
		endif()
			if(NOT EXISTS "${DKBATCH_FUNCTIONS_DIR}") 
				dk_set(DKBATCH_FUNCTIONS_DIR "${DKBATCH_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKBATCH_FUNCTIONS_DIR_}") 
				dk_set(DKBATCH_FUNCTIONS_DIR_ "${DKBATCH_FUNCTIONS_DIR}/")
			endif()

		### DKC ###
		if(NOT EXISTS "${DKC_DIR}") 
			dk_set(DKC_DIR "${DKBRANCH_DIR}/DKC")
		endif()
			if(NOT EXISTS "${DKC_FUNCTIONS_DIR}") 
				dk_set(DKC_FUNCTIONS_DIR "${DKC_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKC_FUNCTIONS_DIR_}") 
				dk_set(DKC_FUNCTIONS_DIR_ "${DKC_FUNCTIONS_DIR}/")
			endif()
			
		### DKCMAKE ###
		if(NOT EXISTS "${DKCMAKE_DIR}") 
			dk_set(DKCMAKE_DIR "${DKBRANCH_DIR}/DKCMake")
		endif()
			if(NOT EXISTS "${DKCMAKE_FUNCTIONS_DIR}") 
				dk_set(DKCMAKE_FUNCTIONS_DIR "${DKCMAKE_DIR}/functions")
			endif()
			if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}") 
				dk_set(DKCMAKE_FUNCTIONS_DIR_ "${DKCMAKE_FUNCTIONS_DIR}/")
			endif()

		### DKCPP ###
		if(NOT EXISTS "${DKCPP_DIR}") 
			dk_set(DKCPP_DIR "${DKBRANCH_DIR}/DKCpp")
		endif()
			if(NOT EXISTS "${DKCPP_APPS_DIR}") 
				dk_set(DKCPP_APPS_DIR "${DKCPP_DIR}/apps")
			endif()
			if(NOT EXISTS "${DKCPP_FUNCTIONS_DIR}") 
				dk_set(DKCPP_FUNCTIONS_DIR "${DKCPP_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKCPP_FUNCTIONS_DIR_}") 
				dk_set(DKCPP_FUNCTIONS_DIR_ "${DKCPP_FUNCTIONS_DIR}/")
			endif()
			if(NOT EXISTS "${DKCPP_PLUGINS_DIR}") 
				dk_set(DKCPP_PLUGINS_DIR "${DKCPP_DIR}/plugins")
			endif()
			
		### DKCSHARP ###
		if(NOT EXISTS "${DKCSHARP_DIR}") 
			dk_set(DKCSHARP_DIR "${DKBRANCH_DIR}/DKCSharp")
		endif()
			if(NOT EXISTS "${DKCSHARP_FUNCTIONS_DIR}") 
				dk_set(DKCSHARP_FUNCTIONS_DIR "${DKCSHARP_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKCSHARP_FUNCTIONS_DIR_}") 
				dk_set(DKCSHARP_FUNCTIONS_DIR_ "${DKCSHARP_FUNCTIONS_DIR}/")
			endif()
			
		### DKC ###
		if(NOT EXISTS "${DKHTA_DIR}") 
			dk_set(DKHTA_DIR "${DKBRANCH_DIR}/DKHta")
		endif()
			if(NOT EXISTS "${DKHTA_FUNCTIONS_DIR}") 
				dk_set(DKHTA_FUNCTIONS_DIR "${DKHTA_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKHTA_FUNCTIONS_DIR_}") 
				dk_set(DKHTA_FUNCTIONS_DIR_ "${DKHTA_FUNCTIONS_DIR}/")
			endif()
			
		### DKHTML ###
		if(NOT EXISTS "${DKHTML_DIR}") 
			dk_set(DKHTML_DIR "${DKBRANCH_DIR}/DKHtml")
		endif()
			if(NOT EXISTS "${DKHTML_FUNCTIONS_DIR}") 
				dk_set(DKHTML_FUNCTIONS_DIR "${DKHTML_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKHTML_FUNCTIONS_DIR_}") 
				dk_set(DKHTML_FUNCTIONS_DIR_ "${DKHTML_FUNCTIONS_DIR}/")
			endif()
			
		### DKJAVA ###
		if(NOT EXISTS "${DKJAVA_DIR}") 
			dk_set(DKJAVA_DIR "${DKBRANCH_DIR}/DKJava")
		endif()
			if(NOT EXISTS "${DKJAVA_FUNCTIONS_DIR}") 
				dk_set(DKJAVA_FUNCTIONS_DIR "${DKJAVA_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKJAVA_FUNCTIONS_DIR_}") 
				dk_set(DKJAVA_FUNCTIONS_DIR_ "${DKJAVA_FUNCTIONS_DIR}/")
			endif()
			
		### DKJAVASCRIPT ###
		if(NOT EXISTS "${DKJAVASCRIPT_DIR}") 
			dk_set(DKJAVASCRIPT_DIR "${DKBRANCH_DIR}/DKJavascript")
		endif()
			if(NOT EXISTS "${DKJAVASCRIPT_FUNCTIONS_DIR}") 
				dk_set(DKJAVASCRIPT_FUNCTIONS_DIR "${DKJAVASCRIPT_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKJAVASCRIPT_FUNCTIONS_DIR_}") 
				dk_set(DKJAVASCRIPT_FUNCTIONS_DIR_ "${DKJAVASCRIPT_FUNCTIONS_DIR}/")
			endif()
			
		### DKPHP ###
		if(NOT EXISTS "${DKPHP_DIR}") 
			dk_set(DKPHP_DIR "${DKBRANCH_DIR}/DKPhp")
		endif()
			if(NOT EXISTS "${DKPHP_FUNCTIONS_DIR}") 
				dk_set(DKPHP_FUNCTIONS_DIR "${DKPHP_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKPHP_FUNCTIONS_DIR_}") 
				dk_set(DKPHP_FUNCTIONS_DIR_ "${DKPHP_FUNCTIONS_DIR}/")
			endif()
			
		### DKPOWERSHELL ###
		if(NOT EXISTS "${DKPOWERSHELL_DIR}") 
			dk_set(DKPOWERSHELL_DIR "${DKBRANCH_DIR}/DKPowershell")
		endif()
			if(NOT EXISTS "${DKPOWERSHELL_FUNCTIONS_DIR}") 
				dk_set(DKPOWERSHELL_FUNCTIONS_DIR "${DKPOWERSHELL_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKPOWERSHELL_FUNCTIONS_DIR_}") 
				dk_set(DKPOWERSHELL_FUNCTIONS_DIR_ "${DKPOWERSHELL_FUNCTIONS_DIR}/")
			endif()
			
		### DKPYTHON ###
		if(NOT EXISTS "${DKPYTHON_DIR}") 
			dk_set(DKPYTHON_DIR "${DKBRANCH_DIR}/DKPython")
		endif()
			if(NOT EXISTS "${DKPYTHON_FUNCTIONS_DIR}") 
				dk_set(DKPYTHON_FUNCTIONS_DIR "${DKPYTHON_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKPYTHON_FUNCTIONS_DIR_}") 
				dk_set(DKPYTHON_FUNCTIONS_DIR_ "${DKPYTHON_FUNCTIONS_DIR}/")
			endif()
			
		### DKVB ###
		if(NOT EXISTS "${DKVB_DIR}") 
			dk_set(DKVB_DIR "${DKBRANCH_DIR}/DKVb")
		endif()
			if(NOT EXISTS "${DKVB_FUNCTIONS_DIR}") 
				dk_set(DKVB_FUNCTIONS_DIR "${DKVB_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKVB_FUNCTIONS_DIR_}") 
				dk_set(DKVB_FUNCTIONS_DIR_ "${DKVB_FUNCTIONS_DIR}/")
			endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("Test Getting DKBRANCH_DIR . . .")
	dk_DKBRANCH_DIR()
	if(EXISTS "${DKBRANCH_DIR}")
		dk_success("DKBRANCH_DIR = ${DKBRANCH_DIR}")
	else()
		dk_error("DKBRANCH_DIR:'${DKBRANCH_DIR}' not found")
	endif()
	
	dk_echo()
	dk_echo("Test Setting DKBRANCH_DIR . . .")
	dk_DKBRANCH_DIR("C:/DK/Development")
	if(EXISTS "${DKBRANCH_DIR}")
		dk_success("DKBRANCH_DIR = ${DKBRANCH_DIR}")
	else()
		dk_error("DKBRANCH_DIR:'${DKBRANCH_DIR}' not found")
	endif()
endfunction()
