#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_updateAndroidName(app_name)
#
#	TODO
#
#	@app_name	- TODO
#
function(dk_updateAndroidName app_name)
	dk_debugFunc()
	
	dk_toLower(${app_name} app_name)
	if(ANDROID)
		# update all files and folders recursivley
<<<<<<< HEAD
		file(GLOB_RECURSE allfiles LIST_DIRECTORIES true RELATIVE "${DK_PROJECT_DIR}/${triple}/" "${DK_PROJECT_DIR}/${triple}/*")
		dk_verbose("Getting a list of files in ${DK_PROJECT_DIR}/${triple}")
		list(REVERSE allfiles)
		foreach(each_file ${allfiles})
			dk_verbose(each_file)
			set(filepath "${DK_PROJECT_DIR}/${triple}/${each_file}")
=======
		file(GLOB_RECURSE allfiles LIST_DIRECTORIES true RELATIVE "${DK_Project_Dir}/${target_triple}/" "${DK_Project_Dir}/${target_triple}/*")
		dk_verbose("Getting a list of files in ${DK_Project_Dir}/${target_triple}")
		list(REVERSE allfiles)
		foreach(each_file ${allfiles})
			dk_verbose(each_file)
			set(filepath "${DK_Project_Dir}/${target_triple}/${each_file}")
>>>>>>> Development
			if(NOT IS_DIRECTORY ${filepath})
				if(each_file MATCHES "opendb")
					continue()
				endif()
				if(each_file MATCHES ".log")
					continue()
				endif()
				file(READ ${filepath} filestring)
				if(filestring MATCHES "dkapp")
					dk_info("Replacing 'dkapp' with '${app_name}' in ${filepath}")
					dk_replaceAll("${filestring}" "dkapp" "${app_name}" filestring)
					dk_fileWrite(${filepath} "${filestring}")
				endif()
			endif()
			dk_basename(${each_file} fname)
			if(fname MATCHES "dkapp")
				set(new_name ${each_file})
				dk_replaceAll("${new_name}" "dkapp" "${app_name}" new_name)
				dk_info("Renaming ${each_file} to ${new_name}")
<<<<<<< HEAD
				dk_rename(${DK_PROJECT_DIR}/${triple}/${each_file} ${DK_PROJECT_DIR}/${triple}/${new_name} OVERWRITE)
=======
				dk_rename(${DK_Project_Dir}/${target_triple}/${each_file} ${DK_Project_Dir}/${target_triple}/${new_name} OVERWRITE)
>>>>>>> Development
			endif()
		endforeach()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()