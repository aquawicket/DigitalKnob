include_guard()

##################################################################################
# dk_printvar(var)
#
#	If the msg is a defined variable, print it's name and value
#	@var	- The variable name to print
#
macro(dk_printvar var)
	if(PRINTVAR)
		if(DEFINED "${${var}}")
			if(${${var}} MATCHES "ENV{")
				set(ENV_VAR ${${var}})
				string(REPLACE "ENV{" "" ENV_VAR "${ENV_VAR}")
				string(REPLACE "}" "" ENV_VAR "${ENV_VAR}")
				set(${var} "${${var}} = $ENV{${ENV_VAR}}")
			else()
				if(DEFINED "${${${${var}}}}")
					set(${var} "${${var}} = ${${${var}}} = ${${${${var}}}} = ${${${${${var}}}}}")
				endif()
				if(DEFINED "${${${var}}}")
					set(${var} "${${var}} = ${${${var}}} = ${${${${var}}}}")
				endif()
				if(DEFINED "${${var}}")
					set(${var} "${${var}} = ${${${var}}}")
				endif()
			endif()
		else()
			#set(${var} "${${var}} = UNDEFINED")
			#message("returning from ${CMAKE_CURRENT_FUNCTION}()")
			#return() #return out out calling function
		endif()
	endif()
endmacro()
