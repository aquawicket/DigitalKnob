#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
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
			if(EXISTS ${DKIMPORTS_DIR}/${each_file}/DKINSTALL.cmake)
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
	
	
#	# Find all Plugin Folders from DKBRANCH root
#	if(IS_DIRECTORY ${DIGITALKNOB_DIR})
#		file(GLOB children RELATIVE ${DIGITALKNOB_DIR}/ ${DIGITALKNOB_DIR}/*)
#		foreach(child ${children})
#			file(GLOB plugins RELATIVE ${DKBRANCH_DIR}/${child}/plugins/ ${DKBRANCH_DIR}/${child}/plugins/*)
#			foreach(Plugin ${plugins})
#				if(EXISTS ${DIGITALKNOB_DIR}/${child}/plugins/${Plugin}/DKINSTALL.cmake)
#					if(NOT ${Plugin} STREQUAL "_DKIMPORT")
#						set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${Plugin})\n")
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