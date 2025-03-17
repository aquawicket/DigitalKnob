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
		set(ENV{DKDOWNLOAD_DIR} "${ARGV}")
		
	###### GET ######
	else()
		dk_validate(ENV{DIGITALKNOB_DIR} "dk_DIGITALKNOB_DIR()")
		set(ENV{DKDOWNLOAD_DIR} "$ENV{DIGITALKNOB_DIR}/download")
	endif()
	
	if(NOT EXISTS "$ENV{DKDOWNLOAD_DIR}") 
		dk_makeDirectory("$ENV{DKDOWNLOAD_DIR}")
	endif()
	
	dk_assertPath(ENV{DKDOWNLOAD_DIR})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
   
	dk_echo()
	dk_echo("Test Getting DKDOWNLOAD_DIR . . .")
	dk_DKDOWNLOAD_DIR()
	dk_printVar(ENV{DKDOWNLOAD_DIR})
	
	dk_echo()
	dk_echo("Test Setting DKDOWNLOAD_DIR . . .")
	dk_DKDOWNLOAD_DIR("C:/DK/download")
	dk_printVar(ENV{DKDOWNLOAD_DIR})
endfunction()
