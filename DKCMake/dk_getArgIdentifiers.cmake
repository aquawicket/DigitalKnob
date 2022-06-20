include_guard()

###############################################################################
# dk_getArgIdentifiers(ARGV)
#  
#	Get the variable names from function parameters
#
#	@ARGV: The ARGV data within a function that contains the parameter values
#
function(dk_getArgIdentifiers ARGV)
	dk_call(dk_message "dk_getArgIdentifiers(${ARGV})")
	list(LENGTH ARGV ARGV_LENGTH)
	if(ARGV_LENGTH LESS 1)
		return()
	endif()
	get_cmake_property(variableNames VARIABLES)
	set(index 0)
	unset(names)
	unset(ARGI)
	while(${index} LESS ${ARGV_LENGTH})
		list(APPEND names ARGV${index})
		set(ARGI${index} ARGV${index} CACHE INTERNAL "")
		foreach(variableName ${variableNames} REVERSE)
			if(ARGV${index} STREQUAL ${variableName})
				if("ARGV${index}" STREQUAL "${variableName}") #exclude variables with the same name like ARGV0
					continue()
				endif()
				if("ARGN" STREQUAL "${variableName}")
					continue()
				endif()
				if("CMAKE_CURRENT_FUNCTION" STREQUAL "${variableName}")
					continue()
				endif()
				dk_call(dk_listReplace names ARGV${index} ${variableName})
				set(ARGI${index} ${variableName} CACHE INTERNAL "")
				#message(STATUS "ARGI${index} == ${ARGI${index}}")
				break()
			endif()
		endforeach()
		math(EXPR index "${index}+1")
	endwhile()
	set(ARGI ${names} CACHE INTERNAL "")
endfunction()
