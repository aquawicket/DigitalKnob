#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_dependAll()
#
<<<<<<< HEAD
#	TODO
#
function(dk_dependAll)
	dk_debugFunc()
	
	set(DEPENDALL_FILE "")
	
	if(IS_DIRECTORY ${DKIMPORTS_DIR})
		file(GLOB allfiles RELATIVE "${DKIMPORTS_DIR}/" "${DKIMPORTS_DIR}/*")
		foreach(each_file ${allfiles})
			if(EXISTS ${DKIMPORTS_DIR}/${each_file}/DKMAKE.cmake)
=======
#	Add ALL 3rdParty imports to the project. 'Used for testing'
#
function(dk_dependAll)
	dk_debugFunc(0)
	
	set(DEPENDALL_FILE "")
	
	if(IS_DIRECTORY $ENV{DKIMPORTS_DIR})
		file(GLOB allfiles RELATIVE "$ENV{DKIMPORTS_DIR}/" "$ENV{DKIMPORTS_DIR}/*")
		foreach(each_file ${allfiles})
			if(EXISTS $ENV{DKIMPORTS_DIR}/${each_file}/DKINSTALL.cmake)
>>>>>>> Development
				set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${each_file})\n")
			endif()
		endforeach()
    endif()
	
<<<<<<< HEAD
	if(IS_DIRECTORY ${DKPLUGINS_DIR})
		file(GLOB allfiles RELATIVE "${DKPLUGINS_DIR}/" "${DKPLUGINS_DIR}/*")
		foreach(each_file ${allfiles})
			if(EXISTS ${DKPLUGINS_DIR}/${each_file}/DKMAKE.cmake)
=======
	if(IS_DIRECTORY ${DKCPP_PLUGINS_DIR})
		file(GLOB allfiles RELATIVE "${DKCPP_PLUGINS_DIR}/" "${DKCPP_PLUGINS_DIR}/*")
		foreach(each_file ${allfiles})
			if(EXISTS ${DKCPP_PLUGINS_DIR}/${each_file}/DKINSTALL.cmake)
>>>>>>> Development
				if(NOT "${each_file}" STREQUAL "_DKIMPORT")
					set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${each_file})\n")
				endif()
			endif()
		endforeach()
	endif()
	
	
<<<<<<< HEAD
#	# Find all DKPlugins Folders from DKBRANCH root
#	if(IS_DIRECTORY ${DIGITALKNOB_DIR})
#		file(GLOB children RELATIVE ${DIGITALKNOB_DIR}/ ${DIGITALKNOB_DIR}/*)
#		foreach(child ${children})
#			file(GLOB plugins RELATIVE ${DKBRANCH_DIR}/${child}/DKPlugins/ ${DKBRANCH_DIR}/${child}/DKPlugins/*)
#			foreach(plugin ${plugins})
#				if(EXISTS ${DIGITALKNOB_DIR}/${child}/DKPlugins/${plugin}/DKMAKE.cmake)
=======
#	# Find all plugins Folders from DKBRANCH root
#	if(IS_DIRECTORY $ENV{DIGITALKNOB_DIR})
#		file(GLOB children RELATIVE $ENV{DIGITALKNOB_DIR}/ $ENV{DIGITALKNOB_DIR}/*)
#		foreach(child ${children})
#			file(GLOB plugins RELATIVE $ENV{DKBRANCH_DIR}/${child}/plugins/ $ENV{DKBRANCH_DIR}/${child}/plugins/*)
#			foreach(plugin ${plugins})
#				if(EXISTS $ENV{DIGITALKNOB_DIR}/${child}/plugins/${plugin}/DKINSTALL.cmake)
>>>>>>> Development
#					if(NOT ${plugin} STREQUAL "_DKIMPORT")
#						set(DEPENDALL_FILE ${DEPENDALL_FILE} "dk_depend(${plugin})\n")
#					endif()
#				endif()
#			endforeach()
#		endforeach()
#	endif()
	
<<<<<<< HEAD
	# To exclude libraries, use dk_disable(lib) in your app DKMAKE.cmake file or in DKDisabled.cmake
	string (REPLACE ";" "" DEPENDALL_FILE "${DEPENDALL_FILE}")
	dk_fileWrite(${DK_PROJECT_DIR}/DEPEND_ALL.txt "${DEPENDALL_FILE}")
	dk_unset(DEPENDALL_FILE)
	dk_load(${DK_PROJECT_DIR}/DEPEND_ALL.txt)
=======
	# To exclude libraries, use dk_disable(lib) in your app DKINSTALL.cmake file or in DKDisabled.cmake
	string (REPLACE ";" "" DEPENDALL_FILE "${DEPENDALL_FILE}")
	dk_fileWrite(${DK_Project_Dir}/DEPEND_ALL.txt "${DEPENDALL_FILE}")
	dk_unset(DEPENDALL_FILE)
	dk_load(${DK_Project_Dir}/DEPEND_ALL.txt)
>>>>>>> Development
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