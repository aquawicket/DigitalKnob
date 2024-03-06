include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


##################################################################################
# dk_printvar(var)
#
#	If the msg is a defined variable, print it's name and value
#	@var	- The variable name to print
#
macro(dk_printvar var)
	if(PRINTVAR)
		if(DEFINED "${${var}}")
			set(${var} "${${var}} = ${${${var}}}")
		else()
			return() #return out out calling function
		endif()
	endif()
endmacro()
