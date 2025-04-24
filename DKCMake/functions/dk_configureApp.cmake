#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_configureApp(DK_PROJECT_DIR)
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_configureApp(DK_Project_Dir)
>>>>>>> Development
#
#
function(dk_configureApp)
	dk_debugFunc()
	
<<<<<<< HEAD
	set(DK_PROJECT_DIR ${ARGV0})
	dk_basename(${DK_PROJECT_DIR} APP_NAME)
=======
	set(DK_Project_Dir ${ARGV0})
	dk_basename(${DK_Project_Dir} APP_NAME)
>>>>>>> Development
	
	dk_info("\n")
	dk_info("##############################################")
	dk_info("############ Creating ${APP_NAME} ############")
	dk_info("##############################################\n")

	# Create version from date
	string(TIMESTAMP year "%y")
	string(TIMESTAMP month "%m")
	string(TIMESTAMP day "%d")
	dk_set(APP_VERSION "${year}.${month}.${day}")

	## Create the DKPlugins.h header file
	if(PLUGINS_FILE)
		dk_replaceAll("${PLUGINS_FILE}" "#include \"DKWindow.h\""  ""  PLUGINS_FILE)
		dk_replaceAll("${PLUGINS_FILE}"  "\\n"  "\n"  PLUGINS_FILE)
		dk_replaceAll("${PLUGINS_FILE}"  ";"  ""  PLUGINS_FILE)
<<<<<<< HEAD
		dk_fileWrite("${DK_PROJECT_DIR}/DKPlugins.h" "${PLUGINS_FILE}")
	endif()

	dk_validate(DKPLUGINS_DIR "dk_DKPLUGINS_DIR()")
	if(HAVE_DK)
		## copy app default files without overwrite
		dk_info("Copying DKPlugins/_DKIMPORT/ to App...")
		dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/icons ${DK_PROJECT_DIR}/icons) 
		dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/assets.h ${DK_PROJECT_DIR}/assets.h)
		dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/main.cpp ${DK_PROJECT_DIR}/main.cpp)
	endif()

	# Copy VSCode project files to app
	dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/DKApp.code-workspace ${DK_PROJECT_DIR}/DKApp.code-workspace)
	dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/.vscode ${DK_PROJECT_DIR}/.vscode)
=======
		dk_fileWrite("${DK_Project_Dir}/DKPlugins.h" "${PLUGINS_FILE}")
	endif()

	dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
	if(HAVE_DK)
		## copy app default files without overwrite
		dk_info("Copying DKCpp/plugins/_DKIMPORT/ to App...")
		dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/icons ${DK_Project_Dir}/icons) 
		dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/assets.h ${DK_Project_Dir}/assets.h)
		dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/main.cpp ${DK_Project_Dir}/main.cpp)
	endif()

	# Copy VSCode project files to app
	dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/DKApp.code-workspace ${DK_Project_Dir}/DKApp.code-workspace)
	dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/.vscode ${DK_Project_Dir}/.vscode)
