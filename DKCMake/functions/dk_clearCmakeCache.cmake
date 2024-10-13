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


	dk_validate(DK3RDARTY_DIR "dk_DKBRANCH_DIR()")
	file(GLOB_RECURSE cmakecache_files LIST_DIRECTORIES true "${DK3RDARTY_DIR}/" "*CMakeCache*")
	foreach(item ${cmakecache_files})
		message("deleting ${item}...")
		#dk_delete("${item}")
	endforeach()
	
	dk_validate(DKAPPS_DIR "dk_DKBRANCH_DIR()")
	file(GLOB_RECURSE cmakecache_files LIST_DIRECTORIES true "${DKAPPS_DIR}/" "*CMakeCache*")
	foreach(item ${cmakecache_files})
		message("deleting ${item}...")
		#dk_delete("${item}")
	endforeach()
	
	dk_validate(DKPLUGINS_DIR "dk_DKBRANCH_DIR()")
	file(GLOB_RECURSE cmakecache_files LIST_DIRECTORIES true "${DKPLUGINS_DIR}/" "*CMakeCache*")
	foreach(item ${cmakecache_files})
		message("deleting ${item}...")
		#dk_delete("${item}")
	endforeach()
	
	#execute_process(COMMAND cmd /c for /r %i in (CMakeCache.*) do del "%i" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
    #execute_process(COMMAND cmd /c for /d /r %i in (*CMakeFiles*) do rd /s /q "%i" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
endfunction()













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_clearCmakeCache()
endfunction()
