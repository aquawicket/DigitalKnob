include_guard()

##############################################################################
# dk_isNumber(variable RESULT)
# 
#	Test if a varaible is a number
#
#	@variable	- The variable to test
#	@RESULT: 	- True if the variable is a number, False if otherwise.
#
macro(dk_isNumber variable RESULT)
	DKDEBUGFUNC(${ARGV})
	if(${variable} MATCHES "^[0-9]+$")
		set(${RESULT} TRUE)
	else()
		set(${RESULT} FALSE)
	endif()
endmacro()
