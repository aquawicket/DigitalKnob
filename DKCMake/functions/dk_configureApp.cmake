#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_configureApp(Target_App_Dir)
#
#
function(dk_configureApp)
	dk_debugFunc()
	
	set(Target_App_Dir ${ARGV0})
	dk_basename(${Target_App_Dir} Target_App)
	
	dk_info("\n")
	dk_info("##############################################")
	dk_info("############ Creating ${Target_App} ############")
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
		dk_fileWrite("${Target_App_Dir}/DKPlugins.h" "${PLUGINS_FILE}")
	endif()

	dk_validate(DKCPP_PLUGINS_DIR "dk_DKBRANCH_DIR()")
	if(HAVE_DK)
		## copy app default files without overwrite
		dk_info("Copying DKCpp/plugins/_DKIMPORT/ to App...")
		dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/icons ${Target_App_Dir}/icons) 
		dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/assets.h ${Target_App_Dir}/assets.h)
		dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/main.cpp ${Target_App_Dir}/main.cpp)
	endif()

	# Copy VSCode project files to app
	dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/DKApp.code-workspace ${Target_App_Dir}/DKApp.code-workspace)
	dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/.vscode ${Target_App_Dir}/.vscode)

	### Include all source files from the app folder for the compilers
	#file(GLOB_RECURSE App_SRC
	file(GLOB App_SRC
		${Target_App_Dir}/*.h
		${Target_App_Dir}/*.c
		${Target_App_Dir}/*.hpp
		${Target_App_Dir}/*.cpp)
	list(FILTER App_SRC EXCLUDE REGEX "${Target_App_Dir}/assets/*")
	list(FILTER App_SRC EXCLUDE REGEX "${Target_App_Dir}/${Target_Tuple}/*")
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
	include_directories(${Target_App_Dir})
	include_directories(${DKCPP_PLUGINS_DIR})

	##############
	if(Windows_X86_64)
		########################## CREATE ICONS ###############################
		dk_createIcons(${Target_App_Dir}/icons/icon.png)
		
		################# BACKUP USERDATA / INJECT ASSETS #####################
		if(HAVE_DK)
			dk_copy(${Target_App_Dir}/assets/USER ${Target_App_Dir}/Backup/USER OVERWRITE NO_HALT)
			dk_delete(${Target_App_Dir}/assets/USER NO_HALT)
			#Compress the assets, they will be included by resource.rc
			dk_info("Creating assets.zip . . .")
			dk_compressAssets(${Target_App_Dir}/assets)
			# Restore the backed up files
			dk_copy(${Target_App_Dir}/Backup/ ${Target_App_Dir}/assets/ OVERWRITE NO_HALT)
			dk_delete(${Target_App_Dir}/Backup NO_HALT)
			#dummy assets.h file, or the builder wil complain about assets.h missing
			dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/assets.h ${Target_App_Dir}/assets.h OVERWRITE NO_HALT)
		endif()
		
		###################### Backup Executable ###########################
		if(BACKUP_APP_EXECUTABLES)
			if(Debug)
				dk_rename(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.exe ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.exe.backup OVERWRITE NO_HALT)
			endif()
			if(Release)
				dk_rename(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.exe ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.exe.backup OVERWRITE NO_HALT)
			endif()
		endif()
		
		####################### Create Executable Target ###################
		if(HAVE_DK)
			##set_source_files_properties($ENV{DIGITALKNOB_DIR}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
			dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/win/resource.h ${Target_App_Dir}/resource.h)
			dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/win/resource.rc ${Target_App_Dir}/resource.rc)
			file(GLOB_RECURSE resources_SRC 
				${Target_App_Dir}/*.manifest
				${Target_App_Dir}/*.rc
				${Target_App_Dir}/icons/windows/*.rc)
			list(APPEND App_SRC ${resources_SRC})
		endif()

		# https://stackoverflow.com/a/74491601
		if(MSVC)
			add_executable(${Target_App} WIN32 ${App_SRC})
		else()
			add_executable(${Target_App} ${App_SRC})
		endif()
		
		########################## Add Dependencies ########################
		if(PROJECT_INCLUDE_DKPLUGINS)
			foreach(plugin ${dkdepend_list})
				if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
					add_dependencies(${Target_App} ${plugin})
				endif()	
			endforeach()
		endif()
		
		############# Link Libraries, Set Startup Project #################
		if(MULTI_CONFIG)
			target_link_libraries(${Target_App} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
		else()
			if(Debug)
				target_link_libraries(${Target_App} ${DEBUG_LIBS} ${LIBS})
			elseif(Release)
				target_link_libraries(${Target_App} ${RELEASE_LIBS} ${LIBS})
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
		
			set_target_properties(${Target_App} PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
			set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${Target_App})
		endif()
	endif(Windows_X86_64)
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(DKCPP_APPS_DIR "dk_DKBRANCH_DIR()")
	dk_configureApp("$ENV{DKCPP_APPS_DIR}/DKCore")
endfunction()
