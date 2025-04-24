#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_DKBRANCH_DIR()
#
#
function(dk_DKBRANCH_DIR)
<<<<<<< HEAD
	dk_debugFunc()

	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
	
	dk_set(DKBRANCH "Development")
	if(EXISTS "${DIGITALKNOB_DIR}/${DKBRANCH}/.git")
=======
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
>>>>>>> Development
		# BRANCH="$(${GIT_EXE} rev-parse --abbrev-ref HEAD)"
		# If the current folder matches the current branch set DKBRANCH, otherwise default to Development
		dk_dirname(${CMAKE_CURRENT_LIST_DIR} CURRENT_FOLDER)
		if("${BRANCH}" STREQUAL "${CURRENT_FOLDER}")
<<<<<<< HEAD
			set(DKBRANCH "${CURRENT_FOLDER}")
		endif()
	endif()
	#dk_printVar(DKBRANCH)
	
	dk_set(DKBRANCH_DIR "${DIGITALKNOB_DIR}/${DKBRANCH}")
	set(ENV{DKBRANCH_DIR} "${DIGITALKNOB_DIR}/${DKBRANCH}")
	#dk_printVar(DKBRANCH_DIR)
		

		
		
		
		
		dk_set(DKBATCH_DIR "${DKBRANCH_DIR}/DKBatch")
		set(ENV{DKBATCH_DIR} "${DKBRANCH_DIR}/DKBatch")
		#dk_printVar(DKBATCH_DIR)
			dk_set(DKBATCH_FUNCTIONS_DIR "${DKBATCH_DIR}/functions")
			set(ENV{DKBATCH_FUNCTIONS_DIR} "${DKBATCH_DIR}/functions")
			#dk_printVar(DKBATCH_FUNCTIONS_DIR)
			dk_set(DKBATCH_FUNCTIONS_DIR_ "${DKBATCH_DIR}/functions/")
			set(ENV{DKBATCH_FUNCTIONS_DIR_} "${DKBATCH_DIR}/functions/")
			#dk_printVar(DKBATCH_FUNCTIONS_DIR_)
		
		dk_set(DKC_DIR "${DKBRANCH_DIR}/DKC")
		set(ENV{DKC_DIR} "${DKBRANCH_DIR}/DKC")
		#dk_printVar(DKC_DIR)
			dk_set(DKC_FUNCTIONS_DIR "${DKC_DIR}/functions")
			set(ENV{DKC_FUNCTIONS_DIR} "${DKC_DIR}/functions")
			#dk_printVar(DKC_FUNCTIONS_DIR)
			dk_set(DKC_FUNCTIONS_DIR_ "${DKC_DIR}/functions/")
			set(ENV{DKC_FUNCTIONS_DIR_} "${DKC_DIR}/functions/")
			#dk_printVar(DKC_FUNCTIONS_DIR_)
			
		dk_set(DKCMAKE_DIR "${DKBRANCH_DIR}/DKCMake")
		set(ENV{DKCMAKE_DIR} "${DKBRANCH_DIR}/DKCMake")
		#dk_printVar(DKC_FUNCTIONS_DIR_)
			dk_set(DKCMAKE_FUNCTIONS_DIR "${DKCMAKE_DIR}/functions")
			set(ENV{DKCMAKE_FUNCTIONS_DIR} "${DKCMAKE_DIR}/functions")
			#dk_printVar(DKCMAKE_FUNCTIONS_DIR)
			dk_set(DKCMAKE_FUNCTIONS_DIR_ "${DKCMAKE_DIR}/functions/")
			set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_DIR}/functions/")
			#dk_printVar(DKCMAKE_FUNCTIONS_DIR_)
		
		dk_set(DKCPP_DIR "${DKBRANCH_DIR}/DKCpp")
		set(ENV{DKCPP_DIR} "${DKBRANCH_DIR}/DKCpp")
		#dk_printVar(DKCPP_DIR)
			dk_set(DKCPP_FUNCTIONS_DIR "${DKCPP_DIR}/functions")
			set(ENV{DKCPP_FUNCTIONS_DIR} "${DKCPP_DIR}/functions")
			#dk_printVar(DKCPP_FUNCTIONS_DIR)
			dk_set(DKCPP_FUNCTIONS_DIR_ "${DKCPP_DIR}/functions/")
			set(ENV{DKCPP_FUNCTIONS_DIR_} "${DKCPP_DIR}/functions/")
			#dk_printVar(DKCPP_FUNCTIONS_DIR_)
			
		dk_set(DKCSHARP_DIR "${DKBRANCH_DIR}/DKCSharp")
		set(ENV{DKCSHARP_DIR} "${DKBRANCH_DIR}/DKCSharp")
		#dk_printVar(DKCSHARP_DIR)
			dk_set(DKCSHARP_FUNCTIONS_DIR "${DKCSHARP_DIR}/functions")
			set(ENV{DKCSHARP_FUNCTIONS_DIR} "${DKCSHARP_DIR}/functions")
			#dk_printVar(DKCSHARP_FUNCTIONS_DIR)
			dk_set(DKCSHARP_FUNCTIONS_DIR_ "${DKCSHARP_DIR}/functions/")
			set(ENV{DKCSHARP_FUNCTIONS_DIR_} "${DKCSHARP_DIR}/functions/")
			#dk_printVar(DKCSHARP_FUNCTIONS_DIR_)
		
		dk_set(DKHTA_DIR "${DKBRANCH_DIR}/DKHta")
		set(ENV{DKHTA_DIR} "${DKBRANCH_DIR}/DKHta")
		#dk_printVar(DKHTA_DIR)
			dk_set(DKHTA_FUNCTIONS_DIR "${DKHTA_DIR}/functions")
			set(ENV{DKHTA_FUNCTIONS_DIR} "${DKHTA_DIR}/functions")
			#dk_printVar(DKHTA_FUNCTIONS_DIR)
			dk_set(DKHTA_FUNCTIONS_DIR_ "${DKHTA_DIR}/functions/")
			set(ENV{DKHTA_FUNCTIONS_DIR_} "${DKHTA_DIR}/functions/")
			#dk_printVar(DKHTA_FUNCTIONS_DIR_)
			
		dk_set(DKHTML_DIR "${DKBRANCH_DIR}/DKHtml")
		set(ENV{DKHTML_DIR} "${DKBRANCH_DIR}/DKHtml")
		#dk_printVar(DKHTML_DIR)
			dk_set(DKHTML_FUNCTIONS_DIR "${DKHTML_DIR}/functions")
			set(ENV{DKHTML_FUNCTIONS_DIR} "${DKHTML_DIR}/functions")
			#dk_printVar(DKHTML_FUNCTIONS_DIR)
			dk_set(DKHTML_FUNCTIONS_DIR_ "${DKHTML_DIR}/functions/")
			set(ENV{DKHTML_FUNCTIONS_DIR_} "${DKHTML_DIR}/functions/")
			#dk_printVar(DKHTML_FUNCTIONS_DIR_)
			
		dk_set(DKJAVA_DIR "${DKBRANCH_DIR}/DKJava")
		set(ENV{DKJAVA_DIR} "${DKBRANCH_DIR}/DKJava")
		#dk_printVar(DKJAVA_DIR)
			dk_set(DKJAVA_FUNCTIONS_DIR "${DKJAVA_DIR}/functions")
			set(ENV{DKJAVA_FUNCTIONS_DIR} "${DKJAVA_DIR}/functions")
			#dk_printVar(DKJAVA_FUNCTIONS_DIR)
			dk_set(DKJAVA_FUNCTIONS_DIR_ "${DKJAVA_DIR}/functions/")
			set(ENV{DKJAVA_FUNCTIONS_DIR_} "${DKJAVA_DIR}/functions/")
			#dk_printVar(DKJAVA_FUNCTIONS_DIR_)
			
		dk_set(DKJAVASCRIPT_DIR "${DKBRANCH_DIR}/DKJavascript")
		set(ENV{DKJAVASCRIPT_DIR} "${DKBRANCH_DIR}/DKJavascript")
		#dk_printVar(DKJAVASCRIPT_DIR)
			dk_set(DKJAVASCRIPT_FUNCTIONS_DIR "${DKJAVASCRIPT_DIR}/functions")
			set(ENV{DKJAVASCRIPT_FUNCTIONS_DIR} "${DKJAVASCRIPT_DIR}/functions")
			#dk_printVar(DKJAVASCRIPT_FUNCTIONS_DIR)
			dk_set(DKJAVASCRIPT_FUNCTIONS_DIR_ "${DKJAVASCRIPT_DIR}/functions/")
			set(ENV{DKJAVASCRIPT_FUNCTIONS_DIR_} "${DKJAVASCRIPT_DIR}/functions/")
			#dk_printVar(DKJAVASCRIPT_FUNCTIONS_DIR_)
			
		dk_set(DKPHP_DIR "${DKBRANCH_DIR}/DKJavascript")
		set(ENV{DKPHP_DIR} "${DKBRANCH_DIR}/DKJavascript")
		#dk_printVar(DKPHP_DIR)
			dk_set(DKPHP_FUNCTIONS_DIR "${DKPHP_DIR}/functions")
			set(ENV{DKPHP_FUNCTIONS_DIR} "${DKPHP_DIR}/functions")
			#dk_printVar(DKPHP_FUNCTIONS_DIR)
			dk_set(DKPHP_FUNCTIONS_DIR_ "${DKPHP_DIR}/functions/")
			set(ENV{DKPHP_FUNCTIONS_DIR_} "${DKPHP_DIR}/functions/")
			#dk_printVar(DKPHP_FUNCTIONS_DIR_)
			
		dk_set(DKPOWERSHELL_DIR "${DKBRANCH_DIR}/DKPowershell")
		set(ENV{DKPOWERSHELL_DIR} "${DKBRANCH_DIR}/DKPowershell")
		#dk_printVar(DKPOWERSHELL_DIR)
			dk_set(DKPOWERSHELL_FUNCTIONS_DIR "${DKPOWERSHELL_DIR}/functions")
			set(ENV{DKPOWERSHELL_FUNCTIONS_DIR} "${DKPOWERSHELL_DIR}/functions")
			#dk_printVar(DKPOWERSHELL_FUNCTIONS_DIR)
			dk_set(DKPOWERSHELL_FUNCTIONS_DIR_ "${DKPOWERSHELL_DIR}/functions/")
			set(ENV{DKPOWERSHELL_FUNCTIONS_DIR_} "${DKPOWERSHELL_DIR}/functions/")
			#dk_printVar(DKPOWERSHELL_FUNCTIONS_DIR_)
			
		dk_set(DKPYTHON_DIR "${DKBRANCH_DIR}/DKPowershell")
		set(ENV{DKPYTHON_DIR} "${DKBRANCH_DIR}/DKPowershell")
		#dk_printVar(DKPYTHON_DIR)
			dk_set(DKPYTHON_FUNCTIONS_DIR "${DKPYTHON_DIR}/functions")
			set(ENV{DKPYTHON_FUNCTIONS_DIR} "${DKPYTHON_DIR}/functions")
			#dk_printVar(DKPYTHON_FUNCTIONS_DIR)
			dk_set(DKPYTHON_FUNCTIONS_DIR_ "${DKPYTHON_DIR}/functions/")
			set(ENV{DKPYTHON_FUNCTIONS_DIR_} "${DKPYTHON_DIR}/functions/")
			#dk_printVar(DKPYTHON_FUNCTIONS_DIR_)
