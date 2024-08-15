include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_clearCmakeCache()
#
#
function(dk_clearCmakeCache)
	dk_debugFunc(${ARGV})

    dk_info("Deleteing CMake cache files. . .")
	dk_validate(DIGITALKNOB_DIR "dk_getDKPaths()")
    dk_cd("${DIGITALKNOB_DIR}")
	
	execute_process(COMMAND cmd /c for /r %i in (CMakeCache.*) do del "%i" WORKING_DIRECTORY ${WORKING_DIRECTORY})
    execute_process(COMMAND cmd /c for /d /r %i in (*CMakeFiles*) do rd /s /q "%i" WORKING_DIRECTORY ${WORKING_DIRECTORY})
endfunction()













function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_clearCmakeCache()
endfunction()
