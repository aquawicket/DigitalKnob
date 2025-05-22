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
# dk_dependAll()
#
#	Add ALL 3rdParty imports to the project. 'Used for testing'
#
function(dk_dependAll)
	dk_debugFunc(0)
	
	set(DEPENDALL_FILE "")
	
	if(IS_DIRECTORY $ENV{DKIMPORTS_DIR})
		file(GLOB allfiles RELATIVE "$ENV{DKIMPORTS_DIR}/" "$ENV{DKIMPORTS_DIR}/*")
		foreach(each_file ${allfiles})
			if(EXISTS $ENV{DKIMPORTS_DIR}/${each_file}/DKINSTALL.cmake)
				set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${each_file})\n")
			endif()
		endforeach()
    endif()
	
	if(IS_DIRECTORY ${DKCPP_PLUGINS_DIR})
		file(GLOB allfiles RELATIVE "${DKCPP_PLUGINS_DIR}/" "${DKCPP_PLUGINS_DIR}/*")
		foreach(each_file ${allfiles})
			if(EXISTS ${DKCPP_PLUGINS_DIR}/${each_file}/DKINSTALL.cmake)
				if(NOT "${each_file}" STREQUAL "_DKIMPORT")
					set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${each_file})\n")
				endif()
			endif()
		endforeach()
	endif()
	
	
#	# Find all plugins Folders from DKBRANCH root
#	if(IS_DIRECTORY $ENV{DIGITALKNOB_DIR})
#		file(GLOB children RELATIVE $ENV{DIGITALKNOB_DIR}/ $ENV{DIGITALKNOB_DIR}/*)
#		foreach(child ${children})
#			file(GLOB plugins RELATIVE $ENV{DKBRANCH_DIR}/${child}/plugins/ $ENV{DKBRANCH_DIR}/${child}/plugins/*)
#			foreach(plugin ${plugins})
#				if(EXISTS $ENV{DIGITALKNOB_DIR}/${child}/plugins/${plugin}/DKINSTALL.cmake)
#					if(NOT ${plugin} STREQUAL "_DKIMPORT")
#						set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${plugin})\n")
#					endif()
#				endif()
#			endforeach()
#		endforeach()
#	endif()
	
	# To exclude libraries, use dk_disable(lib) in your app DKINSTALL.cmake file or in DKDisabled.cmake
	string (REPLACE ";" "" DEPENDALL_FILE "${DEPENDALL_FILE}")
	dk_fileWrite(${Target_App_Dir}/DEPEND_ALL.txt "${DEPENDALL_FILE}")
	dk_unset(DEPENDALL_FILE)
	dk_load(${Target_App_Dir}/DEPEND_ALL.txt)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()