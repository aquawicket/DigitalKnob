#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
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
