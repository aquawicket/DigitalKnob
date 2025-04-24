#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_deleteTempFiles()
#
#	Delete all .tmp files recursivly thoughout the digitalknob directory
#
function(dk_deleteTempFiles)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_info("Deleting Temporary files . . .")
	
	dk_validate(DK3RDARTY_DIR "dk_DKBRANCH_DIR()")
	file(GLOB_RECURSE tmp_Files "${DK3RDARTY_DIR}" "*.tmp")
	foreach(file ${tmp_Files})
<<<<<<< HEAD
		message("deleting ${file}. . .")
=======
		dk_info("dk_deleteTempFiles(): deleting ${file}. . .")
>>>>>>> Development
		#dk_delete("${file}")
	endforeach()
	file(GLOB_RECURSE TMP_Files "${DK3RDARTY_DIR}" "*.TMP")
	foreach(file ${TMP_Files})
<<<<<<< HEAD
		message("${file}")
		#dk_delete("${file}")
	endforeach()
	
	dk_validate(DKAPPS_DIR "dk_DKBRANCH_DIR()")
	file(GLOB_RECURSE tmp_Files "${DKAPPS_DIR}" "*.tmp")
	foreach(file ${tmp_Files})
		message("deleting ${file}. . .")
		#dk_delete("${file}")
	endforeach()
	file(GLOB_RECURSE TMP_Files "${DKAPPS_DIR}" "*.TMP")
	foreach(file ${TMP_Files})
		message("${file}")
		#dk_delete("${file}")
	endforeach()
	
	dk_validate(DKPLUGINS_DIR "dk_DKPLUGINS_DIR()")
	file(GLOB_RECURSE tmp_Files "${DKPLUGINS_DIR}" "*.tmp")
	foreach(file ${tmp_Files})
		message("deleting ${file}. . .")
		#dk_delete("${file}")
	endforeach()
	file(GLOB_RECURSE TMP_Files "${DKPLUGINS_DIR}" "*.TMP")
	foreach(file ${TMP_Files})
		message("${file}")
=======
		dk_info("dk_deleteTempFiles(): deleting ${file}. . .")
		#dk_delete("${file}")
	endforeach()
	
	dk_validate(DKCPP_APPS_DIR "dk_DKBRANCH_DIR()")
	file(GLOB_RECURSE tmp_Files "$ENV{DKCPP_APPS_DIR}" "*.tmp")
	foreach(file ${tmp_Files})
		dk_info("dk_deleteTempFiles(): deleting ${file}. . .")
		#dk_delete("${file}")
	endforeach()
	file(GLOB_RECURSE TMP_Files "$ENV{DKCPP_APPS_DIR}" "*.TMP")
	foreach(file ${TMP_Files})
		dk_info("dk_deleteTempFiles(): deleting ${file}. . .")
		#dk_delete("${file}")
	endforeach()
	
	dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
	file(GLOB_RECURSE tmp_Files "${DKCPP_PLUGINS_DIR}" "*.tmp")
	foreach(file ${tmp_Files})
		dk_info("dk_deleteTempFiles(): deleting ${file}. . .")
		#dk_delete("${file}")
	endforeach()
	file(GLOB_RECURSE TMP_Files "${DKCPP_PLUGINS_DIR}" "*.TMP")
	foreach(file ${TMP_Files})
		dk_info("dk_deleteTempFiles(): deleting ${file}. . .")
>>>>>>> Development
		#dk_delete("${file}")
	endforeach()
	
	#if(WIN_HOST)
<<<<<<< HEAD
	#	dk_executeProcess(for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	#	dk_executeProcess(for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	#else()
	#	dk_executeProcess("rm -rf `find . -name *.tmp`" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	#	dk_executeProcess(find . -name "*.TMP" -delete WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	#	dk_executeProcess(find . -name "*.tmp" -delete WORKING_DIRECTORY ${DIGITALKNOB_DIR})	
=======
	#	dk_exec(for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z" WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})
	#	dk_exec(for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z" WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})
	#else()
	#	dk_exec("rm -rf `find . -name *.tmp`" WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})
	#	dk_exec(find . -name "*.TMP" -delete WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})
	#	dk_exec(find . -name "*.tmp" -delete WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})	
>>>>>>> Development
	#endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_deleteTempFiles()
endfunction()
