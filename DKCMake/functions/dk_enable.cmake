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
# dk_enable(Plugin)
#
#	TODO
#
#	@Plugin		- TODO
#
function(dk_enable Plugin)
	dk_debugFunc()
	
	if(NOT ${Plugin})
		if(${ARGC} GREATER 1)
			#dk_set(${${ARGV1}} ON)
			dk_set(HAVE_${${ARGV1}} ON)
			dk_convertToCIdentifier(${ARGV1} argv1_macro)   # In c/c++ we can't use certian symbals in the preprocess or for macros. I.E. - must be turned to _
			dk_define(HAVE_${argv1_macro})
		else()
			#dk_set(${Plugin} ON)
			dk_set(HAVE_${Plugin} ON)
			dk_convertToCIdentifier(${Plugin} plugin_macro) # In c/c++ we can't use certian symbals in the preprocess or for macros. I.E. - must be turned to _
			dk_define(HAVE_${plugin_macro})
		endif()
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()