include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

####################################################################
# dk_DKTEMP_DIR()
#
#
function(dk_DKTEMP_DIR)
    dk_debugFunc("\${ARGV}")

	if(DEFINED DKTEMP_DIR)
		return()
	endif()
	
	if(NOT EXISTS "${DKTEMP_DIR}")
		dk_set(DKTEMP_DIR "$ENV{TMP}")
	endif()
	if(NOT EXISTS "${DKTEMP_DIR}")     
		dk_set(DKTEMP_DIR "$ENV{TMPDIR}")
	endif()
	if(NOT EXISTS "${DKTEMP_DIR}")     
		dk_set(DKTEMP_DIR "$ENV{TMP_DIR}")
	endif()
	if(NOT EXISTS "${DKTEMP_DIR}")
		dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
		dk_set(DKTEMP_DIR "${DIGITALKNOB_DIR}")
	endif()
	
	if(EXISTS "${DKTEMP_DIR}")
		dk_set(DKTEMP_DIR "${DKTEMP_DIR}/.dk")
		dk_makeDirectory("${DKTEMP_DIR}")
	endif()
	
	if(NOT EXISTS "${DKTEMP_DIR}")
		dk_fatal("unable to set .dk directory")
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc("\${ARGV}")
 
    dk_DKTEMP_DIR()
    dk_printVar(DKTEMP_DIR)
endfunction()
