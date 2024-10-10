#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_clearCmakeCache()
#
#
function(dk_clearCmakeCache)
	dk_debugFunc("\${ARGV}")

    dk_info("Deleting CMake cache files. . .")
	### TODO
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	file(GLOB_RECURSE cmakecache_files LIST_DIRECTORIES true "${DKBRANCH_DIR}/" "*CMakeCache*")
	foreach(item ${cmakecache_files})
		message("${item}")
	endforeach()
	
	#execute_process(COMMAND cmd /c for /r %i in (CMakeCache.*) do del "%i" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
    #execute_process(COMMAND cmd /c for /d /r %i in (*CMakeFiles*) do rd /s /q "%i" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
endfunction()













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_clearCmakeCache()
endfunction()
