include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

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
			message("${Blue}${var} =${blue} '$ENV{${ENV_VAR}}'${clr}")
		else()	# regular variables
			if(DEFINED "${${${${var}}}}")
				message("${Blue}${var} =${blue} ${${var}} = ${${${var}}} = ${${${${var}}}} = '${${${${${var}}}}}'${clr}")
			elseif(DEFINED "${${${var}}}")
				message("${Blue}${var} =${blue} ${${var}} = ${${${var}}} = '${${${${var}}}}'${clr}")
			elseif(DEFINED "${${var}}")
				message("${Blue}${var} =${blue} ${${var}} = '${${${var}}}'${clr}")
			else()
				message("${Blue}${var} =${blue} '${${var}}'${clr}")
			endif()
		endif()
	else()  # Undefined
		message("${Blue}${var} =${red} UNDEFINED${clr}")
		return()
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction(DKTEST)
