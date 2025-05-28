#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ APP ############
dk_set(Target_App_Dir "${CMAKE_CURRENT_LIST_DIR}")
dk_basename("${Target_App_Dir}")
dk_set(Target_App "${dk_basename}")
dk_validate(CONFIG_PATH "dk_CONFIG_PATH()")

###### DEPENDENCIES ######
dk_depend(DK)

#if(HAVE_DK)
	## copy app default files without overwrite
	dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/icon.png ${Target_App_Dir}/icons.png) 
	dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/assets.h ${Target_App_Dir}/assets.h)
	dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/main.cpp ${Target_App_Dir}/main.cpp)
#endif()

###### CREATE ICONS ######
if(EXISTS "${Target_App_Dir}/icon.png")
	dk_createIcons("${Target_App_Dir}/icon.png")
	if(Windows)
		dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/Windows/icon.h ${Target_App_Dir}/Windows/icon.h)
		dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/Windows/icon.rc ${Target_App_Dir}/Windows/icon.rc)
	endif()
endif()

####################### Assets ###################
if(Windows)
	dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/win/assets.h ${Target_App_Dir}/assets.h)
	dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/win/assets.rc ${Target_App_Dir}/assets.rc)
endif()

####################### Other Resources ###################
#if(Windows)
#	dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/win/resource.h ${Target_App_Dir}/resource.h)
#	dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/win/resource.rc ${Target_App_Dir}/resource.rc)
#endif()

	
dk_generateAppCmake()

#dk_clearCmakeCache()

dk_set(CURRENT_PLUGIN 				${Target_App})
dk_set(${CURRENT_PLUGIN} 			${CMAKE_SOURCE_DIR})
dk_set(${CURRENT_PLUGIN}_CONFIG_DIR ${CMAKE_CURRENT_LIST_DIR}/${CONFIG_PATH})

dk_configure(${CMAKE_CURRENT_LIST_DIR} -DDKCMAKE_FUNCTIONS_DIR=${DKCMAKE_FUNCTIONS_DIR} -DTUPLE=${TUPLE})

if(BACKUP_APP_EXECUTABLES)
	dk_backupExecutable()
endif()

dk_build(${CMAKE_CURRENT_LIST_DIR})