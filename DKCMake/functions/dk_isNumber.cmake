#!/usr/bin/cmake -P
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
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
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
endfunction()
