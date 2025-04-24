#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(TO_CMAKE_PATH "$ENV{USERPROFILE}$ENV{HOME}/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "$ENV{DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
