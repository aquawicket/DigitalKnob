include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


##############################################################################
# dk_watchCallback(variable access val 1st stack)
# 
#	Description:  TODO
#
#	@variable	- The variable to watch
#	@access 	- TODO
#	@val 		- TODO
#   @1st 		- TODO
#	@stack 		- TODO
#
macro(dk_watchCallback variable access val lst stack)
	DKDEBUGFUNC(${ARGV})
	message(STATUS "${cyan}##################################################################################################${CLR}")
	message(STATUS "${cyan}   Variable watch: variable=${${variable}} access=${access} val=${val} 1st=${1st} stack=${stack}  ${CLR}")
	message(STATUS "${cyan}##################################################################################################${CLR}")
	dk_wait()
endmacro()
