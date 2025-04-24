#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_printPrefixVars(_prefix) 
#
#	Example: dk_printPrefixVars("CMAKE_")
#
function(dk_printPrefixVars _prefix)
	dk_debugFunc()

    get_cmake_property(_vars VARIABLES)
    string(REGEX MATCHALL "(^|;)${_prefix}[A-Za-z0-9_]*" _matchedVars "${_vars}")
    set(_resultVars "")
    foreach(_variable ${_matchedVars})
		list(APPEND _resultVars "${_variable}")
    endforeach()

	foreach(_var IN LISTS _resultVars)
        dk_echo(STATUS "${_var} = ${${_var}}")
    endforeach()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()