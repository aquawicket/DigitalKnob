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
# dk_getImportPath(Plugin rtn_var)
#
#	Get the Import_Path to a Plugin
#
function(dk_getImportPath Plugin rtn_var)
	dk_debugFunc(1 2)
	
	list(FIND dkdisabled_list "${ARGV}" index)
	if(${index} GREATER -1)
		dk_info("${ARGV} IS DISABLED")
		return()
	endif()

	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	if(EXISTS ${DKIMPORTS_DIR}/${Plugin}/DKINSTALL.cmake)
		set(dk_getImportPath "${DKIMPORTS_DIR}/${Plugin}")
   	endif()

	dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
	if(EXISTS ${DKCPP_PLUGINS_DIR}/${Plugin}/DKINSTALL.cmake)
		set(dk_getImportPath "${DKCPP_PLUGINS_DIR}/${Plugin}")
   	endif()
	
	###### return ######
	set(dk_getImportPath ${dk_getImportPath} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_getImportPath} PARENT_SCOPE)
	else()
		#message("${dk_getImportPath}") 
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_getImportPath(curl Plugin_Import_Path)
	dk_debug("dk_getImportPath = ${dk_getImportPath}")
	dk_debug("Plugin_Import_Path = ${Plugin_Import_Path}")
endfunction()