#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##############################################################################
# dk_isNumber(variable rtn_var)
# 
#	Test if a varaible is a number
#
#	@variable	- The variable to test
#	@rtn_var: 	- True if the variable is a number, False if otherwise.
#
function(dk_isNumber variable rtn_var)
	dk_debugFunc("\${ARGV}")
	
	
	if(${variable} MATCHES "^[0-9]+$")
		set(isNumber TRUE)
	else()
		set(isNumber FALSE)
	endif()
	
	#dk_printVar(isNumber)
	set(${rtn_var} ${isNumber} PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_isNumber(1 result)
	dk_info("${result}")
	dk_isNumber("1" result)
	dk_info("${result}")
	dk_isNumber('1' result)
	dk_info("${result}")
	dk_isNumber(123 result)
	dk_info("${result}")
	dk_isNumber("123" result)
	dk_info("${result}")
	dk_isNumber('123' result)
	dk_info("${result}")
	dk_isNumber(A result)
	dk_info("${result}")
	dk_isNumber("A" result)
	dk_info("${result}")
	dk_isNumber('A' result)
	dk_info("${result}")
	dk_isNumber("" result)
	dk_info("${result}")
	dk_isNumber('' result)
	dk_info("${result}")
endfunction()
