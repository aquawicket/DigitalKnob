#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_clearCmakeCache()
#
#
function(dk_clearCmakeCache)
	dk_debugFunc()

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
	
	dk_validate(DKPLUGINS_DIR "dk_DKPLUGINS_DIR()")
	file(GLOB_RECURSE cmakecache_files LIST_DIRECTORIES true "${DKPLUGINS_DIR}/" "*CMakeCache*")
	foreach(item ${cmakecache_files})
		message("deleting ${item}...")
		#dk_delete("${item}")
	endforeach()
	
	#execute_process(COMMAND cmd /c for /r %i in (CMakeCache.*) do del "%i" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
    #execute_process(COMMAND cmd /c for /d /r %i in (*CMakeFiles*) do rd /s /q "%i" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_clearCmakeCache(path)
#
#   Clear the cmake cache files recursivley for the given directory
#
function(dk_clearCmakeCache)
	dk_debugFunc(1)
	
    dk_info("Deleting CMake cache files in ${ARGV0}")

	dk_delete("${ARGV0}/CMakeFiles")
	dk_delete("${ARGV0}/CMakeCache.txt")
	dk_delete("${ARGV0}/cmake_install.cmake")
>>>>>>> Development
endfunction()













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_clearCmakeCache()
=======
	dk_debugFunc(0)
	
	dk_clearCmakeCache("C:/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/win_x86_64_clang/Debug")
>>>>>>> Development
endfunction()
