include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_gitUpdate()
#
#
function(dk_gitUpdate)
	dk_debugFunc("\${ARGV}")

endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_gitUpdate()
endfunction()