include_guard()

###############################################################################
# dk_getArgIdentifiers(ARGV)
#  
#	Get the variable names from function parameters
#
#	@ARGV	- The ARGV data within a function that contains the parameter values
#
function(dk_getArgIdentifiers ARGV)
	#DKDEBUGFUNC(${ARGV})
	#message(STATUS "dk_getArgIdentifiers(${ARGV})")
	list(LENGTH ARGV ARGV_LENGTH)
	if(ARGV_LENGTH LESS 1)
		return()
	endif()
	get_cmake_property(varNames VARIABLES)
	set(index 0)
	unset(names)
	unset(ARGI)
	while(${index} LESS ${ARGV_LENGTH})
		list(APPEND names ARGV${index})
		set(ARGI${index} ARGV${index} CACHE INTERNAL "")
		foreach(varName ${varNames} REVERSE)
			if(ARGV${index} STREQUAL ${varName})
				if("ARGV${index}" STREQUAL "${varName}") #exclude variables with the same name like ARGV0
					continue()
				endif()
				if("ARGN" STREQUAL "${varName}")
					continue()
				endif()
				#if("CMAKE_CURRENT_FUNCTION" STREQUAL "${varName}")
				#	continue()
				#endif()
				dk_listReplace(names ARGV${index} ${varName})
				set(ARGI${index} ${varName} CACHE INTERNAL "")
				#message(STATUS "ARGI${index} == ${ARGI${index}}")
				break()
			endif()
		endforeach()
		math(EXPR index "${index}+1")
	endwhile()
	set(ARGI ${names} CACHE INTERNAL "")
endfunction()
