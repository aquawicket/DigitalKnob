#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_GETSET()
#
#
function(GETSET)
    dk_debugFunc()

	#message("ARGN = ${ARGN}")
	if(ARGN) ############ SET ############
		#message("ARGN = ${ARGN}")
		set(GETSET "${ARGN}" PARENT_SCOPE)
		
	else() ############ GET ############
		set(GETSET "value returned by get" PARENT_SCOPE)
	endif()
	
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
   
	message("")
	message("##########################################")

	###### GET ######
	message("")
	message("dk_validate(GETSET \"GETSET()\")")
	dk_validate(GETSET "GETSET()")
    dk_printVar(GETSET)
	
	###### SET ######
	message("")
	message("dk_validate(GETSET \"GETSET(\"value assigned by set A\")\")")
	dk_validate(GETSET "GETSET(\"value assigned by set A\")")
	dk_printVar(GETSET)
	
	###### GET ######
	message("")
	message("GETSET()")
	GETSET()
    dk_printVar(GETSET)
	
	###### SET ######
	message("")
	message("GETSET(\"value assigned by set B\")")
	GETSET("value assigned by set B")
	dk_printVar(GETSET)
	
	###### GET ######
	message("")
	message("dk_validate(GETSET \"GETSET()\")")
	dk_validate(GETSET "GETSET()")
    dk_printVar(GETSET)
	
	###### SET ######
	message("")
	message("dk_validate(GETSET \"GETSET('value assigned by set C')\")")
	dk_validate(GETSET "GETSET('value assigned by set C')")
	dk_printVar(GETSET)
	
	###### GET ######
	message("")
	message("GETSET()")
	GETSET()
    dk_printVar(GETSET)
	
	###### SET ######
	message("")
	message("GETSET(\"value assigned by set D\")")
	GETSET("value assigned by set D")
	dk_printVar(GETSET)
endfunction()
DKTEST()
