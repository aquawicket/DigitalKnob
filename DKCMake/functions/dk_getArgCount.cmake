include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_get_arg_count(rtn_var args)
#
#	@rtn_var  - Returns the number of args received (minus the result argument)
#	@args 	 - a variable number of input arguments
#
function(dk_get_arg_count rtn_var)
	dk_debugFunc(${ARGV})
	
	math(EXPR ARGC "${ARGC}-1")
	dk_printVar(ARGC)
	set(${rtn_var} ${ARGC} PARENT_SCOPE)
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)