#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_fileReplace("input" "searchValue" "newValue" rtn_var) NO_HALT
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
	
	dk_getOption(NO_HALT ${ARGV})
	
	file(READ ${filePath} fileString)
	if(fileString MATCHES "${find}")
		dk_replaceAll("${fileString}" "${find}" "${replace}" fileString)
		dk_fileWrite(${filePath} "${fileString}")
	else()
		dk_fatal("cannot find \"${find}\"  in  (${filePath})" ${NO_HALT})
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(file "C:/Users/Administrator/digitalknob/Development/3rdParty/rlottie-e3026b1e/CMakeLists.txt")
	message("${file}")
	dk_fileReplace(${file} "CMAKE_CXX_FLAGS_RELEASE" "DISABLE_CMAKE_CXX_FLAGS_RELEASE")
	dk_fileReplace(${file} "CMAKE_CXX_FLAGS_DEBUG" "DISABLE_CMAKE_CXX_FLAGS_DEBUG")
	message("${file}")
endfunction()
