#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_fileReplace("input" "searchValue" "newValue" rtn_var)
#
#	TODO
#
#	@filePath	- TODO
#	@find		- TODO
#	@replace	- TODO
#   NO_HALT (optional)	- if any of the parameters equals NO_HALT, dk_fatal() messages will not be displayed
#
function(dk_fileReplace)
	dk_debugFunc(3 4)
	
	#dk_getOption(NO_HALT ${ARGV})
	
	file(READ ${ARGV0} fileString)
	string(FIND "${fileString}" "${ARGV1}" found)
	if(${found} GREATER -1)
		dk_replaceAll("${ARGV0}" "${ARGV1}" "${ARGV2}" fileString)
		dk_fileWrite(${ARGV0} "${fileString}")
	else()
		dk_error("cannot find \"${ARGV1}\"  in  (${ARGV0})")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(file "C:/Users/Administrator/digitalknob/Development/3rdParty/rlottie-e3026b1e/CMakeLists.txt")
	dk_fileReplace(${filepath} "set(CMAKE_CXX_FLAGS_RELEASE" "#set(CMAKE_CXX_FLAGS_RELEASE")
	dk_fileReplace(${filepath} "set(CMAKE_CXX_FLAGS_DEBUG" "#set(CMAKE_CXX_FLAGS_DEBUG")
endfunction()
