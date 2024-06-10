include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

##############################################################################
# dk_isNumber(variable RESULT)
# 
#	Test if a varaible is a number
#
#	@variable	- The variable to test
#	@RESULT: 	- True if the variable is a number, False if otherwise.
#
function(dk_isNumber variable RESULT)
	dk_debugFunc(${ARGV})
	
	if(${variable} MATCHES "^[0-9]+$")
		set(${RESULT} TRUE PARENT_SCOPE)
	else()
		set(${RESULT} FALSE PARENT_SCOPE)
	endif()
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)
