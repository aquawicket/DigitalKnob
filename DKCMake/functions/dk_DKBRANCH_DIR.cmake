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
#	if(ARGV)
#		dk_set(ENV{DKBRANCH_DIR} "${ARGV}")
#		return()
#	endif()

	###### GET ######
	dk_validate(ENV{DIGITALKNOB_DIR} "dk_DIGITALKNOB_DIR()")

	dk_set(ENV{DKBRANCH} "Development")
	if(EXISTS "$ENV{DIGITALKNOB_DIR}/$ENV{DKBRANCH}/.git")
		# BRANCH="$(${GIT_EXE} rev-parse --abbrev-ref HEAD)"
		# If the current folder matches the current branch set DKBRANCH, otherwise default to Development
		dk_dirname(${CMAKE_CURRENT_LIST_DIR} CURRENT_FOLDER)
		if("${BRANCH}" STREQUAL "${CURRENT_FOLDER}")
			set(ENV{DKBRANCH} "${CURRENT_FOLDER}")
		endif()
	endif()

	###### DKBRANCH ######
	if(NOT EXISTS "$ENV{DKBRANCH_DIR}") 
		dk_set(ENV{DKBRANCH_DIR} "$ENV{DIGITALKNOB_DIR}/$ENV{DKBRANCH}")
	endif()

		###### DKBASH ######
		if(NOT EXISTS "$ENV{DKBASH_DIR}") 
			dk_set(ENV{DKBASH_DIR} "$ENV{DKBRANCH_DIR}/DKBash")
		endif()
			if(NOT EXISTS "$ENV{DKBASH_FUNCTIONS_DIR}") 
				dk_set(ENV{DKBASH_FUNCTIONS_DIR} "$ENV{DKBASH_DIR}/functions")
			endif()
			if(NOT EXISTS "$ENV{DKBASH_FUNCTIONS_DIR_}") 
				dk_set(ENV{DKBASH_FUNCTIONS_DIR_} "$ENV{DKBASH_DIR}/functions/")
			endif()

		###### DKBATCH ######
		dk_set(ENV{DKBATCH_DIR} "$ENV{DKBRANCH_DIR}/DKBatch")
			dk_set(ENV{DKBATCH_FUNCTIONS_DIR} "$ENV{DKBATCH_DIR}/functions")
			dk_set(ENV{DKBATCH_FUNCTIONS_DIR_} "$ENV{DKBATCH_FUNCTIONS_DIR}/")

		###### DKC ######
		dk_set(ENV{DKC_DIR} "$ENV{DKBRANCH_DIR}/DKC")
			dk_set(ENV{DKC_FUNCTIONS_DIR} "$ENV{DKC_DIR}/functions")
			dk_set(ENV{DKC_FUNCTIONS_DIR_} "$ENV{DKC_FUNCTIONS_DIR}/")

		###### DKCMAKE ######
		dk_set(ENV{DKCMAKE_DIR} "$ENV{DKBRANCH_DIR}/DKCMake")
			dk_set(ENV{DKCMAKE_FUNCTIONS_DIR} "$ENV{DKCMAKE_DIR}/functions")
			dk_set(ENV{DKCMAKE_FUNCTIONS_DIR_} "$ENV{DKCMAKE_FUNCTIONS_DIR}/")

		###### DKCPP ######
		dk_set(ENV{DKCPP_DIR} "$ENV{DKBRANCH_DIR}/DKCpp")
			dk_set(ENV{DKCPP_APPS_DIR} "$ENV{DKCPP_DIR}/apps")
			dk_set(ENV{DKCPP_FUNCTIONS_DIR} "$ENV{DKCPP_DIR}/functions")
			dk_set(ENV{DKCPP_FUNCTIONS_DIR_} "$ENV{DKCPP_FUNCTIONS_DIR}/")
			dk_set(ENV{DKCPP_PLUGINS_DIR} "$ENV{DKCPP_DIR}/plugins")

		###### DKCSHARP ######
		dk_set(ENV{DKCSHARP_DIR} "$ENV{DKBRANCH_DIR}/DKCSharp")
			dk_set(ENV{DKCSHARP_FUNCTIONS_DIR} "$ENV{DKCSHARP_DIR}/functions")
			dk_set(ENV{DKCSHARP_FUNCTIONS_DIR_} "$ENV{DKCSHARP_FUNCTIONS_DIR}/")

		###### DKC ######
		dk_set(ENV{DKHTA_DIR} "$ENV{DKBRANCH_DIR}/DKHta")
			dk_set(ENV{DKHTA_FUNCTIONS_DIR} "$ENV{DKHTA_DIR}/functions")
			dk_set(ENV{DKHTA_FUNCTIONS_DIR_} "$ENV{DKHTA_FUNCTIONS_DIR}/")

		###### DKHTML ######
		dk_set(ENV{DKHTML_DIR} "$ENV{DKBRANCH_DIR}/DKHtml")
			dk_set(ENV{DKHTML_FUNCTIONS_DIR} "$ENV{DKHTML_DIR}/functions")
			dk_set(ENV{DKHTML_FUNCTIONS_DIR_} "$ENV{DKHTML_FUNCTIONS_DIR}/")

		###### DKJAVA ######
		dk_set(ENV{DKJAVA_DIR} "$ENV{DKBRANCH_DIR}/DKJava")
			dk_set(ENV{DKJAVA_FUNCTIONS_DIR} "$ENV{DKJAVA_DIR}/functions")
			dk_set(ENV{DKJAVA_FUNCTIONS_DIR_} "$ENV{DKJAVA_FUNCTIONS_DIR}/")

		###### DKJAVASCRIPT ######
		dk_set(ENV{DKJAVASCRIPT_DIR} "$ENV{DKBRANCH_DIR}/DKJavascript")
			dk_set(ENV{DKJAVASCRIPT_FUNCTIONS_DIR} "$ENV{DKJAVASCRIPT_DIR}/functions")
			dk_set(ENV{DKJAVASCRIPT_FUNCTIONS_DIR_} "$ENV{DKJAVASCRIPT_FUNCTIONS_DIR}/")

		###### DKPHP ######
		dk_set(ENV{DKPHP_DIR} "$ENV{DKBRANCH_DIR}/DKPhp")
			dk_set(ENV{DKPHP_FUNCTIONS_DIR} "$ENV{DKPHP_DIR}/functions")
			dk_set(ENV{DKPHP_FUNCTIONS_DIR_} "$ENV{DKPHP_FUNCTIONS_DIR}/")

		###### DKPOWERSHELL ######
		dk_set(ENV{DKPOWERSHELL_DIR} "$ENV{DKBRANCH_DIR}/DKPowershell")
			dk_set(ENV{DKPOWERSHELL_FUNCTIONS_DIR} "$ENV{DKPOWERSHELL_DIR}/functions")
			dk_set(ENV{DKPOWERSHELL_FUNCTIONS_DIR_} "$ENV{DKPOWERSHELL_FUNCTIONS_DIR}/")

		###### DKPYTHON ######
		dk_set(ENV{DKPYTHON_DIR} "$ENV{DKBRANCH_DIR}/DKPython")
			dk_set(ENV{DKPYTHON_FUNCTIONS_DIR} "$ENV{DKPYTHON_DIR}/functions")
			dk_set(ENV{DKPYTHON_FUNCTIONS_DIR_} "$ENV{DKPYTHON_FUNCTIONS_DIR}/")

		###### DKVB ######
		dk_set(ENV{DKVB_DIR} "$ENV{DKBRANCH_DIR}/DKVb")
			dk_set(ENV{DKVB_FUNCTIONS_DIR} "$ENV{DKVB_DIR}/functions")
			dk_set(ENV{DKVB_FUNCTIONS_DIR_} "$ENV{DKVB_FUNCTIONS_DIR}/")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("Test Getting DKBRANCH_DIR . . .")
	dk_DKBRANCH_DIR()
	dk_printVar(ENV{DKBRANCH_DIR})
	
	dk_echo()
	dk_echo("Test Setting DKBRANCH_DIR . . .")
	dk_DKBRANCH_DIR("C:/DK/Development")
	dk_printVar(ENV{DKBRANCH_DIR})
endfunction()
