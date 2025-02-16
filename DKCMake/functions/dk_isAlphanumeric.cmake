#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

####################################################################
# dk_isAlphanumeric(arg)
#
#	Test if (arg) is alphanumeric
#
#	@arg				- The argument to test
#	@dk_isAlphanumeric	- 1 if arg is alphanumric, 0 if otherwise.
#
function(dk_isAlphanumeric)
    dk_debugFunc()
 
	dk_getArg(0 _arg0_)
	
	dk_convertToCIdentifier("${_arg0_}" str_alphaNumeric)
	if(("${_arg0_}" STREQUAL "${str_alphaNumeric}") OR ("_${_arg0_}" STREQUAL "${str_alphaNumeric}"))
		set(dk_isAlphanumeric 1 PARENT_SCOPE)
	else()
		set(dk_isAlphanumeric 0 PARENT_SCOPE)
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
 
    dk_isAlphanumeric(69)
	dk_echo("69 = ${dk_isAlphanumeric}")
	
    set(myNumber 42)
    dk_isAlphanumeric(${myNumber})
	dk_echo("${myNumber} = ${dk_isAlphanumeric}")
	
    dk_isAlphanumeric(myNumber)
	dk_echo("myNumber = ${dk_isAlphanumeric}")
	
    dk_isAlphanumeric(0)
	dk_echo("0 = ${dk_isAlphanumeric}")
	
    dk_isAlphanumeric(1)
	dk_echo("1 = ${dk_isAlphanumeric}")
	
    dk_isAlphanumeric(1.23)
	dk_echo("1.23 = ${dk_isAlphanumeric}")
	
    dk_isAlphanumeric(-42)
	dk_echo("-42 = ${dk_isAlphanumeric}")
	
    dk_isAlphanumeric("36")
	dk_echo("\"36\" = ${dk_isAlphanumeric}")
	
    dk_isAlphanumeric("36a")
	dk_echo("\"36a\" = ${dk_isAlphanumeric}")
	
    dk_isAlphanumeric(word)
	dk_echo("word = ${dk_isAlphanumeric}")
	
    dk_isAlphanumeric(123456789)
	dk_echo("123456789 = ${dk_isAlphanumeric}")
	
    dk_isAlphanumeric(myArray[0])
	dk_echo("myArray[0] = ${dk_isAlphanumeric}")
endfunction()
