#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_deleteTempFiles()
#
#	Delete all .tmp files recursivly thoughout the digitalknob directory
#
function(dk_deleteTempFiles)
	dk_debugFunc(0)
	
	dk_info("Deleting Temporary files . . .")
	
	dk_validate(DK3RDARTY_DIR "dk_DKBRANCH_DIR()")
	file(GLOB_RECURSE tmp_Files "${DK3RDARTY_DIR}" "*.tmp")
	foreach(file ${tmp_Files})
		dk_info("dk_deleteTempFiles(): deleting ${file}. . .")
		#dk_delete("${file}")
	endforeach()
	file(GLOB_RECURSE TMP_Files "${DK3RDARTY_DIR}" "*.TMP")
	foreach(file ${TMP_Files})
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
		#dk_delete("${file}")
	endforeach()
	
	#if(WIN_HOST)
	#	dk_exec(for /r %%Z in (*.tmp) do @if %%~xZ==.tmp del "%%Z" WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})
	#	dk_exec(for /r %%Z in (*.TMP) do @if %%~xZ==.TMP del "%%Z" WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})
	#else()
	#	dk_exec("rm -rf `find . -name *.tmp`" WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})
	#	dk_exec(find . -name "*.TMP" -delete WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})
	#	dk_exec(find . -name "*.tmp" -delete WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})	
	#endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_deleteTempFiles()
endfunction()
