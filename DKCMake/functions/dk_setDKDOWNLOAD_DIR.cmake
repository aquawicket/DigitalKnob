include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

####################################################################
# dk_setDKDOWNLOAD_DIR()
#
#
function(dk_setDKDOWNLOAD_DIR)
    dk_debugFunc("\${ARGV}")
   
    if(DEFINED DKDOWNLOAD_DIR)
		return()
	endif()
    
    dk_setDIGITALKNOB_DIR()
    dk_set(DKDOWNLOAD_DIR "${DIGITALKNOB_DIR}/download")
    if(NOT EXISTS "${DKDOWNLOAD_DIR}") 
		dk_makeDirectory("${DKDOWNLOAD_DIR}")
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc("\${ARGV}")
 
    dk_setDKDOWNLOAD_DIR()
    dk_printVar(DKDOWNLOAD_DIR)
endfunction()
