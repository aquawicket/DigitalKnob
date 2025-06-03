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


###### DEFAULT TARGET ######
dk_validate(Host_Os "dk_Host_Os()")
dk_validate(Host_Arch "dk_Host_Arch()")
dk_Target_Os("${Host_Os}")
dk_Target_Arch("${Host_Arch}")
dk_Target_Env ("Clang")
dk_Target_Type("Debug")
dk_Target_Tuple()

############ APP ############
dk_set(Target_App_Dir "${CMAKE_CURRENT_LIST_DIR}")
dk_basename("${Target_App_Dir}")
dk_set(Target_App "${dk_basename}")
dk_validate(Target_Config "dk_Target_Config()")

###### DEPENDENCIES ######


## copy app default files without overwrite
dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/icon.png ${Target_App_Dir}/icon.png) 
dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/main.cpp ${Target_App_Dir}/main.cpp)

###### CREATE ICONS ######
if(EXISTS "${Target_App_Dir}/icon.png")
	dk_createIcons("${Target_App_Dir}/icon.png")
endif()

################# BACKUP USERDATA / INJECT ASSETS #####################
if(EXISTS "${Target_App_Dir}/assets")
	dk_copy(${Target_App_Dir}/assets/USER ${Target_App_Dir}/Backup/USER OVERWRITE NO_HALT)
	dk_delete(${Target_App_Dir}/assets/USER NO_HALT)
	#Compress the assets, they will be included by resource.rc
	dk_info("Creating assets.zip . . .")
	dk_compressAssets(${Target_App_Dir}/assets)
	# Restore the backed up files
	dk_copy(${Target_App_Dir}/Backup/ ${Target_App_Dir}/assets/ OVERWRITE NO_HALT)
	dk_delete(${Target_App_Dir}/Backup NO_HALT)
	#dummy assets.h file, or the builder will complain about assets.h missing
	dk_assertPath(DKCPP_PLUGINS_DIR)
	dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/assets.h ${Target_App_Dir}/assets.h OVERWRITE NO_HALT)
endif()

###################### Backup Executable ###########################
if(BACKUP_APP_EXECUTABLES)
	dk_backupExecutable()
endif()

dk_generateAppCmake()

#dk_clearCmakeCache()

dk_set(CURRENT_PLUGIN 				${Target_App})
dk_set(${CURRENT_PLUGIN} 			${CMAKE_SOURCE_DIR})
dk_set(${CURRENT_PLUGIN}_CONFIG_DIR ${CMAKE_CURRENT_LIST_DIR}/${Target_Config})

dk_configure(${CMAKE_CURRENT_LIST_DIR} -DDKCMAKE_FUNCTIONS_DIR=${DKCMAKE_FUNCTIONS_DIR} -DTUPLE=${TUPLE})
dk_build(${CMAKE_CURRENT_LIST_DIR})
