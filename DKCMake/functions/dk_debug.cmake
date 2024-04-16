include_guard()

##################################################################################
# dk_debug(msg) PRINTVAR
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
function(dk_debug msg)
	#DKDEBUGFUNC(${ARGV})
	
	if(DKDEBUG_ENABLED)
		dk_get_option(PRINTVAR ${ARGV})
		dk_printvar(msg)
		
		if(DEFINED "${msg}")
			if(${msg} MATCHES "ENV{")
				set(ENV_VAR ${msg})
				string(REPLACE "ENV{" "" ENV_VAR "${ENV_VAR}")
				string(REPLACE "}" "" ENV_VAR "${ENV_VAR}")
				set(msg "${msg} = $ENV{${ENV_VAR}}")
			else()
				if(DEFINED "${${${msg}}}")
					set(msg "${msg} = ${${msg}} = ${${${msg}}} = ${${${${msg}}}}")
				endif()
				if(DEFINED "${${msg}}")
					set(msg "${msg} = ${${msg}} = ${${${msg}}}")
				endif()
				if(DEFINED "${msg}")
					set(msg "${msg} = ${${msg}}")
				endif()
			endif()
		else()
			set(msg "${msg} = UNDEFINED")
		endif()
		
		dk_updateLogInfo()
		message(DEBUG "${H_black}${STACK_HEADER}${CLR}${cyan} ${msg} ${CLR}")
	endif()
endfunction()
