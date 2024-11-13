#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_deleteTempFiles()
#
#	Delete all .tmp files recursivly thoughout the digitalknob directory
#
function(dk_deleteTempFiles)
	dk_debugFunc()
	
	dk_info("Deleting Temporary files . . .")
	
	dk_validate(DK3RDARTY_DIR "dk_DKBRANCH_DIR()")
	file(GLOB_RECURSE tmp_Files "${DK3RDARTY_DIR}" "*.tmp")
	foreach(file ${tmp_Files})
		message("deleting ${file}. . .")
		#dk_delete("${file}")
	endforeach()
	file(GLOB_RECURSE TMP_Files "${DK3RDARTY_DIR}" "*.TMP")
	foreach(file ${TMP_Files})
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
		#dk_delete("${file}")
	endforeach()
	
	#if(WIN_HOST)
	#	dk_executeProcess(for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	#	dk_executeProcess(for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	#else()
	#	dk_executeProcess("rm -rf `find . -name *.tmp`" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	#	dk_executeProcess(find . -name "*.TMP" -delete WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	#	dk_executeProcess(find . -name "*.tmp" -delete WORKING_DIRECTORY ${DIGITALKNOB_DIR})	
	#endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_deleteTempFiles()
endfunction()
