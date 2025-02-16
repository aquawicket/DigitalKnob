#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_fileReplace(filePath, find, replace)
#
#	TODO
#
#	@filePath	- TODO
#	@find		- TODO
#	@replace	- TODO
#
function(dk_fileReplace)
	dk_debugFunc(3 4)
	
	dk_assertVar(ARGV0)
	set(filepath ${ARGV0})
	dk_replaceAll("${filepath}" "\'" "" filepath)
	
	dk_assertVar(ARGV1)
	set(find ${ARGV1})
	dk_replaceAll("${find}" "\'" "" find)
	
	dk_assertVar(ARGV2)
	set(replace ${ARGV2})
	dk_replaceAll("${replace}" "\'" "" replace)
	
	file(READ ${filepath} fileString)
	string(FIND "${fileString}" "${find}" found)
	if(${found} GREATER -1)
		dk_replaceAll("${fileString}" "${find}" "${replace}" fileString)
		dk_fileWrite("${filepath}" "${fileString}")
	else()
		dk_warning("cannot find \"${find}\"  in  (${filepath})")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_fileReplace("C:/Users/Administrator/digitalknob/Development/README.md" "replaced" "DigitalKnob")
	
	dk_fileReplace("${EMSDK_DIR}/upstream/emscripten/src/settings.js" "var USE_SDL = 0\;" 			"var USE_SDL = false\;")
	#dk_fileReplace("${EMSDK_DIR}/upstream/emscripten/src/settings.js" "var USE_SDL = 0;" 			"var USE_SDL = false;"			NO_HALT)
	
	set(filepath "C:/Users/Administrator/digitalknob/Development/3rdParty/rlottie-e3026b1e/CMakeLists.txt")
	dk_fileReplace("${filepath}" "set(CMAKE_CXX_FLAGS_RELEASE" "#set(CMAKE_CXX_FLAGS_RELEASE")
	dk_fileReplace("${filepath}" "set(CMAKE_CXX_FLAGS_DEBUG" "#set(CMAKE_CXX_FLAGS_DEBUG")
endfunction()
