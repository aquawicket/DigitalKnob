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
# dk_printPrefixVars(_prefix) 
#
#	Example: dk_printPrefixVars("CMAKE_")
#
function(dk_printPrefixVars _prefix)
	dk_debugFunc()

    get_cmake_property(_vars VARIABLES)
    string(REGEX MATCHALL "(^|;)${_prefix}[A-Za-z0-9_]*" _matchedVars "${_vars}")
    set(_resultVars "")
    
	message("###### ${_prefix}variables ######")
	foreach(_variable ${_matchedVars})
		dk_echo("${_var} = ${${_var}}")
		#list(APPEND _resultVars "${_variable}")
    endforeach()
	message("")
	
	#foreach(_var IN LISTS _resultVars)   
    #endforeach()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_printPrefixVars("CMAKE_")
endfunction()