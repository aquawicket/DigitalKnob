#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################

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
 
	#dk_getArg(0 _arg0_)
	
	dk_convertToCIdentifier("${ARGV0}" str_alphaNumeric)
	if(("${ARGV0}" STREQUAL "${str_alphaNumeric}") OR ("_${ARGV0}" STREQUAL "${str_alphaNumeric}"))
		set(dk_isAlphanumeric 1)
	else()
		set(dk_isAlphanumeric 0)
	endif()
	
	###### return ######
	set(dk_isAlphanumeric ${dk_isAlphanumeric} PARENT_SCOPE)
	if(${ARGC} GREATER 1)
		set(${output} ${dk_isAlphanumeric} PARENT_SCOPE)
	else()
		message("${dk_isAlphanumeric}")
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
