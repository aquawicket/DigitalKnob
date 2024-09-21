include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_removeSource(regex)
#
#	TODO
#
#	@regex	- TODO
#
function(dk_removeSource regex)
	dk_debugFunc("\${ARGV}")
	
	dk_set(SRC_EXCLUDE ${SRC_EXCLUDE} ${ARGV})
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()