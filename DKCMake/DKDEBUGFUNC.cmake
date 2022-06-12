##################################################################################
# DKDEBUGFUNC(${ARGV})
#	Prints the current file name, line number, function or macro and arguments
#	Place this at the first line of every function you want to see debug output for.
# 
#	Example:
#		function(MyFunction myArg1 myArg2)
#			DKDEBUGFUNC(${ARGV}) 
#			## user code
#		endfunction()
#
macro(DKDEBUGFUNC)
	if(ENABLE_DKDEBUGFUNC)
		#dk_getFilename(${CMAKE_CURRENT_FUNCTION_LIST_FILE} FILENAME)
		if(NOT CMAKE_CURRENT_FUNCTION_LIST_FILE)
			set(CMAKE_CURRENT_FUNCTION_LIST_FILE "unknown")
		endif()
		get_filename_component(FILENAME ${CMAKE_CURRENT_FUNCTION_LIST_FILE} NAME)
		DKLoad(Color)
		if(${ARGC} LESS 1)
			message(STATUS "${cyan}${FILENAME}:${CMAKE_CURRENT_FUNCTION_LIST_LINE}: ${CMAKE_CURRENT_FUNCTION}()${CLR}")
		else()
			set(argIndex 0)
			set(argString " {")
			DKCall(dk_getArgIdentifiers ${ARGV})
			foreach(arg ${ARGV})
				set(argString "${argString}\"${ARGI${argIndex}}\":\"${arg}\"")
				if(${argIndex} LESS ${ARGC})
					set(argString "${argString},  ")
				endif()
				math(EXPR argIndex "${argIndex}+1")
			endforeach()
			set(argString "${argString}} ")
			message(STATUS "${cyan}${FILENAME}:${CMAKE_CURRENT_FUNCTION_LIST_LINE}: ${CMAKE_CURRENT_FUNCTION}(${argString})${CLR}")
		endif()
	endif()
endmacro()
