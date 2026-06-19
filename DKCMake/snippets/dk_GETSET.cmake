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


#########################################################################
# dk_GETSET()
#
#
function(GETSET)
    dk_debugFunc()

	#dk_echo("ARGN = ${ARGN}")
	if(ARGN) ############ SET ############
		#dk_echo("ARGN = ${ARGN}")
		set(GETSET "${ARGN}" PARENT_SCOPE)
		
	else() ############ GET ############
		set(GETSET "value returned by get" PARENT_SCOPE)
	endif()
	
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
   
	dk_echo("")
	dk_echo("##########################################")

	###### GET ######
	dk_echo("")
	dk_echo("dk_validate(GETSET \"GETSET()\")")
	dk_validate(GETSET "GETSET()")
    dk_printVar(GETSET)
	
	###### SET ######
	dk_echo("")
	dk_echo("dk_validate(GETSET \"GETSET(\"value assigned by set A\")\")")
	dk_validate(GETSET "GETSET(\"value assigned by set A\")")
	dk_printVar(GETSET)
	
	###### GET ######
	dk_echo("")
	dk_echo("GETSET()")
	GETSET()
    dk_printVar(GETSET)
	
	###### SET ######
	dk_echo("")
	dk_echo("GETSET(\"value assigned by set B\")")
	GETSET("value assigned by set B")
	dk_printVar(GETSET)
	
	###### GET ######
	dk_echo("")
	dk_echo("dk_validate(GETSET \"GETSET()\")")
	dk_validate(GETSET "GETSET()")
    dk_printVar(GETSET)
	
	###### SET ######
	dk_echo("")
	dk_echo("dk_validate(GETSET \"GETSET('value assigned by set C')\")")
	dk_validate(GETSET "GETSET('value assigned by set C')")
	dk_printVar(GETSET)
	
	###### GET ######
	dk_echo("")
	dk_echo("GETSET()")
	GETSET()
    dk_printVar(GETSET)
	
	###### SET ######
	dk_echo("")
	dk_echo("GETSET(\"value assigned by set D\")")
	GETSET("value assigned by set D")
	dk_printVar(GETSET)
endfunction()
DKTEST()
