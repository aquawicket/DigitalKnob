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
	
	dk_printVar(entry)
	#dk_info("${entry}")
	
	file(APPEND ${DK_PROJECT_DIR}/${BUILD_DIR}/DKBUILD.log "${entry}\n")
endfunction()