=======
			set(ENV{DKBRANCH} "${CURRENT_FOLDER}")
		endif()
	endif()

	###### DKBRANCH ######
	if(NOT EXISTS "$ENV{DKBRANCH_DIR}") 
		dk_set(ENV{DKBRANCH_DIR} "$ENV{DIGITALKNOB_DIR}/$ENV{DKBRANCH}")
	endif()

		###### DK3RDPARTY ######
		if(NOT EXISTS "$ENV{DK3RDPARTY_DIR}")
			dk_set(ENV{DK3RDPARTY_DIR} "$ENV{DKBRANCH_DIR}/3rdParty")
		endif()
			###### DKIMPORTS ######
			if(NOT EXISTS "$ENV{DKIMPORTS_DIR}")
				dk_set(ENV{DKIMPORTS_DIR} "$ENV{DK3RDPARTY_DIR}/_DKIMPORTS")
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
>>>>>>> Development
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_DKBRANCH_DIR()
	dk_printVar(DKBRANCH_DIR)
=======
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("Test Getting DKBRANCH_DIR . . .")
	dk_DKBRANCH_DIR()
	dk_printVar(ENV{DKBRANCH_DIR})
	
	dk_echo()
	dk_echo("Test Setting DKBRANCH_DIR . . .")
	dk_DKBRANCH_DIR("C:/DK/Development")
	dk_printVar(ENV{DKBRANCH_DIR})
>>>>>>> Development
endfunction()
