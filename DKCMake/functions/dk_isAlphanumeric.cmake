#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_isAlphanumeric(string rtn_var)
#
#  https://stackoverflow.com/a/17584764
#
function(dk_isAlphanumeric str rtn_var)
    dk_debugFunc("\${ARGV}")
 
	dk_convertToCIdentifier("${str}" str_alphaNumeric)
	#dk_debug("${str} -> ${str_alphaNumeric}")
	if(("${str}" STREQUAL "${str_alphaNumeric}") OR ("_${str}" STREQUAL "${str_alphaNumeric}"))
		set(${rtn_var} TRUE PARENT_SCOPE)
		return()
	endif()
	set(${rtn_var} FALSE PARENT_SCOPE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc("\${ARGV}")
 
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
endfunction()
