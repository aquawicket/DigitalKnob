include_guard()

##################################################################################
# dk_printVar(var)
#
#	If the msg is a defined variable, print it's name and value
#	@var	- The variable name to print
#
function(dk_printVar var)
	#dk_debugFunc(${ARGV})
	
	if(DEFINED "${var}")
		if("${var}" MATCHES "ENV{") # ENV variables
			set(ENV_VAR ${var})
			string(REPLACE "ENV{" "" ENV_VAR "${ENV_VAR}")
			string(REPLACE "}" "" ENV_VAR "${ENV_VAR}")
			dk_debug("${var} = '$ENV{${ENV_VAR}}'")
		else()	# regular variables
			if(DEFINED "${${${${var}}}}")
				dk_debug(${var} "${${var}} = ${${${var}}} = ${${${${var}}}} = '${${${${${var}}}}}'")
			endif()
			if(DEFINED "${${${var}}}")
				dk_debug(${var} "${${var}} = ${${${var}}} = '${${${${var}}}}'")
			endif()
			if(DEFINED "${${var}}")
				dk_debug(${var} "${${var}} = '${${${var}}}'")
			endif()
			dk_debug("${var} = ${${var}}")
		endif()
	else()  # Undefined
		dk_debug("${var} = NOT DEFINED")
		return()
	endif()
#	if(DEFINED "${${var}}")
#		if("${${var}}" MATCHES "ENV{")

#		else()
#			if(DEFINED "${${${${var}}}}")
#				set(${var} "${${var}} = ${${${var}}} = ${${${${var}}}} = '${${${${${var}}}}}'")
#			endif()
#			if(DEFINED "${${${var}}}")
#				set(${var} "${${var}} = ${${${var}}} = '${${${${var}}}}'")
#			endif()
#			if(DEFINED "${${var}}")
#				set(${var} "${${var}} = '${${${var}}}'")
#			endif()
#		endif()
#	else()
#		#set(${var} "${${var}} = UNDEFINED")
#		#message("returning from ${CMAKE_CURRENT_FUNCTION}()")
#		#return() #return out out calling function
#	endif()
endfunction()
