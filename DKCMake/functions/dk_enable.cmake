#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_enable(plugin)
#
#	TODO
#
#	@plugin		- TODO
#
function(dk_enable plugin)
	dk_debugFunc()
	
	if(NOT ${plugin})
		if(${ARGC} GREATER 1)
			dk_set(${${ARGV1}} ON)
			dk_set(HAVE_${${ARGV1}} ON)
			dk_convertToCIdentifier(${ARGV1} argv1_macro)   # In c/c++ we can't use certian symbals in the preprocess or for macros. I.E. - must be turned to _
			dk_define(HAVE_${argv1_macro})
		else()
			dk_set(${plugin} ON)
			dk_set(HAVE_${plugin} ON)
			dk_convertToCIdentifier(${plugin} plugin_macro) # In c/c++ we can't use certian symbals in the preprocess or for macros. I.E. - must be turned to _
			dk_define(HAVE_${plugin_macro})
		endif()
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()