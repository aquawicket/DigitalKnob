include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_printVar(var)
#
#	If the msg is a defined variable, print it's name and value
#	@var	- The variable name to print
#
function(dk_printVar var)
	dk_debugFunc(${ARGV})
	
	if(DEFINED "${var}")
		if("${var}" MATCHES "ENV{") # ENV variables
			set(ENV_VAR ${var})
			dk_replaceAll("${ENV_VAR}"  "ENV{"  ""  ENV_VAR)
			dk_replaceAll("${ENV_VAR}"  "}"  ""  ENV_VAR)
			message("${BLUE}${var} =${blue} '$ENV{${ENV_VAR}}'${clr}")
		else()	# regular variables
			if(DEFINED "${${${${var}}}}")
				message("${BLUE}${var} =${blue} ${${var}} = ${${${var}}} = ${${${${var}}}} = '${${${${${var}}}}}'${clr}")
			elseif(DEFINED "${${${var}}}")
				message("${BLUE}${var} =${blue} ${${var}} = ${${${var}}} = '${${${${var}}}}'${clr}")
			elseif(DEFINED "${${var}}")
				message("${BLUE}${var} =${blue} ${${var}} = '${${${var}}}'${clr}")
			else()
				message("${BLUE}${var} =${blue} '${${var}}'${clr}")
			endif()
		endif()
	else()  # Undefined
		message("${BLUE}${var} =${red} UNDEFINED${clr}")
		return()
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	set(myVariable "this is the value of myVariable")
	dk_printVar(myVariable)
	
endfunction()
