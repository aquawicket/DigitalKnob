include_guard()
dk_load(dk_color)
dk_load(dk_getArgIdentifiers)
dk_load(dk_updateLogInfo)


macro(dk_appendCallstack entry)
	if(NOT DKCALLSTACK)
		set(DKCALLSTACK "*** CALLSTACK ****" CACHE INTERNAL "")
	endif()
	list(APPEND DKCALLSTACK entry)
endmacro()

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
		if(NOT CMAKE_CURRENT_FUNCTION_LIST_FILE)
			set(CMAKE_CURRENT_FUNCTION_LIST_FILE "unknown")
		endif()
		get_filename_component(filename ${CMAKE_CURRENT_FUNCTION_LIST_FILE} NAME)
		#dk_getFilename(${CMAKE_CURRENT_FUNCTION_LIST_FILE} filename)
		
		if(${ARGC} GREATER 0)
			#if(DKDEBUGFUNC_ENABLED)
			#	message(STATUS "${H_black}${filename}:${CMAKE_CURRENT_FUNCTION_LIST_LINE}->${CLR}${cyan}${CMAKE_CURRENT_FUNCTION}()${CLR}")
			#endif()
			#dk_appendCallstack("${H_black}${filename}:${CMAKE_CURRENT_FUNCTION_LIST_LINE}->${CLR}${cyan}${CMAKE_CURRENT_FUNCTION}()${CLR}")
		#else()
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
		endif()
	
		dk_updateLogInfo()
		dk_appendCallstack("${H_black}${filename}:${CMAKE_CURRENT_FUNCTION_LIST_LINE}->${CLR}${cyan}${CMAKE_CURRENT_FUNCTION}()${CLR}")
		if(DKDEBUGFUNC_ENABLED)
			message(STATUS "${H_black}${filename}:${CMAKE_CURRENT_FUNCTION_LIST_LINE}->${CLR}${cyan}${CMAKE_CURRENT_FUNCTION}(${argString})${CLR}")
		endif()
endmacro()
macro(DKDEBUGFUNC)
	dk_debugFunc(${ARGV})
endmacro()
