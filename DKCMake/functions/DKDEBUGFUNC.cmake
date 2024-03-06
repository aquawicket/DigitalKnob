include_guard()

##################################################################################
# dk_debugFunc(${ARGV})
#
#	Prints the current file name, line number, function or macro and arguments
#	Place this at the first line of every function you want to see debug output for.
# 
#	Example:
#		function(MyFunction myArg1 myArg2)
#			dk_debugFunc(${ARGV}) 
#			## user code
#		endfunction()
#
macro(dk_debugFunc)
	#DKDEBUGFUNC(${ARGV})
	if(DKDEBUGFUNC_ENABLED)
		if(NOT CMAKE_CURRENT_FUNCTION_LIST_FILE)
			set(CMAKE_CURRENT_FUNCTION_LIST_FILE "unknown")
		endif()
		get_filename_component(FILENAME ${CMAKE_CURRENT_FUNCTION_LIST_FILE} NAME)
		#dk_getFilename(${CMAKE_CURRENT_FUNCTION_LIST_FILE} FILENAME)
		if(${ARGC} LESS 1)
			dk_updateLogInfo()
			message(STATUS "${H_black}${FILENAME}:${CMAKE_CURRENT_FUNCTION_LIST_LINE}->${CLR}${cyan}${CMAKE_CURRENT_FUNCTION}()${CLR}")
		else()
			set(argIndex 1)
			set(argString " {")
			dk_getArgIdentifiers(${ARGV})
			foreach(arg ${ARGV})
				set(argString "${argString}\"${ARGI${argIndex}}\":\"${arg}\"")
				if(${argIndex} LESS ${ARGC})
					set(argString "${argString},  ")
				endif()
				math(EXPR argIndex "${argIndex}+1")
			endforeach()
			set(argString "${argString}} ")
			message(STATUS "${H_black}${FILENAME}:${CMAKE_CURRENT_FUNCTION_LIST_LINE}->${CLR}${cyan}${CMAKE_CURRENT_FUNCTION}(${argString})${CLR}")
		endif()
	endif()
endmacro()
macro(DKDEBUGFUNC)
	dk_debugFunc(${ARGV})
endmacro()