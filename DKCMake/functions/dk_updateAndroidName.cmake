include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_updateAndroidName(app_name)
#
#	TODO
#
#	@app_name	- TODO
#
function(dk_updateAndroidName app_name)
	dk_debugFunc(${ARGV})
	
	dk_toLower(${app_name} app_name)
	if(ANDROID)
		# update all files and folders recursivley
		file(GLOB_RECURSE allfiles LIST_DIRECTORIES true RELATIVE "${DK_PROJECT_DIR}/${triple}/" "${DK_PROJECT_DIR}/${triple}/*")
		dk_verbose("Getting a list of files in ${DK_PROJECT_DIR}/${triple}")
		list(REVERSE allfiles)
		foreach(each_file ${allfiles})
			dk_verbose(each_file)
			set(filepath "${DK_PROJECT_DIR}/${triple}/${each_file}")
			if(NOT IS_DIRECTORY ${filepath})
				string(FIND "${each_file}" "opendb" indexD)
				if(${indexD} GREATER -1)
				#dk_includes( "${each_file}" "opendb" includes_A)
				#if(${includes_A})
					continue()
				endif()
				string(FIND "${each_file}" ".log" indexD)
				if(${indexD} GREATER -1)
				#dk_includes("${each_file}" ".log" includes_B)
				#if(${includes_B})
					continue()
				endif()
				file(READ ${filepath} filestring)
				string(FIND "${filestring}" "dkapp" index)
				if(${index} GREATER -1)
				#dk_includes("${filestring}" "dkapp" includes_C)
				#if(${includes_C})
					dk_info("Replacing 'dkapp' with '${app_name}' in ${filepath}")
					dk_replaceAll("${filestring}" "dkapp" "${app_name}" filestring)
					dk_fileWrite(${filepath} "${filestring}")
				endif()
			endif()
			dk_basename(${each_file} fname)
			string(FIND "${fname}" "dkapp" indexB)
			if(${indexB} GREATER -1)
			#dk_includes("${fname}" "dkapp" includes_D)
			#if(${includes_D})
				set(new_name ${each_file})
				dk_replaceAll("${new_name}" "dkapp" "${app_name}" new_name)
				dk_info("Renaming ${each_file} to ${new_name}")
				dk_rename(${DK_PROJECT_DIR}/${triple}/${each_file} ${DK_PROJECT_DIR}/${triple}/${new_name} OVERWRITE)
			endif()
		endforeach()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()