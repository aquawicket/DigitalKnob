#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_fileReplace("filePath, find, replace)
#
#	TODO
#
#	@filePath	- TODO
#	@find		- TODO
#	@replace	- TODO
#
function(dk_fileReplace)
	dk_debugFunc(3 4)
	
	file(READ ${ARGV0} fileString)
	string(FIND "${fileString}" "${ARGV1}" found)
	if(${found} GREATER -1)
		dk_replaceAll("${fileString}" "${ARGV1}" "${ARGV2}" fileString)
		dk_fileWrite(${ARGV0} "${fileString}")
	else()
		dk_warning("cannot find \"${ARGV1}\"  in  (${ARGV0})")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(file "C:/Users/Administrator/digitalknob/Development/3rdParty/rlottie-e3026b1e/CMakeLists.txt")
	dk_fileReplace(${filepath} "set(CMAKE_CXX_FLAGS_RELEASE" "#set(CMAKE_CXX_FLAGS_RELEASE")
	dk_fileReplace(${filepath} "set(CMAKE_CXX_FLAGS_DEBUG" "#set(CMAKE_CXX_FLAGS_DEBUG")
endfunction()
