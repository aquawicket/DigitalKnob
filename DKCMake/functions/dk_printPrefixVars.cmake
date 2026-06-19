#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_printPrefixVars(_prefix) 
#
#	Example: dk_printPrefixVars("CMAKE_")
#
function(dk_printPrefixVars)
	dk_debugFunc(1)

	set(_prefix ${ARGV0})
    get_cmake_property(_vars VARIABLES)
    string(REGEX MATCHALL "(^|;)${_prefix}[A-Za-z0-9_]*" _matchedVars "${_vars}")
    set(_resultVars "")
    
	#dk_echo("###### ${_prefix}variables ######")
	foreach(_variable ${_matchedVars})
		dk_debug("${_variable} = ${${_variable}}")
		#if(EXISTS "${${_prefix}_Build_Dir}")
		#	dk_buildLog("${_variable} = ${${_variable}}" PATH "${${_prefix}_Build_Dir}")
		#elseif(EXISTS "${${_prefix}}")
		#	dk_buildLog("${_variable} = ${${_variable}}" PATH "${${_prefix}}")
		#endif()
		#list(APPEND _resultVars "${_variable}")
    endforeach()
	#message("")
	
	#foreach(_var IN LISTS _resultVars)   
    #endforeach()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_printPrefixVars("CMAKE")
	dk_printPrefixVars("DK")
	execute_process(COMMAND "${CMAKE_COMMAND}" "-E" "environment")
endfunction()