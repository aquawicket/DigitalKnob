include_guard()

###############################################################################
# dk_buildLog(entry) PATH PRINTVAR
#
#	TODO
#
#	@entry			- TODO
#	@PRINTVAR	- TODO
#
function(dk_buildLog entry)
	DKDEBUGFUNC(${ARGV})
	
	dk_getOptionValue(PATH ${ARGV})
	dk_getOption(PRINTVAR ${ARGV})
	dk_printVar(entry)
	
	dk_info("${entry}")
	
	
	
	file(APPEND ${DK_PROJECT_DIR}/${BUILD_DIR}/DKBUILD.log "${entry}\n")
endfunction()