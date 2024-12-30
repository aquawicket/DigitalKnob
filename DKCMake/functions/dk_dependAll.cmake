#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_dependAll()
#
#	Add ALL 3rdParty imports to the project. 'Used for testing'
#
function(dk_dependAll)
	dk_debugFunc(0)
	
	set(DEPENDALL_FILE "")
	
	if(IS_DIRECTORY ${DKIMPORTS_DIR})
		file(GLOB allfiles RELATIVE "${DKIMPORTS_DIR}/" "${DKIMPORTS_DIR}/*")
		foreach(each_file ${allfiles})
			if(EXISTS ${DKIMPORTS_DIR}/${each_file}/DKMAKE.cmake)
				set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${each_file})\n")
			endif()
		endforeach()
    endif()
	
	if(IS_DIRECTORY ${DKPLUGINS_DIR})
		file(GLOB allfiles RELATIVE "${DKPLUGINS_DIR}/" "${DKPLUGINS_DIR}/*")
		foreach(each_file ${allfiles})
			if(EXISTS ${DKPLUGINS_DIR}/${each_file}/DKMAKE.cmake)
				if(NOT "${each_file}" STREQUAL "_DKIMPORT")
					set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${each_file})\n")
				endif()
			endif()
		endforeach()
	endif()
	
	
#	# Find all DKPlugins Folders from DKBRANCH root
#	if(IS_DIRECTORY ${DIGITALKNOB_DIR})
#		file(GLOB children RELATIVE ${DIGITALKNOB_DIR}/ ${DIGITALKNOB_DIR}/*)
#		foreach(child ${children})
#			file(GLOB plugins RELATIVE ${DKBRANCH_DIR}/${child}/DKPlugins/ ${DKBRANCH_DIR}/${child}/DKPlugins/*)
#			foreach(plugin ${plugins})
#				if(EXISTS ${DIGITALKNOB_DIR}/${child}/DKPlugins/${plugin}/DKMAKE.cmake)
#					if(NOT ${plugin} STREQUAL "_DKIMPORT")
#						set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${plugin})\n")
#					endif()
#				endif()
#			endforeach()
#		endforeach()
#	endif()
	
	# To exclude libraries, use dk_disable(lib) in your app DKMAKE.cmake file or in DKDisabled.cmake
	string (REPLACE ";" "" DEPENDALL_FILE "${DEPENDALL_FILE}")
	dk_fileWrite(${DK_Project_Dir}/DEPEND_ALL.txt "${DEPENDALL_FILE}")
	dk_unset(DEPENDALL_FILE)
	dk_load(${DK_Project_Dir}/DEPEND_ALL.txt)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()