#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

##############################################################################
# dk_isNumber(variable rtn_var)
# 
#	Test if a varaible is a number
#
#	@variable	- The variable to test
#	@rtn_var: 	- True if the variable is a number, False if otherwise.
#
function(dk_isNumber rtn_var)
	dk_debugFunc()
	
	set(${rtn_var} 0 PARENT_SCOPE)
	if(${ARGN} MATCHES "^[0-9]+(\\.[0-9]+)?$")
		set(${rtn_var} 1 PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_isNumber(result 0)
	dk_echo("0 = ${result}")
	dk_isNumber(result "0")
	dk_echo("\"0\" = ${result}")
	dk_isNumber(result '0')
	dk_echo("'0' = ${result}")
	
	dk_isNumber(result 000)
	dk_echo("000 = ${result}")
	dk_isNumber(result "000")
	dk_echo("\"000\" = ${result}")
	dk_isNumber(result '000')
	dk_echo("'000' = ${result}")
	
	dk_isNumber(result 0.0)
	dk_echo("0.0 = ${result}")
	dk_isNumber(result "0.0")
	dk_echo("\"0.0\" = ${result}")
	dk_isNumber(result '0.0')
	dk_echo("'0.0' = ${result}")
	
	dk_isNumber(result 000.000)
	dk_echo("000.000 = ${result}")
	dk_isNumber(result "000.000")
	dk_echo("\"000.000\" = ${result}")
	dk_isNumber(result '000.000')
	dk_echo("'000.000' = ${result}")
	dk_isNumber(result A)
	dk_echo("A = ${result}")
	dk_isNumber(result "A")
	dk_echo("\"A\" = ${result}")
	dk_isNumber(result 'A')
	dk_echo("'A' = ${result}")
	dk_isNumber(result "")
	dk_echo("\"\" = ${result}")
	dk_isNumber(result '')
	dk_echo("'' = ${result}")
endfunction()
