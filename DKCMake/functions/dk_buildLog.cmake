#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_buildLog(entry) PATH
#
#	TODO
#
#	@entry			- TODO
#
function(dk_buildLog entry)
	dk_debugFunc()
	
	dk_getOptionValue(PATH ${ARGV})
	
	#dk_printVar(entry)
	set(msg "${entry} = ${${entry}}")
	dk_info("${msg}")
	
	dk_fileAppend(${DK_PROJECT_DIR}/${CONFIG_PATH}/DKBUILD.log "${msg}\n")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()