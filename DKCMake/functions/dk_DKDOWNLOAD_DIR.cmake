#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

####################################################################
# dk_DKDOWNLOAD_DIR()
#
#
function(dk_DKDOWNLOAD_DIR)
    dk_debugFunc(0 1)
            
	###### SET ######
	if(ARGV)
		dk_set(DKDOWNLOAD_DIR "${ARGV}")
		
	###### GET ######
	else()
		dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
		dk_set(DKDOWNLOAD_DIR "${DIGITALKNOB_DIR}/download")
	endif()
	
	if(NOT EXISTS "${DKDOWNLOAD_DIR}") 
		dk_makeDirectory("${DKDOWNLOAD_DIR}")
	endif()
	
	dk_assertPath(DKDOWNLOAD_DIR)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
   
	dk_echo()
	dk_echo("Test Getting DKDOWNLOAD_DIR . . .")
	dk_DKDOWNLOAD_DIR()
	dk_printVar(DKDOWNLOAD_DIR)
	
	dk_echo()
	dk_echo("Test Setting DKDOWNLOAD_DIR . . .")
	dk_DKDOWNLOAD_DIR("C:/DK/download")
	dk_printVar(DKDOWNLOAD_DIR)
endfunction()
