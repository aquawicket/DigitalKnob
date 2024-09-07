include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_append(<variable> <value>)
#
#	<variable>	- The name of a variable to declare
#	<value>		- The value to add to the variable.
#
function(dk_append variable) #value
	dk_debugFunc("\${ARGV}")
	
	if(NOT ARGN)
		dk_warning("dk_append(${variable}) ARGN:${ARGN} is invalid")
		return()
	endif()
	if(${variable})
		dk_set(${variable} ${${variable}} ${ARGN})
	else()
		dk_set(${variable} ${ARGN})
	endif()
	
endfunction()
#dk_createOsMacros("dk_append")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_append(MyVar "abc")
	dk_append(MyVar "123")
	dk_append(MyVar "def")
	dk_append(MyVar "456")
	dk_printVar(MyVar)
endfunction()