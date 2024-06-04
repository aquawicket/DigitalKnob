include(${DKCMAKE_DIR}/functions/DK.cmake)
include_guard()

##################################################################################
# dk_cmakeLanguage(code)
#
#	polyfill for cmake_language() to call meta-operations on CMake commands.
#
#	@code	- The code to evaluate
#
function(dk_cmakeLanguage code)
	dk_debugFunc(${ARGV})
	
	if(${CMAKE_VERSION} GREATER 3.17)
		cmake_language(CALL ${code})
	else()
		file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/eval.cmake "${code}")
		include(${CMAKE_CURRENT_BINARY_DIR}/eval.cmake)
		file(REMOVE ${CMAKE_CURRENT_BINARY_DIR}/eval.cmake)
	endif()
endfunction()







function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	#dk_todo()

endfunction()
