include_guard()

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
	dk_debugFunc(${ARGV})
	
	message(STATUS "${cyan}##################################################################################################${clr}")
	message(STATUS "${cyan}   Variable watch: variable=${${variable}} access=${access} val=${val} 1st=${1st} stack=${stack}  ${clr}")
	message(STATUS "${cyan}##################################################################################################${clr}")
	dk_wait()
endmacro()
