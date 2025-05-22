#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_DKBRANCH_DIR()
#
#
function(dk_DKBRANCH_DIR)
	dk_debugFunc(0 1)

	###### SET ######
#	if(ARGV)
#		dk_set(DKBRANCH_DIR "${ARGV}")
#		return()
#	endif()

	###### GET ######
	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")

	if(NOT DEFINED DKBRANCH)
		dk_set(DKBRANCH "Development")
	endif()
	if(EXISTS "${DIGITALKNOB_DIR}/${DKBRANCH}/.git")
		# BRANCH="$(${GIT_EXE} rev-parse --abbrev-ref HEAD)"
		# If the current folder matches the current branch set DKBRANCH, otherwise default to Development
		dk_dirname(${CMAKE_CURRENT_LIST_DIR} CURRENT_FOLDER)
		if("${BRANCH}" STREQUAL "${CURRENT_FOLDER}")
			dk_set(DKBRANCH "${CURRENT_FOLDER}")
		endif()
	endif()

	###### DKBRANCH ######
	if(NOT EXISTS "${DKBRANCH_DIR}") 
		dk_set(DKBRANCH_DIR "${DIGITALKNOB_DIR}/${DKBRANCH}")
	endif()

		###### DK3RDPARTY ######
		if(NOT EXISTS "${DK3RDPARTY_DIR}")
			dk_set(DK3RDPARTY_DIR "${DKBRANCH_DIR}/3rdParty")
		endif()
			###### DKIMPORTS ######
			if(NOT EXISTS "${DKIMPORTS_DIR}")
				dk_set(DKIMPORTS_DIR "${DK3RDPARTY_DIR}/_DKIMPORTS")
			endif()

		###### DKBASH ######
		if(NOT EXISTS "${DKBASH_DIR}") 
			dk_set(DKBASH_DIR "${DKBRANCH_DIR}/DKBash")
		endif()
			if(NOT EXISTS "${DKBASH_FUNCTIONS_DIR}") 
				dk_set(DKBASH_FUNCTIONS_DIR "${DKBASH_DIR}/functions")
			endif()
			if(NOT EXISTS "${DKBASH_FUNCTIONS_DIR_}") 
				dk_set(DKBASH_FUNCTIONS_DIR_ "${DKBASH_DIR}/functions/")
			endif()

		###### DKBATCH ######
		dk_set(DKBATCH_DIR} "${DKBRANCH_DIR}/DKBatch")
			dk_set(DKBATCH_FUNCTIONS_DIR "${DKBATCH_DIR}/functions")
			dk_set(DKBATCH_FUNCTIONS_DIR_ "${DKBATCH_FUNCTIONS_DIR}/")

		###### DKC ######
		dk_set(DKC_DIR "${DKBRANCH_DIR}/DKC")
			dk_set(DKC_FUNCTIONS_DIR "${DKC_DIR}/functions")
			dk_set(DKC_FUNCTIONS_DIR_ "${DKC_FUNCTIONS_DIR}/")

		###### DKCMAKE ######
		dk_set(DKCMAKE_DIR "${DKBRANCH_DIR}/DKCMake")
			dk_set(DKCMAKE_FUNCTIONS_DIR "${DKCMAKE_DIR}/functions")
			dk_set(DKCMAKE_FUNCTIONS_DIR_ "${DKCMAKE_FUNCTIONS_DIR}/")

		###### DKCPP ######
		dk_set(DKCPP_DIR "${DKBRANCH_DIR}/DKCpp")
			dk_set(DKCPP_APPS_DIR "${DKCPP_DIR}/apps")
			dk_set(DKCPP_FUNCTIONS_DIR "${DKCPP_DIR}/functions")
			dk_set(DKCPP_FUNCTIONS_DIR_ "${DKCPP_FUNCTIONS_DIR}/")
			dk_set(DKCPP_PLUGINS_DIR "${DKCPP_DIR}/plugins")

		###### DKCSHARP ######
		dk_set(DKCSHARP_DIR "${DKBRANCH_DIR}/DKCSharp")
			dk_set(DKCSHARP_FUNCTIONS_DIR "${DKCSHARP_DIR}/functions")
			dk_set(DKCSHARP_FUNCTIONS_DIR_ "${DKCSHARP_FUNCTIONS_DIR}/")

		###### DKC ######
		dk_set(DKHTA_DIR "${DKBRANCH_DIR}/DKHta")
			dk_set(DKHTA_FUNCTIONS_DIR "${DKHTA_DIR}/functions")
			dk_set(DKHTA_FUNCTIONS_DIR_ "${DKHTA_FUNCTIONS_DIR}/")

		###### DKHTML ######
		dk_set(DKHTML_DIR "${DKBRANCH_DIR}/DKHtml")
			dk_set(DKHTML_FUNCTIONS_DIR "${DKHTML_DIR}/functions")
			dk_set(DKHTML_FUNCTIONS_DIR_ "${DKHTML_FUNCTIONS_DIR}/")

		###### DKJAVA ######
		dk_set(DKJAVA_DIR "${DKBRANCH_DIR}/DKJava")
			dk_set(DKJAVA_FUNCTIONS_DIR "${DKJAVA_DIR}/functions")
			dk_set(DKJAVA_FUNCTIONS_DIR_ "${DKJAVA_FUNCTIONS_DIR}/")

		###### DKJAVASCRIPT ######
		dk_set(DKJAVASCRIPT_DIR "${DKBRANCH_DIR}/DKJavascript")
			dk_set(DKJAVASCRIPT_FUNCTIONS_DIR "${DKJAVASCRIPT_DIR}/functions")
			dk_set(DKJAVASCRIPT_FUNCTIONS_DIR_ "${DKJAVASCRIPT_FUNCTIONS_DIR}/")

		###### DKPHP ######
		dk_set(DKPHP_DIR "${DKBRANCH_DIR}/DKPhp")
			dk_set(DKPHP_FUNCTIONS_DIR "${DKPHP_DIR}/functions")
			dk_set(DKPHP_FUNCTIONS_DIR_ "${DKPHP_FUNCTIONS_DIR}/")

		###### DKPOWERSHELL ######
		dk_set(DKPOWERSHELL_DIR "${DKBRANCH_DIR}/DKPowershell")
			dk_set(DKPOWERSHELL_FUNCTIONS_DIR "${DKPOWERSHELL_DIR}/functions")
			dk_set(DKPOWERSHELL_FUNCTIONS_DIR_ "${DKPOWERSHELL_FUNCTIONS_DIR}/")

		###### DKPYTHON ######
		dk_set(DKPYTHON_DIR "${DKBRANCH_DIR}/DKPython")
			dk_set(DKPYTHON_FUNCTIONS_DIR "${DKPYTHON_DIR}/functions")
			dk_set(DKPYTHON_FUNCTIONS_DIR_ "${DKPYTHON_FUNCTIONS_DIR}/")

		###### DKVB ######
		dk_set(DKVB_DIR "${DKBRANCH_DIR}/DKVb")
			dk_set(DKVB_FUNCTIONS_DIR "${DKVB_DIR}/functions")
			dk_set(DKVB_FUNCTIONS_DIR_ "${DKVB_FUNCTIONS_DIR}/")
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
