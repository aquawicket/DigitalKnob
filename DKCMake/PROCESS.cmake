if(DK_PROCESS_INCLUDED)
  return()
endif()
set(DK_PROCESS_INCLUDED true)

include(DKCMake/FUNCTIONS.cmake)
include(DKCMake/OPTIONS.cmake)


include(DKCMake/DISABLED.cmake)
get_filename_component(APP_NAME ${DKPROJECT} NAME)
string(REPLACE " " "_" APP_NAME ${APP_NAME})

# Generate the apps CMakeLists.txt file
DKSET(APP_CMAKEFILE "#Generated File: any changes will be overwritten")
DKSET(APP_CMAKEFILE "${APP_CMAKEFILE}CMAKE_MINIMUM_REQUIRED(VERSION 3.4)")
DKSET(APP_CMAKEFILE "${APP_CMAKEFILE}CMAKE_POLICY(SET CMP0054 NEW)")
DKSET(APP_CMAKEFILE "${APP_CMAKEFILE}set(CMAKE_CXX_STANDARD 17)")
DKSET(APP_CMAKEFILE "${APP_CMAKEFILE}set(CMAKE_CXX_STANDARD_REQUIRED ON)")
DKSET(APP_CMAKEFILE "${APP_CMAKEFILE}PROJECT(${APP_NAME})")


DKBUILD_LOG("\n")
DKBUILD_LOG("##############################################")
DKBUILD_LOG("###############  DigitalKnob  ################")
DKBUILD_LOG("##############################################")
DKBUILD_LOG("\n")
DKBUILD_LOG("###########  HOST SYSTEM VARIABLES  ##########")
DKBUILD_LOG("CMAKE_HOST_SYSTEM_NAME:        ${CMAKE_HOST_SYSTEM_NAME}")
DKBUILD_LOG("CMAKE_HOST_SYSTEM_VERSION:     ${CMAKE_HOST_SYSTEM_VERSION}")
DKBUILD_LOG("CMAKE_HOST_SYSTEM_PROCESSOR:   ${CMAKE_HOST_SYSTEM_PROCESSOR}")
DKBUILD_LOG("CMAKE_LIBRARY_ARCHITECTURE:    ${CMAKE_LIBRARY_ARCHITECTURE}")
DKBUILD_LOG("ENV(USERNAME):                 $ENV{USERNAME}")
DKBUILD_LOG("DIGITALKNOB:                   ${DIGITALKNOB}")
DKBUILD_LOG("3RDPARTY:                      ${3RDPARTY}")
DKBUILD_LOG("DKPLUGINS:                     ${DKPLUGINS}")
DKBUILD_LOG("\n")
DKBUILD_LOG("#############  PROJECT VARIABLES  ############")
DKBUILD_LOG("APP_NAME:         ${APP_NAME}")            ### APP_NAME is set to the App folder name
DKBUILD_LOG("DKPROJECT:        ${DKPROJECT}")
DKBUILD_LOG("CMAKE_BINARY_DIR: ${CMAKE_BINARY_DIR}")
DKBUILD_LOG("DEBUG_DIR:        ${DEBUG_DIR}")
DKBUILD_LOG("RELEASE_DIR:      ${RELEASE_DIR}")
DKBUILD_LOG("CMAKE_GENERATOR:  ${CMAKE_GENERATOR}")
DKBUILD_LOG("OS:               ${OS}")
DKBUILD_LOG("DEBUG:            ${DEBUG}")
DKBUILD_LOG("RELEASE:          ${RELEASE}")
DKBUILD_LOG("BUILD:            ${BUILD}")
DKBUILD_LOG("REBUILD:          ${REBUILD}")
DKBUILD_LOG("REBUILDALL:       ${REBUILDALL}")
DKBUILD_LOG("LIB_TYPE:         ${LIB_TYPE}")
DKBUILD_LOG("OPENGL2:          ${OPENGL2}")
DKBUILD_LOG("USE_SHADERS:      ${USE_SHADERS}")
DKBUILD_LOG("DKCEF:            ${DKCEF}")
DKBUILD_LOG("WIN:              ${WIN}")
DKBUILD_LOG("WIN_32:           ${WIN_32}")
DKBUILD_LOG("WIN_64:           ${WIN_64}")
DKBUILD_LOG("MAC:              ${MAC}")
DKBUILD_LOG("MAC_32:           ${MAC_32}")
DKBUILD_LOG("MAC_64:           ${MAC_64}")
DKBUILD_LOG("IOS:              ${IOS}")
DKBUILD_LOG("IOS_32:           ${IOS_32}")
DKBUILD_LOG("IOS_64:           ${IOS_64}")
DKBUILD_LOG("IOSSIM:           ${IOSSIM}")
DKBUILD_LOG("IOSSIM_32:        ${IOSSIM_32}")
DKBUILD_LOG("IOSSIM_64:        ${IOSSIM_64}")
DKBUILD_LOG("LINUX:            ${LINUX}")
DKBUILD_LOG("LINUX_32:         ${LINUX_32}")
DKBUILD_LOG("LINUX_64:         ${LINUX_64}")
DKBUILD_LOG("ANDROID:          ${ANDROID}")
DKBUILD_LOG("ANDROID_32:       ${ANDROID_32}")
DKBUILD_LOG("ANDROID_64:       ${ANDROID_64}")
DKBUILD_LOG("RASPBERRY:        ${RASPBERRY}")
DKBUILD_LOG("RASPBERRY_32:     ${RASPBERRY_32}")
DKBUILD_LOG("RASPBERRY_64:     ${RASPBERRY_64}")
DKBUILD_LOG("\n\n")


############################################################################################
############################   ADD EXECUTABLE  #############################################
############################################################################################
PROJECT(${APP_NAME})

DKSET(DKAPP ON) ##TODO:  phase this out

##################################################
##### Scan the DKPlugins and build the lists #####
##################################################
include(${DKCMAKE}/BuildTools.cmake) #FIXME - this doesn't obey ordering, these dependencies shound come first. Possibly because it's not named "DKMAKE.cmake" ?
include(${DKPROJECT}/DKMAKE.cmake)

DKBUILD_LOG("\n**********************************")
DKBUILD_LOG("*** ENABLED DKPLUGINS (sorted) ***")
DKBUILD_LOG("**********************************\n")
list(REMOVE_DUPLICATES dkdepend_list)
foreach(plugin ${dkdepend_list})
	DKBUILD_LOG("${plugin}")	
endforeach()
message(STATUS "\n\n")

#message(STATUS "*** DISABLED DKPLUGINS  *****")
#foreach(offplugin ${dkdepend_disable_list})
#	message(STATUS "${offplugin}")	
#endforeach()
#message(STATUS "\n\n")


