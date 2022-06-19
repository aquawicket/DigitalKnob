###############################################################################
# dk_getArgIdentifiers(ARGV)
#  
#	Get the variable names from function parameters
#
#	@ARGV: The ARGV data within a function that contains the parameter values
#
function(dk_getArgIdentifiers ARGV)
	#message(STATUS "dk_getArgIdentifiers(${ARGV})")
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
				if(NOT "ARGV${index}" STREQUAL "${variableName}") #exclude variables with the same name like ARGV0
					dk_call(dk_listReplace names ARGV${index} ${variableName})
					set(ARGI${index} ${variableName} CACHE INTERNAL "")
					#message(STATUS "ARGI${index} == ${ARGI${index}}")
					break()
				endif()
			endif()
		endforeach()
		math(EXPR index "${index}+1")
	endwhile()
	set(ARGI ${names} CACHE INTERNAL "")
endfunction()
