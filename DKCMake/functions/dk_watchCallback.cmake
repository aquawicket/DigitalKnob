include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
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
	#dk_debugFunc(${ARGV})
	
	message("${cyan}##################################################################################################${clr}")
	message("${cyan}   Variable watch:  ${clr}")
	message("${cyan}   variable = ${variable} ${clr}")
	message("${cyan}   access   = ${access} ${clr}")
	message("${cyan}   val      = ${val} ${clr}")
	message("${cyan}   1st      = ${1st} ${clr}")
	message("${cyan}   stack    = ${stack} ${clr}")
	message("${cyan}##################################################################################################${clr}")
	#dk_wait()
endmacro()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction(DKTEST)