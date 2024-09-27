include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

####################################################################
# dk_DKTOOLS_DIR()
#
#
function(dk_DKTOOLS_DIR)
    dk_debugFunc("\${ARGV}")
   
    if(DEFINED DKTOOLS_DIR)
		return()
	endif()
    
    dk_DIGITALKNOB_DIR()
    dk_set(DKTOOLS_DIR "${DIGITALKNOB_DIR}/DKTools")
    if(NOT EXISTS "${DKTOOLS_DIR}") 
		dk_makeDirectory("${DKTOOLS_DIR}")
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc("\${ARGV}")
 
    dk_DKTOOLS_DIR()
    dk_printVar(DKTOOLS_DIR)
endfunction()
