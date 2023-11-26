include_guard()

##################################################################################
# dk_verbose(msg)
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
macro(dk_verbose msg)
	if(DKVERBOSE_ENABLED)
		#message(STATUS "dk_verbose(${ARGV})")
		string(REPLACE " " "" var ${msg})
		dk_updateLogInfo()
		if(${var})
			message(STATUS "${H_black}${STACK_HEADER}${CLR}${blue} { \"${var}\" : \"${${var}}\" } ${CLR}")
		else()
			message(STATUS "${H_black}${STACK_HEADER}${CLR}${blue} ${msg} ${CLR}")
		endif()
	endif()
endmacro()
