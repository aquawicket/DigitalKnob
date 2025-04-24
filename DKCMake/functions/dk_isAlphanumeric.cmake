#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_isAlphanumeric(string rtn_var)
#
#  https://stackoverflow.com/a/17584764
#
function(dk_isAlphanumeric str rtn_var)
    dk_debugFunc()
 
	dk_convertToCIdentifier("${str}" str_alphaNumeric)
	#dk_debug("${str} -> ${str_alphaNumeric}")
	if(("${str}" STREQUAL "${str_alphaNumeric}") OR ("_${str}" STREQUAL "${str_alphaNumeric}"))
		set(${rtn_var} TRUE PARENT_SCOPE)
		return()
	endif()
	set(${rtn_var} FALSE PARENT_SCOPE)
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
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
>>>>>>> Development
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
 
<<<<<<< HEAD
    dk_isAlphanumeric(69 result) 			#&& dk_call dk_info "is alphanumeric" || dk_call dk_info "is NOT alphanumeric"
	dk_printVar(result)
	
    set(myNumber 42)
    dk_isAlphanumeric(${myNumber} result) 	#&& dk_call dk_info "is alphanumeric" || dk_call dk_info "is NOT alphanumeric"
	dk_printVar(result)
	
    dk_isAlphanumeric(myNumber result)   	#&& dk_call dk_info "is alphanumeric" || dk_call dk_info "is NOT alphanumeric"  &:: FIXME
	dk_printVar(result)
	
    dk_isAlphanumeric(0 result)         	#&& dk_call dk_info "is alphanumeric" || dk_call dk_info "is NOT alphanumeric"
	dk_printVar(result)
	
    dk_isAlphanumeric(1 result)          	#&& dk_call dk_info "is alphanumeric" || dk_call dk_info "is NOT alphanumeric"
	dk_printVar(result)
	
    dk_isAlphanumeric(1.23 result)       	#&& dk_call dk_info "is alphanumeric" || dk_call dk_info "is NOT alphanumeric"
	dk_printVar(result)
	
    dk_isAlphanumeric(-42 result)        	#&& dk_call dk_info "is alphanumeric" || dk_call dk_info "is NOT alphanumeric"
	dk_printVar(result)
	
    dk_isAlphanumeric("36" result)       	#&& dk_call dk_info "is alphanumeric" || dk_call dk_info "is NOT alphanumeric"
	dk_printVar(result)
	
    dk_isAlphanumeric("36a" result)      	#&& dk_call dk_info "is alphanumeric" || dk_call dk_info "is NOT alphanumeric"
	dk_printVar(result)
	
    dk_isAlphanumeric(word result)       	#&& dk_call dk_info "is alphanumeric" || dk_call dk_info "is NOT alphanumeric"
	dk_printVar(result)
	
    dk_isAlphanumeric(123456789 result)  	#&& dk_call dk_info "is alphanumeric" || dk_call dk_info "is NOT alphanumeric"
	dk_printVar(result)
	
    dk_isAlphanumeric(myArray[0] result) 	#&& dk_call dk_info "is alphanumeric" || dk_call dk_info "is NOT alphanumeric"
	dk_printVar(result)
=======
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
>>>>>>> Development
endfunction()
