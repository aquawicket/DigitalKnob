include(${CMAKE_CURRENT_LIST_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_buildLog(entry) PATH
#
#	TODO
#
#	@entry			- TODO
#
function(dk_buildLog entry)
	dk_debugFunc(${ARGV})
	
	dk_getOptionValue(PATH ${ARGV})
	
	#dk_printVar(entry)
	set(msg "${entry} = ${${entry}}")
	dk_info("${msg}")
	
	file(APPEND ${DK_PROJECT_DIR}/${BUILD_DIR}/DKBUILD.log "${msg}\n")
endfunction()