foreach(plugin ${dkdepend_list})
	DKSET(QUEUE_BUILD OFF)
	DKSET(LIBLIST "") ## used for double checking
	DKSET(CMAKE_FILE "")
	DKSET(ANDROID_LIBMK "")
	
	message(STATUS "\n***************************************")
	message(STATUS "**** Processing   ${plugin}")
	message(STATUS "***************************************\n")
	
	##Strip any sublibrary named in the plugin
	string(FIND "${plugin}" " " index)
	if(${index} GREATER -1)
		math(EXPR index "${index}+1")
		string(SUBSTRING ${plugin} ${index} -1 arg2)
		math(EXPR index "${index}-1")
		string(SUBSTRING ${plugin} 0 ${index} plugin)
		DKENABLE(${arg2})
	endif()
	
	#################### 3rdParty libs #####################
	dk_getPathToPlugin(${plugin} plugin_path)
	if(NOT plugin_path)
		RETURN()
	endif()

	#This actually executes the 3rdParty library builds
	include(${plugin_path}/DKMAKE.cmake)
	
	####################### DKPlugins #######################
	string(FIND "${DKCPPPLUGS}" "${plugin}" index)
	if(${index} GREATER -1)
		DKENABLE(${plugin})
		WIN_DEBUG_LIB(${plugin_path}/${OS}/${DEBUG_DIR}/${plugin}.lib)
		WIN_RELEASE_LIB(${plugin_path}/${OS}/${RELEASE_DIR}/${plugin}.lib)
		APPLE_DEBUG_LIB(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin}.a)
		APPLE_RELEASE_LIB(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin}.a)
		LINUX_DEBUG_LIB(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin}.a)
		LINUX_RELEASE_LIB(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin}.a)
		RASPBERRY_DEBUG_LIB(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin}.a)
		RASPBERRY_RELEASE_LIB(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin}.a)
		ANDROID_DEBUG_LIB(${plugin_path}/${OS}/${DEBUG_DIR}/lib${plugin}.a)
		ANDROID_RELEASE_LIB(${plugin_path}/${OS}/${RELEASE_DIR}/lib${plugin}.a)
		if(REBUILD OR REBUILDALL)
			DKSET(QUEUE_BUILD ON)
		endif()
	endif()
	
	if(QUEUE_BUILD AND CMAKE_FILE)
		if(REBUILDALL)
			DKREMOVE(${plugin_path}/CMakeLists.txt)
			foreach(the_lib ${LIBLIST})
				message(STATUS "Removing ${the_lib}")
				DKREMOVE(${the_lib})
			endforeach()
		endif()
		if(NOT EXISTS ${plugin_path}/CMakeLists.txt)
			message(STATUS "Creating CMakeLists.txt file for ${plugin}....")
			file(WRITE ${plugin_path}/CMakeLists.txt ${CMAKE_FILE})
		endif()

		DKSET(CURRENT_DIR ${plugin_path}/${OS})
		dk_makeDirectory(${CURRENT_DIR})		
		if(WIN_32)
			WIN32_COMMAND(${DKCMAKE_WIN32} -DWIN_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
			if(DEBUG)
				WIN32_COMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
			endif()
			if(RELEASE)
				WIN32_COMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
			endif()
		endif()
		if(WIN_64)
			WIN64_COMMAND(${DKCMAKE_WIN64} -DWIN_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
			if(DEBUG)
				WIN64_COMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
			endif()
			if(RELEASE)
				WIN64_COMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
			endif()
		endif()
		if(MAC_32)
			MAC32_COMMAND(${DKCMAKE_MAC32} -DMAC_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
			if(DEBUG)
				MAC32_COMMAND(xcodebuild -configuration Debug build)
			endif()
			if(RELEASE)
				MAC32_COMMAND(xcodebuild -configuration Release build)
			endif()
		endif()
		if(MAC_64)
			MAC64_COMMAND(${DKCMAKE_MAC64} -DMAC_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
			if(DEBUG)
				MAC64_COMMAND(xcodebuild -configuration Debug build)
			endif()
			if(RELEASE)
				MAC64_COMMAND(xcodebuild -configuration Release build)
			endif()
		endif()
		if(IOS_32)
			IOS32_COMMAND(${DKCMAKE_IOS32} -DIOS_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
			if(DEBUG)
				IOS32_COMMAND(xcodebuild -configuration Debug build -sdk iphoneos11.2)
			endif()
			if(RELEASE)
				IOS32_COMMAND(xcodebuild -configuration Release build -sdk iphoneos11.2)
			endif()
		endif()
		if(IOS_64)
			IOS64_COMMAND(${DKCMAKE_IOS64} -DIOS_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
			if(DEBUG)
				IOS64_COMMAND(xcodebuild -configuration Debug build)
			endif()
			if(RELEASE)
				IOS64_COMMAND(xcodebuild -configuration Release build)
			endif()
		endif()
		if(IOSSIM_32)
			IOSSIM32_COMMAND(${DKCMAKE_IOSSIM32} -DIOSSIM_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
			if(DEBUG)
				IOSSIM32_COMMAND(xcodebuild -configuration Debug build -sdk iphonesimulator11.2)
			endif()
			if(RELEASE)
				IOSSIM32_COMMAND(xcodebuild -configuration Release build -sdk iphonesimulator11.2)
			endif()
		endif()
		if(IOSSIM_64)
			IOSSIM64_COMMAND(${DKCMAKE_IOSSIM64} -DIOSSIM_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
			if(DEBUG)
				IOSSIM64_COMMAND(xcodebuild -configuration Debug build -sdk iphonesimulator11.2)
			endif()
			if(RELEASE)
				IOSSIM64_COMMAND(xcodebuild -configuration Release build -sdk iphonesimulator11.2)
			endif()
		endif()
		if(LINUX_32)
			if(DEBUG)
				DKSET(CURRENT_DIR ${plugin_path}/${OS}/${DEBUG_DIR})
				dk_makeDirectory(${CURRENT_DIR})
				LINUX32_COMMAND(${DKCMAKE_LINUX_DEBUG} -DLINUX_32=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
				LINUX32_COMMAND(make)
			endif()
			if(RELEASE)
				DKSET(CURRENT_DIR ${plugin_path}/${OS}/${RELEASE_DIR})
				dk_makeDirectory(${CURRENT_DIR})
				LINUX32_COMMAND(${DKCMAKE_LINUX_RELEASE} -DLINUX_32=ON -DREBUILD=ON -DRELEASE=ON ${plugin_path})
				LINUX32_COMMAND(make)
			endif()
		endif()
		if(LINUX_64)
			if(DEBUG)
				DKSET(CURRENT_DIR ${plugin_path}/${OS}/${DEBUG_DIR})
				dk_makeDirectory(${CURRENT_DIR})
				LINUX64_COMMAND(${DKCMAKE_LINUX_DEBUG} -DLINUX_64=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
				LINUX64_COMMAND(make)
			endif()
			if(RELEASE)
				DKSET(CURRENT_DIR ${plugin_path}/${OS}/${RELEASE_DIR})
				dk_makeDirectory(${CURRENT_DIR})
				LINUX64_COMMAND(${DKCMAKE_LINUX_RELEASE} -DLINUX_64=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				LINUX64_COMMAND(make)
			endif()
		endif()
		if(RASPBERRY_32)
			if(DEBUG)
				DKSET(CURRENT_DIR ${plugin_path}/${OS}/${DEBUG_DIR})
				dk_makeDirectory(${CURRENT_DIR})
				RASPBERRY32_COMMAND(${DKCMAKE_RASPBERRY_DEBUG} -DRASPBERRY_32=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
				RASPBERRY32_COMMAND(make)
			endif()
			if(RELEASE)
				DKSET(CURRENT_DIR ${plugin_path}/${OS}/${RELEASE_DIR})
				dk_makeDirectory(${CURRENT_DIR})
				RASPBERRY32_COMMAND(${DKCMAKE_RASPBERRY_RELEASE} -DRASPBERRY_32=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				RASPBERRY32_COMMAND(make)
			endif()
		endif()
		if(RASPBERRY_64)
			if(DEBUG)
				DKSET(CURRENT_DIR ${plugin_path}/${OS}/${DEBUG_DIR})
				dk_makeDirectory(${CURRENT_DIR})
				RASPBERRY64_COMMAND(${DKCMAKE_RASPBERRY_DEBUG} -DRASPBERRY_64=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
				RASPBERRY64_COMMAND(make)
			endif()
			if(RELEASE)
				DKSET(CURRENT_DIR ${plugin_path}/${OS}/${RELEASE_DIR})
				dk_makeDirectory(${CURRENT_DIR})
				RASPBERRY64_COMMAND(${DKCMAKE_RASPBERRY_RELEASE} -DRASPBERRY_64=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				RASPBERRY64_COMMAND(make)
			endif()
		endif()
		if(ANDROID_32)
			ANDROID32_COMMAND(${DKCMAKE_ANDROID32} -DANDROID_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
			if(DEBUG)
				ANDROID32_COMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
			endif()
			if(RELEASE)
				ANDROID32_COMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
			endif()
		endif()
		if(ANDROID_64)
			ANDROID64_COMMAND(${DKCMAKE_ANDROID64} -DANDROID_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
			if(DEBUG)
				ANDROID64_COMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
			endif()
			if(RELEASE)
				ANDROID64_COMMAND(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
			endif()
		endif()
		
		#FIXME: This needs to be removed and better checks put in place to copy compiled files
		#include(${plugin_path}/DKMAKE.cmake) ##run it again to copy any .exe and .dll files. 
	endif()
	
	## double check that the missing libs were built
	foreach(the_lib ${LIBLIST})
		if(NOT EXISTS ${the_lib})
			message(FATAL_ERROR "\n\n\n********************************************\nFAILED to find: ${the_lib} \n********************************************")
			message(FATAL_ERROR " ")
		endif()
	endforeach()
	DKSET(CMAKE_FILE "") ##Linux cache file fix
	endforeach()

	

message(STATUS "\n")
message(STATUS "***************************************")
message(STATUS "********** Creating ${APP_NAME} **********")
message(STATUS "***************************************\n")

## Create the DKPlugins.h header file
if(PLUGINS_FILE)
	string(REPLACE "#include \"DKWindow.h\"" "" PLUGINS_FILE ${PLUGINS_FILE})
	string(REPLACE "\\n" "\n" PLUGINS_FILE ${PLUGINS_FILE})
	file(WRITE ${DKPROJECT}/DKPlugins.h ${PLUGINS_FILE})
endif()

message(STATUS "Copying DKPlugins/_DKIMPORT/ to App...")
DKCOPY(${DKPLUGINS}/_DKIMPORT/icons ${DKPROJECT}/icons FALSE) ## copy app default files recursivly without overwrite
DKCOPY(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h FALSE) ## copy app default files recursivly without overwrite
DKCOPY(${DKPLUGINS}/_DKIMPORT/App.h ${DKPROJECT}/App.h FALSE) ## copy app default files recursivly without overwrite
DKCOPY(${DKPLUGINS}/_DKIMPORT/App.cpp ${DKPROJECT}/App.cpp FALSE) ## copy app default files recursivly without overwrite
	
### Include all source files from the app folder for the compilers
#file(GLOB App_SRC
file(GLOB_RECURSE App_SRC 
	${DKPROJECT}/*.c
	${DKPROJECT}/*.cpp
list(FILTER App_SRC EXCLUDE REGEX "${DKPROJECT}/assets/*" )
list(FILTER App_SRC EXCLUDE REGEX "${DKPROJECT}/${OS}/*" )
	

add_definitions(-DDKAPP) #Can we phase this out?
include_directories(${DKPROJECT})

##########
if(WIN_32)
	file(GLOB_RECURSE resources_SRC 
	${DKPROJECT}/*.manifest
	${DKPROJECT}/*.rc
	${DKPROJECT}/icons/windows/*.rc)
	list (APPEND App_SRC ${resources_SRC})
	
	DKCOPY(${DKPLUGINS}/_DKIMPORT/resource.h ${DKPROJECT}/resource.h FALSE) ## copy app default files recursivly without overwrite
	DKCOPY(${DKPLUGINS}/_DKIMPORT/resource.rc ${DKPROJECT}/resource.rc FALSE) ## copy app default files recursivly without overwrite
	
	## Create Icon files for project
	if(IMAGEMAGICK_CONVERT)
		message(STATUS "Building icons for ${APP_NAME} . . .")
		dk_makeDirectory(${DKPROJECT}/icons/windows)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=256,128,64,48,32,16 ${DKPROJECT}/icons/windows/icon.ico)
		DKCOPY(${DKPROJECT}/icons/windows/icon.ico ${DKPROJECT}/assets/icon.ico TRUE) # copy the icon to assets
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=16 ${DKPROJECT}/assets/favicon.ico)
	endif()
	
	if(NOT EXCLUDE_ASSETS)
		# Backup files and folders excluded from the package
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		##DKCOPY(${DKPROJECT}/assets/DKCef/win32Debug ${DKPROJECT}/Backup/DKCef/win32Debug TRUE)     #NOTE: need to remove all folders that are not for this OS
		##DKCOPY(${DKPROJECT}/assets/DKCef/win32Release ${DKPROJECT}/Backup/DKCef/win32Release TRUE)
		DKCOPY(${DKPROJECT}/assets/cef.log ${DKPROJECT}/Backup/cef.log TRUE)
		DKCOPY(${DKPROJECT}/assets/log.txt ${DKPROJECT}/Backup/log.txt TRUE)
	
		# Remove excluded files and folders before packaging
		DKREMOVE(${DKPROJECT}/assets/USER)
		##DKREMOVE(${DKPROJECT}/assets/DKCef/win32Debug)
		##DKREMOVE(${DKPROJECT}/assets/DKCef/win32Release)
		DKREMOVE(${DKPROJECT}/assets/cef.log)
		DKREMOVE(${DKPROJECT}/assets/log.txt)
	
		#Compress the assets, they will be included by resource.rc
		message(STATUS "Creating assets.zip . . .")
		DKZIP(${DKPROJECT}/assets)
		
		# Restore the backed up files, excluded from assets
		DKCOPY(${DKPROJECT}/Backup ${DKPROJECT}/assets TRUE)
		DKREMOVE(${DKPROJECT}/Backup)
	endif()
	
	DKCOPY(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h TRUE) #required
	
	add_definitions(-D_USING_V110_SDK71_)
	add_executable(${APP_NAME} WIN32 ${App_SRC})
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	##set_source_files_properties(${DIGITALKNOB}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
	
	list(APPEND DEBUG_LINK_FLAGS /MANIFEST:NO)
	list(APPEND DEBUG_LINK_FLAGS /MANIFESTUAC:NO)
	list(APPEND DEBUG_LINK_FLAGS /level='highestAvailable')
	list(APPEND DEBUG_LINK_FLAGS /uiAccess='true')
	list(APPEND DEBUG_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
	list(APPEND DEBUG_LINK_FLAGS /SAFESEH:NO)
	string(REPLACE ";" " " DEBUG_FLAGS "${DEBUG_LINK_FLAGS}")
	
	##list(APPEND RELEASE_LINK_FLAGS /FORCE) ## This can be used to debug if libraries cause redefinitions
	list(APPEND RELEASE_LINK_FLAGS /INCREMENTAL:NO)
	list(APPEND RELEASE_LINK_FLAGS /OPT:NOREF)
	list(APPEND RELEASE_LINK_FLAGS /MANIFEST:NO)
	list(APPEND RELEASE_LINK_FLAGS /MANIFESTUAC:NO)
	list(APPEND RELEASE_LINK_FLAGS /level='highestAvailable')
	list(APPEND RELEASE_LINK_FLAGS /uiAccess='true')
	list(APPEND RELEASE_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
	list(APPEND RELEASE_LINK_FLAGS /SAFESEH:NO)
	string(REPLACE ";" " " RELEASE_FLAGS "${RELEASE_LINK_FLAGS}")
	
	#add_custom_command(
    #TARGET ${APP_NAME}
    #POST_BUILD
    #COMMAND "mt.exe" -nologo
    #        -manifest \"${DKPROJECT}/compatibility.manifest\"
    #        -outputresource:"${DKPROJECT}/win32/Debug/${APP_NAME}.exe"\;\#1
    #COMMENT "Adding manifest..."
    #)
	
	set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
	#set_target_properties(${APP_NAME} PROPERTIES DEBUG_POSTFIX d)	
endif(WIN_32)
	
##########
if(WIN_64)
	DKCOPY(${DKPLUGINS}/_DKIMPORT/resource.h ${DKPROJECT}/resource.h FALSE) ## copy app default files recursivly without overwrite
	DKCOPY(${DKPLUGINS}/_DKIMPORT/resource.rc ${DKPROJECT}/resource.rc FALSE) ## copy app default files recursivly without overwrite
	
	## Create Icon files for project
	if(IMAGEMAGICK_CONVERT)
		message(STATUS "Building icons for ${APP_NAME} . . .")
		dk_makeDirectory(${DKPROJECT}/icons/windows)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=256,128,64,48,32,16 ${DKPROJECT}/icons/windows/icon.ico)
		DKCOPY(${DKPROJECT}/icons/windows/icon.ico ${DKPROJECT}/assets/icon.ico TRUE)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=16 ${DKPROJECT}/assets/favicon.ico)
	endif()
	
	if(NOT EXCLUDE_ASSETS)
		# Backup files and folders excluded from the package
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		#DKCOPY(${DKPROJECT}/assets/DKCef/win64Debug ${DKPROJECT}/Backup/DKCef/win64Debug TRUE)
		#DKCOPY(${DKPROJECT}/assets/DKCef/win64Release ${DKPROJECT}/Backup/DKCef/win64Release TRUE)
		DKCOPY(${DKPROJECT}/assets/cef.log ${DKPROJECT}/Backup/cef.log TRUE)
		DKCOPY(${DKPROJECT}/assets/log.txt ${DKPROJECT}/Backup/log.txt TRUE)
	
		# Remove excluded files and folders before packaging
		DKREMOVE(${DKPROJECT}/assets/USER)
		#DKREMOVE(${DKPROJECT}/assets/DKCef/win64Debug)
		#DKREMOVE(${DKPROJECT}/assets/DKCef/win64Release)
		DKREMOVE(${DKPROJECT}/assets/cef.log)
		DKREMOVE(${DKPROJECT}/assets/log.txt)
	
		#Compress the assets, they will be included by resource.rc
		message(STATUS "Creating assets.zip . . .")
		DKZIP(${DKPROJECT}/assets)
		
		# Restore the backed up files
		DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ TRUE)
		DKREMOVE(${DKPROJECT}/Backup)
	endif()

	#dummy assets.h file, or the builder wil complain about assets.h missing
	DKCOPY(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h TRUE)
		
	add_definitions(-D_USING_V110_SDK71_)
	add_executable(${APP_NAME} WIN32 ${App_SRC})
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	##set_source_files_properties(${DIGITALKNOB}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
	
	list(APPEND DEBUG_LINK_FLAGS /MANIFEST:NO)
	list(APPEND DEBUG_LINK_FLAGS /MANIFESTUAC:NO)
	list(APPEND DEBUG_LINK_FLAGS /level='highestAvailable')
	list(APPEND DEBUG_LINK_FLAGS /uiAccess='true')
	list(APPEND DEBUG_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
	list(APPEND DEBUG_LINK_FLAGS /SAFESEH:NO)
	string(REPLACE ";" " " DEBUG_FLAGS "${DEBUG_LINK_FLAGS}")
	
	##list(APPEND RELEASE_LINK_FLAGS /FORCE) ## MySQL lib needs /FORCE due to zlib redefinitions
	list(APPEND RELEASE_LINK_FLAGS /INCREMENTAL:NO)
	list(APPEND RELEASE_LINK_FLAGS /OPT:NOREF)
	list(APPEND RELEASE_LINK_FLAGS /MANIFEST:NO)
	list(APPEND RELEASE_LINK_FLAGS /MANIFESTUAC:NO)
	list(APPEND RELEASE_LINK_FLAGS /level='highestAvailable')
	list(APPEND RELEASE_LINK_FLAGS /uiAccess='true')
	list(APPEND RELEASE_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
	list(APPEND RELEASE_LINK_FLAGS /SAFESEH:NO)
	string(REPLACE ";" " " RELEASE_FLAGS "${RELEASE_LINK_FLAGS}")
	
	set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
	#set_target_properties(${APP_NAME} PROPERTIES DEBUG_POSTFIX d)
	
	#add_custom_command(
    #TARGET ${APP_NAME}
    #POST_BUILD
    #COMMAND "mt.exe" -nologo
    #        -manifest \"${DKPROJECT}/compatibility.manifest\"
    #        -outputresource:"${DKPROJECT}/win32/Debug/${APP_NAME}.exe"\;\#1
    #COMMENT "Adding manifest..."
    #)
endif(WIN_64)

#######
if(MAC)
	# remove files not needed for android
	list(REMOVE_ITEM App_SRC ${DKPROJECT}/resource.h)
	list(REMOVE_ITEM App_SRC ${DKPROJECT}/resource.rc)
	
	if(NOT EXCLUDE_ASSETS)
		# Backup files and folders excluded from the package
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		DKCOPY(${DKPROJECT}/assets/DKCef/mac64Debug ${DKPROJECT}/Backup/DKCef/mac64Debug TRUE)
		DKCOPY(${DKPROJECT}/assets/DKCef/mac64Release ${DKPROJECT}/Backup/DKCef/mac64Release TRUE)
		DKCOPY(${DKPROJECT}/assets/cef.log ${DKPROJECT}/Backup/cef.log TRUE)
		DKCOPY(${DKPROJECT}/assets/log.txt ${DKPROJECT}/Backup/log.txt TRUE)
	
		# Remove excluded files and folders before packaging
		DKREMOVE(${DKPROJECT}/assets/USER)
		DKREMOVE(${DKPROJECT}/assets/DKCef/mac64Debug)
		DKREMOVE(${DKPROJECT}/assets/DKCef/mac64Release)
		DKREMOVE(${DKPROJECT}/assets/cef.log)
		DKREMOVE(${DKPROJECT}/assets/log.txt)
	
		## ICONS 
		## // TODO
		## message(STATUS "Building icons for ${APP_NAME} . . .")
	
		## copy the assets into the bundle resources
		if(DEBUG)
			#dk_makeDirectory(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/Contents/Resources)
			dk_makeDirectory(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/Contents/Resources)
			DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/Contents/Resources TRUE)
			DKCOPY(${DKPROJECT}/icons/mac/logo.icns ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/Contents/Resources/logo.icns TRUE)
		endif()
		if(RELEASE)
			#dk_makeDirectory(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/Contents/Resources)
			dk_makeDirectory(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/Contents/Resources)
			DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/Contents/Resources TRUE)
			DKCOPY(${DKPROJECT}/icons/mac/logo.icns ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/Contents/Resources/logo.icns TRUE)
		endif()
	
		# Restore the backed up files, excluded from assets
		DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
		DKREMOVE(${DKPROJECT}/Backup)
	endif()
	
	FIND_LIBRARY(CF CoreFoundation)
	MAC_LIB(${CF})
	FIND_LIBRARY(CO Cocoa)
	MAC_LIB(${CO})
	FIND_LIBRARY(CB Carbon)
	MAC_LIB(${CB})
	FIND_LIBRARY(AT AudioToolbox)
	MAC_LIB(${AT})
	FIND_LIBRARY(AU AudioUnit)
	MAC_LIB(${AU})
	FIND_LIBRARY(CA CoreAudio)
	MAC_LIB(${CA})
	FIND_LIBRARY(CV CoreVideo)
	MAC_LIB(${CV})
	FIND_LIBRARY(IO IOKit)
	MAC_LIB(${IO})
	FIND_LIBRARY(GL OpenGL)
	MAC_LIB(${GL})
	FIND_LIBRARY(FF ForceFeedback)
	MAC_LIB(${FF})
	FIND_LIBRARY(AK AppKit)
	MAC_LIB(${AK})
	
	
	SET(CMAKE_OSX_ARCHITECTURES "x86_64")
	add_executable(${APP_NAME} MACOSX_BUNDLE ${App_SRC})
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	DKUPDATE_INFO_Plist(${APP_NAME}) #this may need to be run at post build
	#set_target_properties(${APP_NAME} PROPERTIES DEBUG_POSTFIX d)
endif()

#######
if(IOS)
	# remove files not needed for android
	list(REMOVE_ITEM App_SRC ${DKPROJECT}/resource.h)
	list(REMOVE_ITEM App_SRC ${DKPROJECT}/resource.rc)
	
	if(NOT EXCLUDE_ASSETS)
		# Backup files and folders excluded from the package
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		DKCOPY(${DKPROJECT}/assets/DKCef/ios64Debug ${DKPROJECT}/Backup/DKCef/ios64Debug TRUE)
		DKCOPY(${DKPROJECT}/assets/DKCef/ios64Release ${DKPROJECT}/Backup/DKCef/ios64Release TRUE)
		DKCOPY(${DKPROJECT}/assets/cef.log ${DKPROJECT}/Backup/cef.log TRUE)
		DKCOPY(${DKPROJECT}/assets/log.txt ${DKPROJECT}/Backup/log.txt TRUE)
	
		# Remove excluded files and folders before packaging
		DKREMOVE(${DKPROJECT}/assets/USER)
		DKREMOVE(${DKPROJECT}/assets/DKCef/ios64Debug)
		DKREMOVE(${DKPROJECT}/assets/DKCef/ios64Release)
		DKREMOVE(${DKPROJECT}/assets/cef.log)
		DKREMOVE(${DKPROJECT}/assets/log.txt)

		## copy the assets into the app
		message(STATUS "Building icons for ${APP_NAME} . . .")
		if(DEBUG)
			#dk_makeDirectory(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/assets)
			dk_makeDirectory(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/assets)
			DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/assets TRUE)
			DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app TRUE)
		endif()
		if(RELEASE)
			#dk_makeDirectory(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/assets)
			dk_makeDirectory(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/assets)
			DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/assets TRUE)
			DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app TRUE)
		endif()

		# Restore the backed up files, excluded from assets
		DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
		DKREMOVE(${DKPROJECT}/Backup)
	endif()
	
	### FrameWorks ###
	set(IOS_FRAMEWORKS
		Foundation
		AudioToolbox
		CoreGraphics
	   	QuartzCore
		UIKit
	    OpenGLES
		ImageIO
		MobileCoreServices
	)
	
	list(APPEND App_SRC ${DKPLUGINS}/DK/DKiPhone.mm)
	
	foreach(FW ${IOS_FRAMEWORKS})
		set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework ${FW}")
	endforeach()
	
	#set(CMAKE_OSX_SYSROOT iphoneos)
	#set(XCODE_ATTRIBUTE_SDKROOT iphoneos)
	#set(CMAKE_OSK_ARCHITECTURES "$(ARCHS_STANDARD_32_BIT)")
	set(CMAKE_CXX_FLAGS "-x objective-c++")
	#set(CMAKE_XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT dwarf)
	#set(MACOSX_BUNDLE_GUI_IDENTIFIER "com.digitalknob.\${PRODUCT_NAME:identifier}")
		
	#GET_TARGET_PROPERTY(MyExecutable_PATH ${APP_NAME} LOCATION)
	add_executable(${APP_NAME} MACOSX_BUNDLE ${App_SRC})
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	DKUPDATE_INFO_Plist(${APP_NAME}) #this may need to be run at post build
	#set_target_properties(${APP_NAME} PROPERTIES DEBUG_POSTFIX d)
endif()

##########
if(IOSSIM)
	# remove files not needed for android
	list(REMOVE_ITEM App_SRC ${DKPROJECT}/resource.h)
	list(REMOVE_ITEM App_SRC ${DKPROJECT}/resource.rc)
	
	if(NOT EXCLUDE_ASSETS)
		# Backup files and folders excluded from the package
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		DKCOPY(${DKPROJECT}/assets/DKCef/ios64Debug ${DKPROJECT}/Backup/DKCef/ios64Debug TRUE)
		DKCOPY(${DKPROJECT}/assets/DKCef/ios64Release ${DKPROJECT}/Backup/DKCef/ios64Release TRUE)
		DKCOPY(${DKPROJECT}/assets/cef.log ${DKPROJECT}/Backup/cef.log TRUE)
		DKCOPY(${DKPROJECT}/assets/log.txt ${DKPROJECT}/Backup/log.txt TRUE)
	
		# Remove excluded files and folders before packaging
		DKREMOVE(${DKPROJECT}/assets/USER)
		DKREMOVE(${DKPROJECT}/assets/DKCef/ios64Debug)
		DKREMOVE(${DKPROJECT}/assets/DKCef/ios64Release)
		DKREMOVE(${DKPROJECT}/assets/cef.log)
		DKREMOVE(${DKPROJECT}/assets/log.txt)
	
		## copy the assets into the app
		message(STATUS "Building icons for ${APP_NAME} . . .")
		if(DEBUG)
			dk_makeDirectoy(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/assets)
			DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/assets TRUE)
			DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app TRUE)
		endif()
		if(RELEASE)
			dk_makeDirectoy(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/assets)
			DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/assets TRUE)
			DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app TRUE)
		endif()
	
		# Restore the backed up files, excluded from assets
		DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
		DKREMOVE(${DKPROJECT}/Backup)
	endif()
	
	### FrameWorks ###
	set(IOS_FRAMEWORKS
		Foundation
		AudioToolbox
		CoreGraphics
	   	QuartzCore
		UIKit
	    OpenGLES
		ImageIO
		MobileCoreServices
	)
	
	list(APPEND App_SRC ${DKPLUGINS}/DK/DKiPhone.mm)
	
	foreach(FW ${IOS_FRAMEWORKS})
		set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework ${FW}")
	endforeach()
	
	##set(CMAKE_OSX_SYSROOT iphoneos)
	##set(XCODE_ATTRIBUTE_SDKROOT iphoneos)
	##set(CMAKE_OSX_ARCHITECTURES "$(ARCHS_STANDARD_32_BIT)")
	set(CMAKE_CXX_FLAGS "-x objective-c++")
    set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libstdc++")
	##set(CMAKE_XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT dwarf)
	##set(MACOSX_BUNDLE_GUI_IDENTIFIER "com.digitalknob.\${PRODUCT_NAME:identifier}")
	
	#GET_TARGET_PROPERTY(MyExecutable_PATH ${APP_NAME} LOCATION)
	add_executable(${APP_NAME} MACOSX_BUNDLE ${App_SRC})
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	DKUPDATE_INFO_Plist(${APP_NAME}) #this may need to be run at post build
	#set_target_properties(${APP_NAME} PROPERTIES DEBUG_POSTFIX d)
endif()

#########
if(LINUX)
	# remove files not needed for android
	list(REMOVE_ITEM App_SRC ${DKPROJECT}/resource.h)
	list(REMOVE_ITEM App_SRC ${DKPROJECT}/resource.rc)
	
	# Copy the icon to assets
	DKCOPY(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)

	if(NOT EXCLUDE_ASSETS)
		# backup files not going in the package
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		DKCOPY(${DKPROJECT}/assets/DKCef/linux32Debug ${DKPROJECT}/Backup/DKCef/linux32Debug TRUE)
		DKCOPY(${DKPROJECT}/assets/DKCef/linux32Release ${DKPROJECT}/Backup/DKCef/linux32Release TRUE)
		DKCOPY(${DKPROJECT}/assets/DKCef/linux64Debug ${DKPROJECT}/Backup/DKCef/linux64Debug TRUE)
		DKCOPY(${DKPROJECT}/assets/DKCef/linux64Release ${DKPROJECT}/Backup/DKCef/linux64Release TRUE)
		DKCOPY(${DKPROJECT}/assets/cef.log ${DKPROJECT}/Backup/cef.log TRUE)
		DKCOPY(${DKPROJECT}/assets/log.txt ${DKPROJECT}/Backup/log.txt TRUE)
	
		# Remove excluded files and folders before packaging
		DKREMOVE(${DKPROJECT}/assets/USER)
		DKREMOVE(${DKPROJECT}/assets/DKCef/linux32Debug)
		DKREMOVE(${DKPROJECT}/assets/DKCef/linux32Release)
		DKREMOVE(${DKPROJECT}/assets/DKCef/linux64Debug)
		DKREMOVE(${DKPROJECT}/assets/DKCef/linux64Release)
		DKREMOVE(${DKPROJECT}/assets/cef.log)
		DKREMOVE(${DKPROJECT}/assets/log.txt)
	
		message(STATUS "Creating assets.zip . . .")
		DKZIP(${DKPROJECT}/assets)
	
		#message(STATUS "Creating assets.h . . .")
		bin2h(SOURCE_FILE ${DKPROJECT}/assets.zip HEADER_FILE ${DKPROJECT}/assets.h VARIABLE_NAME "ASSETS_H")
	
		# Restore the backed up assets
		DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
		DKREMOVE(${DKPROJECT}/Backup)
	endif()

	LINUX_LIB(pthread)
	LINUX_LIB(dl)
	LINUX_LIB(libstdc++fs.a)
	
	#set(CMAKE_CXX_FLAGS "-g -no-pie -std=c++17")
	
	if(DEBUG)
		add_definitions(-DDEBUG)
		add_executable(${APP_NAME} ${App_SRC})
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${LIBS})
		#set_target_properties(${APP_NAME} PROPERTIES DEBUG_POSTFIX d)
	endif()
	if(RELEASE)
		add_executable(${APP_NAME} ${App_SRC})
		target_link_libraries(${APP_NAME} ${RELEASE_LIBS} ${LIBS})
	endif()
endif()


#############
if(RASPBERRY)
	# remove files not needed for android
	list(REMOVE_ITEM App_SRC ${DKPROJECT}/resource.h)
	list(REMOVE_ITEM App_SRC ${DKPROJECT}/resource.rc)
	
	# Copy the icon to assets
	DKCOPY(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)

	if(NOT EXCLUDE_ASSETS)
		# Backup files and folders excluded from the package
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		#DKCOPY(${DKPROJECT}/assets/DKCef/linux32Debug ${DKPROJECT}/Backup/DKCef/linux32Debug TRUE)
		#DKCOPY(${DKPROJECT}/assets/DKCef/linux32Release ${DKPROJECT}/Backup/DKCef/linux32Release TRUE)
		#DKCOPY(${DKPROJECT}/assets/DKCef/linux64Debug ${DKPROJECT}/Backup/DKCef/linux64Debug TRUE)
		#DKCOPY(${DKPROJECT}/assets/DKCef/linux64Release ${DKPROJECT}/Backup/DKCef/linux64Release TRUE)
		#DKCOPY(${DKPROJECT}/assets/cef.log ${DKPROJECT}/Backup/cef.log TRUE)
		DKCOPY(${DKPROJECT}/assets/log.txt ${DKPROJECT}/Backup/log.txt TRUE)
	
		# Remove excluded files and folders before packaging
		DKREMOVE(${DKPROJECT}/assets/USER)
		#DKREMOVE(${DKPROJECT}/assets/DKCef/linux32Debug)
		#DKREMOVE(${DKPROJECT}/assets/DKCef/linux32Release)
		#DKREMOVE(${DKPROJECT}/assets/DKCef/linux64Debug)
		#DKREMOVE(${DKPROJECT}/assets/DKCef/linux64Release)
		#DKREMOVE(${DKPROJECT}/assets/cef.log)
		DKREMOVE(${DKPROJECT}/assets/log.txt)
	
		message(STATUS "Creating assets.zip . . .")
		DKZIP(${DKPROJECT}/assets)
		message(STATUS "Creating assets.h . . .")
		bin2h(SOURCE_FILE ${DKPROJECT}/assets.zip HEADER_FILE ${DKPROJECT}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
		DKREMOVE(${DKPROJECT}/Backup)
	endif()

    RASPBERRY_LIB(pthread)
	RASPBERRY_LIB(dl)
	RASPBERRY_LIB(libstdc++fs.a)
	link_directories(/opt/vc/lib)
	RASPBERRY_LIB(bcm_host)
	
	#set(CMAKE_CXX_FLAGS "-g -no-pie -std=c++17")
	
	if(DEBUG)
		add_definitions(-DDEBUG)
		add_executable(${APP_NAME} ${App_SRC})
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${LIBS})
		#set_target_properties(${APP_NAME} PROPERTIES DEBUG_POSTFIX d)
	endif()
	if(RELEASE)
		add_executable(${APP_NAME} ${App_SRC})
		target_link_libraries(${APP_NAME} ${RELEASE_LIBS} ${LIBS})
	endif()
endif()



if(ANDROID)
	DKCOPY(${DKPLUGINS}/_DKIMPORT/Android.h ${DKPROJECT}/Android.h FALSE) ## copy app default files recursivly without overwrite
	if(ANDROID_32)
		DKCOPY(${DKPLUGINS}/_DKIMPORT/android32 ${DKPROJECT}/android32 FALSE) ## copy app default files recursivly without overwrite
	endif()
	if(ANDROID_64)
		DKCOPY(${DKPLUGINS}/_DKIMPORT/android64 ${DKPROJECT}/android64 FALSE) ## copy app default files recursivly without overwrite
	endif()
	# remove files not needed for android
	list(REMOVE_ITEM App_SRC ${DKPROJECT}/resource.h)
	list(REMOVE_ITEM App_SRC ${DKPROJECT}/resource.rc)
	
	## Create Android Icons
	if(IMAGEMAGICK_CONVERT)
		message(STATUS "Building icons for ${APP_NAME} . . .")
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-hdpi)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 72x72 ${DKPROJECT}/icons/android/drawable-hdpi/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-ldpi)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 36x36 ${DKPROJECT}/icons/android/drawable-ldpi/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-mdpi)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 48x48 ${DKPROJECT}/icons/android/drawable-mdpi/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-xhdpi)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 96x96 ${DKPROJECT}/icons/android/drawable-xhdpi/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-xxhdpi)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 144x144 ${DKPROJECT}/icons/android/drawable-xxhdpi/icon.png)
	endif()
	DKCOPY(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)
	DKCOPY(${DKPROJECT}/icons/icon.png ${DKPROJECT}/${OS}/res/drawable/icon.png TRUE)
	
	#DKUPDATE_ANDROID_NAME(${APP_NAME})
	
	set(CMAKE_CXX_FLAGS "-DDKAPP -DUSE_DK -std=c++17")
	set(CMAKE_CXX_FLAGS_DEBUG "-g2 -gdwarf-2 -O0 -DDEBUG") 
	set(CMAKE_CXX_FLAGS_RELEASE "-O3")
	#set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)
	
	set(CMAKE_ANDROID_GUI 1)
	#set(CMAKE_SYSTEM_NAME Android) 
	#set(CMAKE_SYSTEM_VERSION 26)
	#set(CMAKE_ANDROID_ARCH_ABI armeabi-v7a)
	#set(CMAKE_ANDROID_NDK ${ANDROIDNDK})
	#set(CMAKE_ANDROID_STL_TYPE c++_static)
	
	ANDROID_LIB(dl)
	#ANDROID_LIB(GLESv1_CM)
	#ANDROID_LIB(GLESv2)
	ANDROID_LIB(log)
	ANDROID_LIB(android)

	#add_executable(DKAndroid ${App_SRC})

	add_library(${APP_NAME} SHARED ${App_SRC})
	#target_include_directories(${APP_NAME} PUBLIC ${INCLUDE_DIRECTORIES}) #of ${DKINCLUDES_LIST}
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	#set_target_properties(${APP_NAME} PROPERTIES DEBUG_POSTFIX d)
	#add_dependencies(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS})	
	
	#include_external_msproject(DKGradle ${DKPROJECT}/${OS}/DKGradle.androidproj)
endif()


###########
#if(ANDROID)
#	#copy android files from DKPlugins/_DKIMPORT
#	#copy assets
#	DKREMOVE(${DKPROJECT}/assets/USER)
#	if(DEBUG)
#		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/assets TRUE)
#		DKCOPY(${DKPROJECT}/icons/android/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/res TRUE)
#	endif()
#	if(RELEASE)
#		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/assets TRUE)
#		DKCOPY(${DKPROJECT}/icons/android/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/res TRUE)
#	endif()
#	
#	#update app name
#	DKUPDATE_ANDROID_NAME(${APP_NAME})
#	
#	message(STATUS "Creating Android.mk file for ${APP_NAME}....")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_PATH := $(call my-dir)\n")
#	if(SDL)
#		message(STATUS "USING SDL FOR ANDROID")
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "include $(CLEAR_VARS)\n")
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_MODULE := SDL2\n")
#	if(DEBUG)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SRC_FILES := ${SDL}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libSDL2.so\n")
#	endif()
#	if(RELEASE)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SRC_FILES := ${SDL}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libSDL2.so\n")
#	endif()
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "include $(PREBUILT_SHARED_LIBRARY)\n")
#	endif()
#	
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "include $(CLEAR_VARS)\n")
#	if(DEBUG)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "BUILD_TYPE := Debug\n\n")
#	endif()
#	if(RELEASE)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "BUILD_TYPE := Release\n\n")
#	endif()
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_MODULE := DKAndroid\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "SRC_DIR := $(LOCAL_PATH)/../../..\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "DK_DIR := C:/Users/$ENV{USERNAME}/digitalknob\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "NDKLIBDIR := ${ANDROIDNDK}/sources/cxx-stl/gnu-libstdc++/4.8/libs/armeabi-v7a\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "DKPLUGINS := $(DK_DIR)/DKPlugins\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "3RDPARTY := $(DKPLUGINS)/3rdParty\n\n")
#
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_C_INCLUDES := $(LOCAL_PATH)\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_C_INCLUDES += $(SRC_DIR)\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CFLAGS := -fno-short-enums -fpermissive -fuse-ld=bfd\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDLIBS := -llog -lGLESv1_CM -lz -landroid\n")
#	#if(OPENGL2)
#	#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDLIBS := -llog -lGLESv2 -lz\n")
#	#else()
#	#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDLIBS := -llog -lGLESv1_CM -lz\n")
#	#endif()
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "APP_SRC := $(wildcard $(SRC_DIR)/*.cpp)\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "APP_SRC += $(wildcard $(SRC_DIR)/*.c)\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SRC_FILES := $(APP_SRC:$(LOCAL_PATH)/%=%)\n\n")
#
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS := -DANDROID\n")
#	if(ANDROID_32)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -DANDROID32\n")
#	endif()
#	if(ANDROID_64)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -DANDROID64\n")
#	endif()
#	#DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -D__ANDROID__\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_CPPFLAGS += -DDKAPP\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "ifeq ($(BUILD_TYPE),Debug)\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "	LOCAL_CPPFLAGS += -DDEBUG\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "else\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "	LOCAL_CPPFLAGS += -DNDEBUG\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "endif\n")
#
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LIBDIR := $(BUILD_TYPE)/obj/local/armeabi\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "	LOCAL_ARM_NEON := true\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "	LIBDIR := $(BUILD_TYPE)/obj/local/armeabi-v7a\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "endif\n\n")
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_LDFLAGS :=\n\n")
#   foreach(each_define ${DKDEFINES_LIST})
#		DKSET(ANDROID_LIBMK "${ANDROID_LIBMK} "LOCAL_LDFLAGS += ${each_define}\n")
#	endforeach()
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_C_INCLUDES += ${DKPLUGINS}\n")
#	foreach(each_include ${DKINCLUDES_LIST})
#		DKSET(ANDROID_LIBMK "${ANDROID_LIBMK} "LOCAL_C_INCLUDES += ${each_include}\n")
#	endforeach()
#	#list(REVERSE DKLIBRARIES)
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} ${DKLIBRARIES})
#			
#	if(SDL)
#		DKSET(ANDROID_APPMK ${ANDROID_APPMK} "LOCAL_SHARED_LIBRARIES := SDL2\n")
#	endif()
#	DKSET(ANDROID_APPMK ${ANDROID_APPMK} "include $(BUILD_SHARED_LIBRARY)\n\n")
#	
#	if(DEBUG)
#		file(WRITE ${DKPROJECT}/${OS}/${DEBUG_DIR}/jni/Android.mk ${ANDROID_APPMK})
#	endif()
#	if(RELEASE)
#		file(WRITE ${DKPROJECT}/${OS}/${RELEASE_DIR}/jni/Android.mk ${ANDROID_APPMK})
#	endif()
#endif()


#clean these cached variables
##DKSET(DKDEFINES "")
##DKSET(DKINCLUDES "")
##DKSET(DKLIBRARIES "")

DKSET(include_libs "${LIBS} ${DEBUG_LIBS} ${RELEASE_LIBS}")
DKBUILD_LOG("\n\n ${APP_NAME} Include Libraries \n")
foreach(the_lib ${include_libs})
	DKBUILD_LOG(${the_lib})
endforeach()
DKBUILD_LOG("\n\n *** Compiler Options and Flags *** \n")
DKBUILD_LOG("                APP_NAME:  ${APP_NAME}")
DKBUILD_LOG("     COMPILE_DEFINITIONS:  ${COMPILE_DEFINITIONS}")
DKBUILD_LOG("           DEFINE_SYMBOL:  ${DEFINE_SYMBOL}")
DKBUILD_LOG("         COMPILE_OPTIONS:  ${COMPILE_OPTIONS}")
DKBUILD_LOG("      CMAKE_CXX_STANDARD:  ${CMAKE_CXX_STANDARD}")
DKBUILD_LOG("           CMAKE_C_FLAGS:  ${CMAKE_C_FLAGS}")
DKBUILD_LOG("     CMAKE_C_FLAGS_DEBUG:  ${CMAKE_C_FLAGS_DEBUG}")
DKBUILD_LOG("   CMAKE_C_FLAGS_RELEASE:  ${CMAKE_C_FLAGS_RELEASE}")
DKBUILD_LOG("         CMAKE_CXX_FLAGS:  ${CMAKE_CXX_FLAGS}")
DKBUILD_LOG("   CMAKE_CXX_FLAGS_DEBUG:  ${CMAKE_CXX_FLAGS_DEBUG}")
DKBUILD_LOG(" CMAKE_CXX_FLAGS_RELEASE:  ${CMAKE_CXX_FLAGS_RELEASE}")
#DKBUILD_LOG("            LINK_OPTIONS:  ${LINK_OPTIONS}"}
DKBUILD_LOG("     INCLUDE_DIRECTORIES:  ${INCLUDE_DIRECTORIES}")
DKBUILD_LOG("        LINK_DIRECTORIES:  ${LINK_DIRECTORIES}")
DKBUILD_LOG("  STATIC_LIBRARY_OPTIONS:  ${STATIC_LIBRARY_OPTIONS}")
DKBUILD_LOG("             DEBUG_FLAGS:  ${DEBUG_FLAGS}")
DKBUILD_LOG("           RELEASE_FLAGS:  ${RELEASE_FLAGS})")
DKBUILD_LOG("                   FLAGS:  ${FLAGS}")
DKBUILD_LOG("          DKDEFINES_LIST:  ${DKDEFINES_LIST}")
DKBUILD_LOG("         DKINCLUDES_LIST:  ${DKINCLUDES_LIST}")
DKBUILD_LOG("         DKLINKDIRS_LIST:  ${DKLINKDIRS_LIST}")
file(WRITE ${DKPROJECT}/DKBUILD.log "${DKBUILD_LOG_FILE}")
DKSET(DKBUILD_LOG_FILE "")
	

# Generate a CMakelists.txt for the app. This is a work in progress
file(WRITE ${DKPROJECT}/CMakeLists.txt ${APP_CMAKEFILE})

message(STATUS "\n")
message(STATUS "***************************************")
message(STATUS "********** Finnished ${APP_NAME} **********")
message(STATUS "***************************************\n")
