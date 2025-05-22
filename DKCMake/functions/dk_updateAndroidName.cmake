#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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
	if(Android)
		# update all files and folders recursivley
		file(GLOB_RECURSE allfiles LIST_DIRECTORIES true RELATIVE "${Target_App_Dir}/${Target_Tuple}/" "${Target_App_Dir}/${Target_Tuple}/*")
		dk_verbose("Getting a list of files in ${Target_App_Dir}/${Target_Tuple}")
		list(REVERSE allfiles)
		foreach(each_file ${allfiles})
			dk_verbose(each_file)
			set(filepath "${Target_App_Dir}/${Target_Tuple}/${each_file}")
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
				dk_rename(${Target_App_Dir}/${Target_Tuple}/${each_file} ${Target_App_Dir}/${Target_Tuple}/${new_name} OVERWRITE)
			endif()
		endforeach()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()