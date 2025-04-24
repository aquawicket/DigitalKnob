#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

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
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##############################################################################
# dk_isNumber(arg)
# 
#	Test if (arg) is a number
#
#	@arg		 	- The argument to test
#	@dk_isNumber 	- 1 if arg is a number, 0 if otherwise.
#
function(dk_isNumber)
	dk_debugFunc()
	
	dk_getArg(0 _arg0_)
	
	if(${_arg0_} MATCHES "^[0-9]+(\\.[0-9]+)?$")
		set(dk_isNumber 1 PARENT_SCOPE)
	else()
		set(dk_isNumber 0 PARENT_SCOPE)
>>>>>>> Development
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
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
=======
	dk_debugFunc(0)
	
	dk_isNumber(0)
	dk_echo("0 = ${dk_isNumber}")
	dk_isNumber("0")
	dk_echo("\"0\" = ${dk_isNumber}")
	dk_isNumber('0')
	dk_echo("'0' = ${dk_isNumber}")
	
	dk_isNumber(000)
	dk_echo("000 = ${dk_isNumber}")
	dk_isNumber("000")
	dk_echo("\"000\" = ${dk_isNumber}")
	dk_isNumber('000')
	dk_echo("'000' = ${dk_isNumber}")
	
	dk_isNumber(0.0)
	dk_echo("0.0 = ${dk_isNumber}")
	dk_isNumber("0.0")
	dk_echo("\"0.0\" = ${dk_isNumber}")
	dk_isNumber('0.0')
	dk_echo("'0.0' = ${dk_isNumber}")
	
	dk_isNumber(000.000)
	dk_echo("000.000 = ${dk_isNumber}")
	dk_isNumber("000.000")
	dk_echo("\"000.000\" = ${dk_isNumber}")
	dk_isNumber('000.000')
	dk_echo("'000.000' = ${dk_isNumber}")
	dk_isNumber(A)
	dk_echo("A = ${dk_isNumber}")
	dk_isNumber("A")
	dk_echo("\"A\" = ${dk_isNumber}")
	dk_isNumber('A')
	dk_echo("'A' = ${dk_isNumber}")
	dk_isNumber("")
	dk_echo("\"\" = ${dk_isNumber}")
	dk_isNumber('')
	dk_echo("'' = ${dk_isNumber}")
>>>>>>> Development
endfunction()
