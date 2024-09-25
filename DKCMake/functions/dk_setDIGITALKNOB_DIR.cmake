include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

####################################################################
# dk_setDIGITALKNOB_DIR()
#
#
function(dk_setDIGITALKNOB_DIR)
    dk_debugFunc("\${ARGV}")

    if(DEFINED DIGITALKNOB_DIR)
		return()
	endif()
            
    dk_setDKHOME_DIR()
    #if(NOT DEFINED DIGITALKNOB set "DIGITALKNOB=D i g i t a l K n o b")
    if(NOT DEFINED DIGITALKNOB)
		dk_set(DIGITALKNOB "digitalknob")
	endif()
    dk_set(DIGITALKNOB_DIR "${DKHOME_DIR}/${DIGITALKNOB}")
    if(NOT EXISTS "${DIGITALKNOB_DIR}")
		dk_makeDirectory("${DIGITALKNOB_DIR}")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc("\${ARGV}")
   
	dk_setDIGITALKNOB_DIR()
    dk_printVar(DIGITALKNOB_DIR)
endfunction()
