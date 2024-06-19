include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_isList(result arg(s))
#
#	@rtn_var     - returns true is the arg(s) is a list, false if not
#	@arg		- The input argument(s) to be examined 
#
function(dk_isList rtn_var)
	dk_debugFunc(${ARGV})
	
	math(EXPR ARGC "${ARGC}-1")  

	if(NOT "${${ARGN}}" STREQUAL "")
		dk_getArgCount(count ${${ARGN}})
		#dk_printVar(count)
		if(${count} GREATER 1)
			dk_debug("${ARGN} is a LIST variable")
			set(isList TRUE)
		elseif(${count} GREATER 0)
			dk_debug("${ARGN} is a STRING variable")
			set(isList FALSE)
		else()
			dk_debug("${ARGN} is INVALID!")
			set(isList FALSE)
		endif()
		
		dk_printVar(isList)
		set(${rtn_var} ${isList} PARENT_SCOPE)
		return()
	endif()

	if(NOT "${ARGN}" STREQUAL "")
		dk_getArgCount(count ${ARGN})
		#dk_printVar(count)
		if(${count} GREATER 1)
			dk_debug("${ARGN} is a LIST value")
			set(isList TRUE)
		elseif(${count} GREATER 0)
			dk_debug("${ARGN} is a STRING value")
			set(isList FALSE)
		else()
			dk_debug("${ARGN} is INVALID!")
			set(isList FALSE)
		endif()
		
		dk_printVar(isList)
		set(${rtn_var} ${isList} PARENT_SCOPE)
		return()
	else()
		dk_debug("${ARGN} is invalid")
		set(isList FALSE)
		dk_printVar(isList)
		set(${rtn_var} ${isList} PARENT_SCOPE)
	endif()
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction(DKTEST)