include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

####################################################################
# dk_DKCACHE_DIR()
#
#
function(dk_DKCACHE_DIR)
    dk_debugFunc("\${ARGV}")

	if(DEFINED DKCACHE_DIR)
		return()
	endif()
	
	dk_validate(DKHOME_DIR "dk_DKHOME_DIR()")
	dk_set(DKCACHE_DIR "${DKHOME_DIR}/.dk")
	if(NOT EXISTS "${DKCACHE_DIR}")
		dk_makeDirectory("${DKCACHE_DIR}")
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc("\${ARGV}")

    dk_DKCACHE_DIR()
    dk_printVar(DKCACHE_DIR)
endfunction()
