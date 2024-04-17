include_guard()

###############################################################################
# dk_is_list(result arg(s))
#
#	@RESULT     - returns true is the arg(s) is a list, false if not
#	@arg		- The input argument(s) to be examined 
#
function(dk_is_list RESULT)
	#DKDEBUGFUNC(${ARGV})
	
	math(EXPR ARGC "${ARGC}-1")  

	if(NOT "${${ARGN}}" STREQUAL "")
		dk_get_arg_count(count ${${ARGN}})
		dk_debug(count)
		if(${count} GREATER 1)
			dk_debug("${ARGN} is a LIST variable")
			set(${RESULT} TRUE PARENT_SCOPE)
		elseif(${count} GREATER 0)
			dk_debug("${ARGN} is a STRING variable")
			set(${RESULT} FALSE PARENT_SCOPE)
		else()
			dk_debug("${ARGN} is INVALID!")
			set(${RESULT} FALSE PARENT_SCOPE)
		endif()
		return()
	endif()

	if(NOT "${ARGN}" STREQUAL "")
		dk_get_arg_count(count ${ARGN})
		dk_debug(count)
		if(${count} GREATER 1)
			dk_debug("${ARGN} is a LIST value")
			set(${RESULT} TRUE PARENT_SCOPE)
		elseif(${count} GREATER 0)
			dk_debug("${ARGN} is a STRING value")
			set(${RESULT} FALSE PARENT_SCOPE)
		else()
			dk_debug("${ARGN} is INVALID!")
			set(${RESULT} FALSE PARENT_SCOPE)
		endif()
		return()
	else()
		dk_debug("${ARGN} is invalid")
		set(${RESULT} FALSE PARENT_SCOPE)
	endif()
endfunction()