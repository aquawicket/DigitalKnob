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
function(dk_fileReplace filePath find replace)
	dk_debugFunc()
	
	#dk_getOption(NO_HALT ${ARGV})
	
	file(READ ${filePath} fileString)
	string(FIND "${fileString}" "${find}" found)
	if(${found} GREATER -1)
		dk_replaceAll("${fileString}" "${find}" "${replace}" fileString)
		dk_fileWrite(${filePath} "${fileString}")
	else()
		dk_error("cannot find \"${find}\"  in  (${filePath})")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(file "C:/Users/Administrator/digitalknob/Development/3rdParty/rlottie-e3026b1e/CMakeLists.txt")
	message("${file}")
	dk_fileReplace(${file} "set(CMAKE_CXX_FLAGS_RELEASE" "#set(CMAKE_CXX_FLAGS_RELEASE")
	dk_fileReplace(${file} "set(CMAKE_CXX_FLAGS_DEBUG" "#set(CMAKE_CXX_FLAGS_DEBUG")
	message("${file}")
endfunction()
