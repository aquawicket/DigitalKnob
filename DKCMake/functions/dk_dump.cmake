include_guard()

##############################################################################
# dk_dump(variable)
# 
#	Print the contents of a variable to the screen
#
#	@variable	- The variable to print to the screen. Without variable brackets ${ }'
#
macro(dk_dump variable)
	DKDEBUGFUNC(${ARGV})
	message(STATUS "\n${cyan}############################### Variable DUMP ##############################################${CLR}")	
	if(CMAKE_CURRENT_FUNCTION_LIST_FILE)
		dk_getFilename(${CMAKE_CURRENT_FUNCTION_LIST_FILE} FILENAME)
	endif()
	if(NOT DEFINED ${variable})
		dk_error("variable not defined. The syntax may be incorrect if using brackets - > \$ { variable } ")
		dk_info("${CLR}${green} dk_dump(variable): <- CORRECT SYNTAX")
	else()
		dk_info("${FILENAME}:${CMAKE_CURRENT_FUNCTION_LIST_LINE} -> ${CMAKE_CURRENT_FUNCTION}(${ARGV})")
		list(LENGTH ${variable} variableLength)
		if(${variableLength} GREATER 1)
			set(variableType "list")
		elseif(variable MATCHES "^[0-9]+$")
			set(variableType "number")
		else()
			set(variableType "string")
		endif()
		message(STATUS "${cyan}   NAME:    ${variable} ${CLR}")
		message(STATUS "${cyan}   TYPE:    ${variableType} ${CLR}")
		message(STATUS "${cyan}   LENGTH:  ${variableLength} ${CLR}")
		message(STATUS "${cyan}   VALUE:   ${${variable}} ${CLR}")
		message(STATUS "${cyan}############################################################################################${CLR}\n")
	endif()
	#dk_wait()
endmacro()