>>>>>>> Development

	### Include all source files from the app folder for the compilers
	#file(GLOB_RECURSE App_SRC
	file(GLOB App_SRC
<<<<<<< HEAD
		${DK_PROJECT_DIR}/*.h
		${DK_PROJECT_DIR}/*.c
		${DK_PROJECT_DIR}/*.hpp
		${DK_PROJECT_DIR}/*.cpp)
	list(FILTER App_SRC EXCLUDE REGEX "${DK_PROJECT_DIR}/assets/*")
	list(FILTER App_SRC EXCLUDE REGEX "${DK_PROJECT_DIR}/${triple}/*")
=======
		${DK_Project_Dir}/*.h
		${DK_Project_Dir}/*.c
		${DK_Project_Dir}/*.hpp
		${DK_Project_Dir}/*.cpp)
	list(FILTER App_SRC EXCLUDE REGEX "${DK_Project_Dir}/assets/*")
	list(FILTER App_SRC EXCLUDE REGEX "${DK_Project_Dir}/${target_triple}/*")
>>>>>>> Development
	if(SRC_INCLUDE)
		file(GLOB App_SRC_INCLUDE ${SRC_INCLUDE})
		list(APPEND App_SRC ${App_SRC_INCLUDE})
	endif()
	if(SRC_EXCLUDE)
		foreach(item ${SRC_EXCLUDE})
			list(FILTER App_SRC EXCLUDE REGEX ${item})
		endforeach()
	endif()

	add_definitions(-DDKAPP)
<<<<<<< HEAD
	include_directories(${DK_PROJECT_DIR})
	include_directories(${DKPLUGINS_DIR})
=======
	include_directories(${DK_Project_Dir})
	include_directories(${DKCPP_PLUGINS_DIR})
>>>>>>> Development

	##############
	if(WIN_X86_64)
		########################## CREATE ICONS ###############################
<<<<<<< HEAD
		dk_createIcons(${DK_PROJECT_DIR}/icons/icon.png)
		
		################# BACKUP USERDATA / INJECT ASSETS #####################
		if(HAVE_DK)
			dk_copy(${DK_PROJECT_DIR}/assets/USER ${DK_PROJECT_DIR}/Backup/USER OVERWRITE NO_HALT)
			dk_delete(${DK_PROJECT_DIR}/assets/USER NO_HALT)
			#Compress the assets, they will be included by resource.rc
			dk_info("Creating assets.zip . . .")
			dk_compressAssets(${DK_PROJECT_DIR}/assets)
			# Restore the backed up files
			dk_copy(${DK_PROJECT_DIR}/Backup/ ${DK_PROJECT_DIR}/assets/ OVERWRITE NO_HALT)
			dk_delete(${DK_PROJECT_DIR}/Backup NO_HALT)
			#dummy assets.h file, or the builder wil complain about assets.h missing
			dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/assets.h ${DK_PROJECT_DIR}/assets.h OVERWRITE NO_HALT)
=======
		dk_createIcons(${DK_Project_Dir}/icons/icon.png)
		
		################# BACKUP USERDATA / INJECT ASSETS #####################
		if(HAVE_DK)
			dk_copy(${DK_Project_Dir}/assets/USER ${DK_Project_Dir}/Backup/USER OVERWRITE NO_HALT)
			dk_delete(${DK_Project_Dir}/assets/USER NO_HALT)
			#Compress the assets, they will be included by resource.rc
			dk_info("Creating assets.zip . . .")
			dk_compressAssets(${DK_Project_Dir}/assets)
			# Restore the backed up files
			dk_copy(${DK_Project_Dir}/Backup/ ${DK_Project_Dir}/assets/ OVERWRITE NO_HALT)
			dk_delete(${DK_Project_Dir}/Backup NO_HALT)
			#dummy assets.h file, or the builder wil complain about assets.h missing
			dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/assets.h ${DK_Project_Dir}/assets.h OVERWRITE NO_HALT)
>>>>>>> Development
		endif()
		
		###################### Backup Executable ###########################
		if(BACKUP_APP_EXECUTABLES)
			if(DEBUG)
<<<<<<< HEAD
				dk_rename(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.exe ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.exe.backup OVERWRITE NO_HALT)
			endif()
			if(RELEASE)
				dk_rename(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.exe ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.exe.backup OVERWRITE NO_HALT)
=======
				dk_rename(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.exe ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.exe.backup OVERWRITE NO_HALT)
			endif()
			if(RELEASE)
				dk_rename(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.exe ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.exe.backup OVERWRITE NO_HALT)
>>>>>>> Development
			endif()
		endif()
		
		####################### Create Executable Target ###################
		if(HAVE_DK)
<<<<<<< HEAD
			##set_source_files_properties(${DIGITALKNOB_DIR}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
			dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/win/resource.h ${DK_PROJECT_DIR}/resource.h)
			dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/win/resource.rc ${DK_PROJECT_DIR}/resource.rc)
			file(GLOB_RECURSE resources_SRC 
				${DK_PROJECT_DIR}/*.manifest
				${DK_PROJECT_DIR}/*.rc
				${DK_PROJECT_DIR}/icons/windows/*.rc)
=======
			##set_source_files_properties($ENV{DIGITALKNOB_DIR}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
			dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/win/resource.h ${DK_Project_Dir}/resource.h)
			dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/win/resource.rc ${DK_Project_Dir}/resource.rc)
			file(GLOB_RECURSE resources_SRC 
				${DK_Project_Dir}/*.manifest
				${DK_Project_Dir}/*.rc
				${DK_Project_Dir}/icons/windows/*.rc)
>>>>>>> Development
			list(APPEND App_SRC ${resources_SRC})
		endif()

		# https://stackoverflow.com/a/74491601
		if(MSVC)
			add_executable(${APP_NAME} WIN32 ${App_SRC})
		else()
			add_executable(${APP_NAME} ${App_SRC})
		endif()
		
		########################## Add Dependencies ########################
		if(PROJECT_INCLUDE_DKPLUGINS)
			foreach(plugin ${dkdepend_list})
<<<<<<< HEAD
				if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
=======
				if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
>>>>>>> Development
					add_dependencies(${APP_NAME} ${plugin})
				endif()	
			endforeach()
		endif()
		
		############# Link Libraries, Set Startup Project #################
		if(MULTI_CONFIG)
			target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
		else()
			if(DEBUG)
				target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${LIBS})
			elseif(RELEASE)
				target_link_libraries(${APP_NAME} ${RELEASE_LIBS} ${LIBS})
			endif()
		endif()
		
		if(MSVC)
			list(APPEND DEBUG_LINK_FLAGS /MANIFEST:NO)
			list(APPEND DEBUG_LINK_FLAGS /MANIFESTUAC:NO)
			list(APPEND DEBUG_LINK_FLAGS /level='highestAvailable')
			list(APPEND DEBUG_LINK_FLAGS /uiAccess='true')
			#list(APPEND DEBUG_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
			list(APPEND DEBUG_LINK_FLAGS /SUBSYSTEM:CONSOLE)
			list(APPEND DEBUG_LINK_FLAGS /SAFESEH:NO)
			dk_replaceAll("${DEBUG_LINK_FLAGS}"  ";"  " "  DEBUG_FLAGS)
			
			##list(APPEND RELEASE_LINK_FLAGS /FORCE) ## MySQL lib needs /FORCE due to zlib redefinitions
			list(APPEND RELEASE_LINK_FLAGS /INCREMENTAL:NO)
			list(APPEND RELEASE_LINK_FLAGS /OPT:NOREF)
			list(APPEND RELEASE_LINK_FLAGS /MANIFEST:NO)
			list(APPEND RELEASE_LINK_FLAGS /MANIFESTUAC:NO)
			list(APPEND RELEASE_LINK_FLAGS /level='highestAvailable')
			list(APPEND RELEASE_LINK_FLAGS /uiAccess='true')
			#list(APPEND RELEASE_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
			list(APPEND RELEASE_LINK_FLAGS /SUBSYSTEM:CONSOLE)
			list(APPEND RELEASE_LINK_FLAGS /SAFESEH:NO)
			dk_replaceAll("${RELEASE_LINK_FLAGS}"  ";"  " "  RELEASE_FLAGS)
		
			set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
			set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${APP_NAME})
		endif()
	endif(WIN_X86_64)
		
# DEBUG
#	TODO
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_validate(DKAPPS_DIR "dk_DKAPPS_DIR()")
	dk_configureApp("${DKAPPS_DIR}/DKCore")
=======
	dk_debugFunc(0)
	
	dk_validate(DKCPP_APPS_DIR "dk_DKBRANCH_DIR()")
	dk_configureApp("$ENV{DKCPP_APPS_DIR}/DKCore")
>>>>>>> Development
endfunction()
