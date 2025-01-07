#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_getArgIdentifiers(ARGV)
#  
#	Get the variable names from function parameters
#
#	@ARGV	- The ARGV data within a function that contains the parameter values
#
function(dk_getArgIdentifiers ARGV)
	dk_debugFunc()		# called in dk_debugFunc

	list(LENGTH ARGV ARGV_LENGTH)
	if(ARGV_LENGTH LESS 1)
		return()
	endif()
	get_cmake_property(varNames VARIABLES)
	set(index 0)
	dk_unset(names)
	dk_unset(ARGI)
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
				#dk_echo(STATUS "ARGI${index} == ${ARGI${index}}")
				break()
			endif()
		endforeach()
		math(EXPR index "${index}+1")
	endwhile()
	set(ARGI ${names} CACHE INTERNAL "")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
