include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_clearCmakeCache()
#
#	Delete all CMake cache files thoughout the digitalknob directory
#
function(dk_clearCmakeCache)
	dk_debugFunc("\${ARGV}")
	
	DKASSERT(DIGITALKNOB_DIR)
	dk_info("Deleteing CMake cache . . .")
	if(WIN_HOST)
		dk_executeProcess(for /r %%i in (CMakeCache.*) do del "%%i" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
		dk_executeProcess(for /d /r %%i in (*CMakeFiles*) do rd /s /q "%%i" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	else()
		dk_executeProcess(find . -name "CMakeCache.*" -delete WORKING_DIRECTORY ${DIGITALKNOB_DIR})
		dk_executeProcess("rm -rf `find . -type d -name CMakeFiles`" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()
