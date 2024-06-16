include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_addSource(<regex>)
#
#	TODO
#
#	@regex	- TODO
#
function(dk_addSource regex)
	dk_debugFunc(${ARGV})
	
	dk_set(SRC_INCLUDE ${SRC_INCLUDE} ${ARGV})
endfunction()








function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()

endfunction(DKTEST)