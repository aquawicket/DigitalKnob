include_guard()

###############################################################################
# dk_print_prefix_vars(_prefix) 
#
#	Example: dk_print_prefix_vars("CMAKE_")
#
function(dk_print_prefix_vars _prefix)
    get_cmake_property(_vars VARIABLES)
    string(REGEX MATCHALL "(^|;)${_prefix}[A-Za-z0-9_]*" _matchedVars "${_vars}")
    set(_resultVars "")
    foreach(_variable ${_matchedVars})
		list(APPEND _resultVars "${_variable}")
    endforeach()

	foreach(_var IN LISTS _resultVars)
        message(STATUS "${_var} = ${${_var}}")
    endforeach()
endfunction()