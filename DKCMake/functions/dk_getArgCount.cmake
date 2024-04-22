include_guard()

###############################################################################
# dk_get_arg_count(RESULT args)
#
#	@RESULT  - Returns the number of args received (minus the result argument)
#	@args 	 - a variable number of input arguments
#
function(dk_get_arg_count RESULT)
	math(EXPR ARGC "${ARGC}-1")
	set(${RESULT} ${ARGC} PARENT_SCOPE)
endfunction()