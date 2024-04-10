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
	
	dk_get_option_value(PATH ${ARGV})
	dk_get_option(PRINTVAR ${ARGV})
	dk_printvar(entry)
	
	dk_info("${entry}")
	
	
	
	file(APPEND ${DK_PROJECT_DIR}/${BUILD_DIR}/DKBUILD.log "${entry}\n")
endfunction()