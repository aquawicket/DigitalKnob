message("!!!! PROCESS.cmake called !!!!")
if(DKPROCESS_INCLUDED)
  return()
endif(DKPROCESS_INCLUDED)
set(DKPROCESS_INCLUDED true)
message("!!!! PROCESS.cmake running !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")

message(STATUS "\n")
message(STATUS "############################################################")
message(STATUS "######################  DigitalKnob  #######################")
message(STATUS "############################################################")
message(STATUS "\n")
	
include(DKCMake/FUNCTIONS.cmake)
include(DKCMake/OPTIONS.cmake)
include(DKCMake/DISABLED.cmake)


get_filename_component(APP_NAME ${DKPROJECT} NAME)
string(REPLACE " " "_" APP_NAME ${APP_NAME})

dk_printSettings()

############################################################################################
############################   ADD EXECUTABLE  #############################################
############################################################################################
PROJECT(${APP_NAME})
DKSET(DKAPP ON)

##################################################
##### Scan the DKPlugins and build the lists #####
##################################################
include(${DKCMAKE}/BuildTools.cmake)
include(${DKPROJECT}/DKMAKE.cmake)

DKBUILD_LOG("############################################################")
DKBUILD_LOG("######  Enabled Dependencies (sorted by dependency)  #######")
DKBUILD_LOG("############################################################")
list(REMOVE_DUPLICATES dkdepend_list)
foreach(plugin ${dkdepend_list})
	DKBUILD_LOG("${plugin}")	
endforeach()
DKBUILD_LOG("\n")

foreach(plugin ${dkdepend_list})
	DKSET(QUEUE_BUILD OFF)
	DKSET(LIBLIST "") ## used for double checking
	DKSET(CMAKE_FILE "")
	DKSET(ANDROID_LIBMK "")
	
	message(STATUS "############################################################")
	message(STATUS "######  Processing   ${plugin} . . .                        ")
	message(STATUS "############################################################")
	
	##Strip any sublibrary named in the plugin, and enable it
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

	#This executes the 3rdParty library builds, and dkplugin setup
	include(${plugin_path}/DKMAKE.cmake)
	
	#string(TOUPPER ${plugin} PLUGIN_NAME)
	#if(EXISTS "${${PLUGIN_NAME}}/CMakeLists.txt")
	#	message(STATUS "PLUGIN_NAME = ${${PLUGIN_NAME}}/CMakeLists.txt")
	#	add_subdirectory(${${PLUGIN_NAME}} ${${PLUGIN_NAME}}/${OS})
	#endif()
	
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
			message(STATUS "######  Removed ${plugin}/CMakeLists.txt")
			foreach(the_lib ${LIBLIST})
				DKREMOVE(${the_lib})
				message(STATUS "######  Removed ${the_lib}")
			endforeach()
		endif()
		if(NOT EXISTS ${plugin_path}/CMakeLists.txt)
			message(STATUS "######  Creating CMakeLists.txt file for ${plugin} . . .")
			file(WRITE ${plugin_path}/CMakeLists.txt ${CMAKE_FILE})
		endif()

		# ADD THE PLUGIN TO THE APP SOLUTION
		if(EXISTS "${plugin_path}/CMakeLists.txt")
			if(LINUX OR RASPBERRY)
				if(DEBUG)
					add_subdirectory(${plugin_path} ${plugin_path}/${OS}/Debug)
				endif()
				if(RELEASE)
					add_subdirectory(${plugin_path} ${plugin_path}/${OS}/Release)
				endif()
			else()
				add_subdirectory(${plugin_path} ${plugin_path}/${OS})
			endif()
		endif()
		
		
		## Prebuild Plugins switch
		if(IOS)
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
		endif()
	endif()
	
	## double check that the missing libs were built
	#foreach(the_lib ${LIBLIST})
		#if(NOT EXISTS ${the_lib})
			#message(FATAL_ERROR "\n\n\n********************************************\nFAILED to find: ${the_lib} \n********************************************")
			#message(FATAL_ERROR " ")
		#endif()
	#endforeach()
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
	${DKPROJECT}/*.cpp)
list(FILTER App_SRC EXCLUDE REGEX "${DKPROJECT}/assets/*" )
list(FILTER App_SRC EXCLUDE REGEX "${DKPROJECT}/${OS}/*" )
	
add_definitions(-DDKAPP)
include_directories(${DKPROJECT})

##########
if(WIN_32)
	## OS SOURCE FILES ##
	DKCOPY(${DKPLUGINS}/_DKIMPORT/resource.h ${DKPROJECT}/resource.h FALSE)
	DKCOPY(${DKPLUGINS}/_DKIMPORT/resource.rc ${DKPROJECT}/resource.rc FALSE)
	file(GLOB_RECURSE resources_SRC 
	${DKPROJECT}/*.manifest
	${DKPROJECT}/*.rc
	${DKPROJECT}/icons/windows/*.rc)
	list(APPEND App_SRC ${resources_SRC})
	
	## ICONS ##
	if(IMAGEMAGICK_CONVERT)
		message(STATUS "Building icons for ${APP_NAME} . . .")
		dk_makeDirectory(${DKPROJECT}/icons/windows)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=256,128,64,48,32,16 ${DKPROJECT}/icons/windows/icon.ico)
		DKCOPY(${DKPROJECT}/icons/windows/icon.ico ${DKPROJECT}/assets/icon.ico TRUE) # copy the icon to assets
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=16 ${DKPROJECT}/assets/favicon.ico)
	endif()
	
	## ASSETS ##
	# Backup files and folders excluded from the package
	DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
	DKCOPY(${DKPROJECT}/assets/cef.log ${DKPROJECT}/Backup/cef.log TRUE)
	DKCOPY(${DKPROJECT}/assets/log.txt ${DKPROJECT}/Backup/log.txt TRUE)
	# Remove excluded files and folders before packaging
	DKREMOVE(${DKPROJECT}/assets/USER)
	DKREMOVE(${DKPROJECT}/assets/cef.log)
	DKREMOVE(${DKPROJECT}/assets/log.txt)
	#Compress the assets, they will be included by resource.rc
	message(STATUS "Creating assets.zip . . .")
	DKZIP(${DKPROJECT}/assets)
	# Restore the backed up files, excluded from assets
	DKCOPY(${DKPROJECT}/Backup ${DKPROJECT}/assets TRUE)
	DKREMOVE(${DKPROJECT}/Backup)
	DKCOPY(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h TRUE) #required
	
	add_definitions(-D_USING_V110_SDK71_)
	add_executable(${APP_NAME} WIN32 ${App_SRC})
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	foreach(plugin ${dkdepend_list})
		#if(EXISTS "${3rdParty}/${plugin}/CMakeLists.txt")
		#	add_dependencies(${APP_NAME} ${plugin})
		#endif()
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()

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
	
	set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
	
	add_custom_command(
		TARGET ${APP_NAME}
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	)
	
	#add_custom_command(
    #TARGET ${APP_NAME}
    #POST_BUILD
    #COMMAND "mt.exe" -nologo
    #        -manifest \"${DKPROJECT}/compatibility.manifest\"
    #        -outputresource:"${DKPROJECT}/win32/Debug/${APP_NAME}.exe"\;\#1
    #COMMENT "Adding manifest..."
    #)
	
endif(WIN_32)
	
##########
if(WIN_64)
	## OS SOURCE FILES ##
	DKCOPY(${DKPLUGINS}/_DKIMPORT/resource.h ${DKPROJECT}/resource.h FALSE)
	DKCOPY(${DKPLUGINS}/_DKIMPORT/resource.rc ${DKPROJECT}/resource.rc FALSE)
	file(GLOB_RECURSE resources_SRC 
	${DKPROJECT}/*.manifest
	${DKPROJECT}/*.rc
	${DKPROJECT}/icons/windows/*.rc)
	list(APPEND App_SRC ${resources_SRC})
	
	## ICONS ##
	if(IMAGEMAGICK_CONVERT)
		message(STATUS "Building icons for ${APP_NAME} . . .")
		dk_makeDirectory(${DKPROJECT}/icons/windows)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=256,128,64,48,32,16 ${DKPROJECT}/icons/windows/icon.ico)
		DKCOPY(${DKPROJECT}/icons/windows/icon.ico ${DKPROJECT}/assets/icon.ico TRUE)
		DKEXECUTE_PROCESS(COMMAND ${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=16 ${DKPROJECT}/assets/favicon.ico)
	endif()
	
	## ASSETS ##
	# Backup files and folders excluded from the package
	DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
	DKCOPY(${DKPROJECT}/assets/cef.log ${DKPROJECT}/Backup/cef.log TRUE)
	DKCOPY(${DKPROJECT}/assets/log.txt ${DKPROJECT}/Backup/log.txt TRUE)
	# Remove excluded files and folders before packaging
	DKREMOVE(${DKPROJECT}/assets/USER)
	DKREMOVE(${DKPROJECT}/assets/cef.log)
	DKREMOVE(${DKPROJECT}/assets/log.txt)
	#Compress the assets, they will be included by resource.rc
	message(STATUS "Creating assets.zip . . .")
	DKZIP(${DKPROJECT}/assets)
	# Restore the backed up files
	DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ TRUE)
	DKREMOVE(${DKPROJECT}/Backup)
	#dummy assets.h file, or the builder wil complain about assets.h missing
	DKCOPY(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h TRUE)
		
	add_definitions(-D_USING_V110_SDK71_)
	add_executable(${APP_NAME} WIN32 ${App_SRC})
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
	
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
endif(WIN_64)

#######
if(MAC)
	## ICONS ##
	dk_makeDirectory(${DKPROJECT}/icons/mac)
	dk_makeDirectory(${DKPROJECT}/icons/mac/icons.iconset)
    DKEXECUTE_PROCESS(sips -z 16 16 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_16x16.png WORKING_DIRECTORY ${DIGITALKNOB})
	DKEXECUTE_PROCESS(sips -z 32 32 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_16x16@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
	DKEXECUTE_PROCESS(sips -z 32 32 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_32x32.png WORKING_DIRECTORY ${DIGITALKNOB})
	DKEXECUTE_PROCESS(sips -z 64 64 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_32x32@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
	DKEXECUTE_PROCESS(sips -z 128 128 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_128x128.png WORKING_DIRECTORY ${DIGITALKNOB})
	DKEXECUTE_PROCESS(sips -z 256 256 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_128x128@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
	DKEXECUTE_PROCESS(sips -z 256 256 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_256x256.png WORKING_DIRECTORY ${DIGITALKNOB})
	DKEXECUTE_PROCESS(sips -z 512 512 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_256x256@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
	DKEXECUTE_PROCESS(sips -z 512 512 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_512x512.png WORKING_DIRECTORY ${DIGITALKNOB})
	DKEXECUTE_PROCESS(sips -z 1024 1024 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_512x512@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
	DKEXECUTE_PROCESS(iconutil -c icns -o ${DKPROJECT}/icons/mac/logo.icns ${DKPROJECT}/icons/mac/icons.iconset WORKING_DIRECTORY ${DIGITALKNOB})

	## ASSETS ##
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
	## copy the assets into the bundle resources
	if(DEBUG)
		dk_makeDirectory(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/Contents/Resources)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/Contents/Resources TRUE)
		DKCOPY(${DKPROJECT}/icons/mac/logo.icns ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/Contents/Resources/logo.icns TRUE)
	endif()
	if(RELEASE)
		dk_makeDirectory(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/Contents/Resources)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/Contents/Resources TRUE)
		DKCOPY(${DKPROJECT}/icons/mac/logo.icns ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/Contents/Resources/logo.icns TRUE)
	endif()
	# Restore the backed up files, excluded from assets
	DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
	DKREMOVE(${DKPROJECT}/Backup)

	
	SET(CMAKE_OSX_ARCHITECTURES "x86_64")
	add_executable(${APP_NAME} MACOSX_BUNDLE ${App_SRC})
	set_target_properties(${APP_NAME} PROPERTIES
        XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ""
        #OUTPUT_NAME "wrapper"
        MACOSX_BUNDLE TRUE
		MACOSX_BUNDLE_EXECUTABLE_NAME "wrapper"
        MACOSX_BUNDLE_BUNDLE_NAME "${APP_NAME}"
		MACOSX_BUNDLE_ICON_FILE "logo"
        #MACOSX_BUNDLE_INFO_PLIST path/to/Info.plist
        MACOSX_BUNDLE_BUNDLE_VERSION "1.0"
        MACOSX_BUNDLE_LONG_VERSION_STRING "${APP_NAME} v1.0"
        MACOSX_BUNDLE_SHORT_VERSION_STRING "1.0"
        MACOSX_BUNDLE_GUI_IDENTIFIER com.digitalknob.${APP_NAME}
        MACOSX_BUNDLE_COPYRIGHT "(C) 2021 DigitalKnob"
        #MACOSX_RPATH TRUE
        MACOSX_FRAMEWORK_IDENTIFIER "com.digitalknob.bundle.${APP_NAME}"
        #XCODE_ATTRIBUTE_LD_RUNPATH_SEARCH_PATHS "@loader_path/Libraries"
        #RESOURCE "${RESOURCE_FILES}"
        #XCODE_ATTRIBUTE_ENABLE_HARDENED_RUNTIME TRUE
        #XCODE_ATTRIBUTE_EXECUTABLE_NAME "wrapper"
		MACOSX_BUNDLE_INFO_PLIST ${DKCMAKE}/Info.plist
    )
	#set_xcode_property(${APP_NAME} "Other Code Signing Flags" "--deep")
	
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()
	endforeach()
	
	# Copy the CEF framework into the app bundle
	if(EXISTS ${CEF})
		message(STATUS "Adding Chromium Embedded Framework.framework to bundle . . .")
		add_custom_command(
			TARGET ${APP_NAME}
			POST_BUILD
			COMMAND ${CMAKE_COMMAND} -E copy_directory
					"${CEF}/$<CONFIG>/Chromium Embedded Framework.framework"
					"$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/Chromium Embedded Framework.framework"
		)
	endif()
	
	# Copy the DKCefChild into the app bundle
	#if(EXISTS "${DKPLUGINS}/DKCefChild/${OS}/$<CONFIG>/DKCefChild.app")
	#	message(STATUS "Adding Chromium Embedded Framework.framework to bundle . . .")
	#	add_custom_command(
	#		TARGET ${APP_NAME}
	#		POST_BUILD
	#		COMMAND ${CMAKE_COMMAND} -E copy
	#				"${DKPLUGINS}/DKCefChild/${OS}/$<CONFIG>/DKCefChild.app"
	#				"$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/${APP_NAME} Helper.app"
	#	)
	#endif()
	
	# Make bundle run in Terminal
	# https://github.com/pyinstaller/pyinstaller/issues/5154#issuecomment-690646012
	if(true)
		message(STATUS "Making bundle app run in terminal on double-click . . .")
		DKSET(TERMINAL_SCRIPT 
			"\#!/bin/bash\n"
			"dir=$(cd \"$( dirname \"\${0}\")\" && pwd )\n"
			"Open -a \"Terminal\" \"\${dir}/${APP_NAME}\"" #${APP_NAME}_bin
		)
		file(WRITE ${DKPROJECT}/${OS}/wrapper ${TERMINAL_SCRIPT}) #${APP_NAME}
		DKEXECUTE_PROCESS(chmod +x ${DKPROJECT}/${OS}/wrapper WORKING_DIRECTORY ${DIGITALKNOB})
		add_custom_command(
			TARGET ${APP_NAME}
			POST_BUILD
			#COMMAND ${CMAKE_COMMAND} -E copy
			#		"$<TARGET_FILE:${APP_NAME}>"
			#		"$<TARGET_FILE_DIR:${APP_NAME}>/${APP_NAME}_bin"
			COMMAND ${CMAKE_COMMAND} -E copy
					"${DKPROJECT}/${OS}/wrapper"
					"$<TARGET_FILE_DIR:${APP_NAME}>/wrapper"
		)
	endif()
endif()

#######
if(IOS)
    ## ASSETS ##
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
	if(DEBUG)
		dk_makeDirectory(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/assets)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/assets TRUE)
		DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app TRUE)
	endif()
	if(RELEASE)
		dk_makeDirectory(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/assets)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/assets TRUE)
		DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app TRUE)
	endif()
	# Restore the backed up files, excluded from assets
	DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
	DKREMOVE(${DKPROJECT}/Backup)

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
	set(MACOSX_BUNDLE_GUI_IDENTIFIER "com.digitalknob.${APP_NAME}")
		
	#GET_TARGET_PROPERTY(MyExecutable_PATH ${APP_NAME} LOCATION)
	add_executable(${APP_NAME} MACOSX_BUNDLE ${App_SRC})
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
endif()

##########
if(IOSSIM)
	## ASSETS ##
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
	if(DEBUG)
		dk_makeDirectory(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/assets)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/assets TRUE)
		DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app TRUE)
	endif()
	if(RELEASE)
		dk_makeDirectory(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/assets)
		DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/assets TRUE)
		DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app TRUE)
	endif()
	# Restore the backed up files, excluded from assets
	DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
	DKREMOVE(${DKPROJECT}/Backup)
	
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
	set(MACOSX_BUNDLE_GUI_IDENTIFIER "com.digitalknob.${APP_NAME}")
	
	#GET_TARGET_PROPERTY(MyExecutable_PATH ${APP_NAME} LOCATION)
	add_executable(${APP_NAME} MACOSX_BUNDLE ${App_SRC})
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
endif()

#########
if(LINUX)
	## ICONS ##
	DKCOPY(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)

	## ASSETS ##
	if(false)
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

	#LINUX_LIB(pthread)
	#LINUX_LIB(dl)
	#LINUX_LIB(libstdc++fs.a)
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
	
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
	
	# Create .desktop file for Debug
	DKSET(DESKTOP_FILE
		"[Desktop Entry]\n"
		"Encoding=UTF-8\n"
		"Version=1.0\n"
		"Type=Application\n"
		"Terminal=true\n"
		"Name=${APP_NAME}\n"
		"Exec=${DKPROJECT}/${OS}/Debug/${APP_NAME}\n"
		"Icon=${DKPROJECT}/icons/icon.png\n")
	file(WRITE ${DKPROJECT}/${OS}/Debug/${APP_NAME}.desktop ${DESKTOP_FILE})
	
	# Create .desktop file for Release
	DKSET(DESKTOP_FILE
		"[Desktop Entry]\n"
		"Encoding=UTF-8\n"
		"Version=1.0\n"
		"Type=Application\n"
		"Terminal=true\n"
		"Name=${APP_NAME}\n"
		"Exec=${DKPROJECT}/${OS}/Release/${APP_NAME}\n"
		"Icon=${DKPROJECT}/icons/icon.png\n")
	file(WRITE ${DKPROJECT}/${OS}/Release/${APP_NAME}.desktop ${DESKTOP_FILE})
	
	# Install shortcut of Release build to the apps menu
	DKEXECUTE_PROCESS(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DKPROJECT}/${OS}/Release/${APP_NAME}.desktop WORKING_DIRECTORY ${DKPROJECT}/${OS}/Release)
endif()

#############
if(RASPBERRY)
	## ICONS ##
	DKCOPY(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)

	## ASSETS ##
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

    #RASPBERRY_LIB(pthread)
	#RASPBERRY_LIB(dl)
	#RASPBERRY_LIB(libstdc++fs.a)
	#link_directories(/opt/vc/lib)
	#RASPBERRY_LIB(bcm_host)
	#set(CMAKE_CXX_FLAGS "-g -no-pie -std=c++17")
	
	if(DEBUG)
		add_definitions(-DDEBUG)
		add_executable(${APP_NAME} ${App_SRC})
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${LIBS})
	endif()
	if(RELEASE)
		add_executable(${APP_NAME} ${App_SRC})
		target_link_libraries(${APP_NAME} ${RELEASE_LIBS} ${LIBS})
	endif()

	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
	
	# Create .desktop file for Debug
	DKSET(DESKTOP_FILE
		"[Desktop Entry]\n"
		"Encoding=UTF-8\n"
		"Version=1.0\n"
		"Type=Application\n"
		"Terminal=true\n"
		"Name=${APP_NAME}\n"
		"Exec=${DKPROJECT}/${OS}/Debug/${APP_NAME}\n"
		"Icon=${DKPROJECT}/icons/icon.png\n")
	file(WRITE ${DKPROJECT}/${OS}/Debug/${APP_NAME}.desktop ${DESKTOP_FILE})
	
	# Create .desktop file for Release
	DKSET(DESKTOP_FILE
		"[Desktop Entry]\n"
		"Encoding=UTF-8\n"
		"Version=1.0\n"
		"Type=Application\n"
		"Terminal=true\n"
		"Name=${APP_NAME}\n"
		"Exec=${DKPROJECT}/${OS}/Release/${APP_NAME}\n"
		"Icon=${DKPROJECT}/icons/icon.png\n")
	file(WRITE ${DKPROJECT}/${OS}/Release/${APP_NAME}.desktop ${DESKTOP_FILE})
	
	# Install shortcut of Release build to the apps menu
	DKEXECUTE_PROCESS(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DKPROJECT}/${OS}/Release/${APP_NAME}.desktop WORKING_DIRECTORY ${DKPROJECT}/${OS}/Release)
endif()

###########
if(ANDROID)
	## OS SOURCE FILES ##
	DKCOPY(${DKPLUGINS}/_DKIMPORT/Android.h ${DKPROJECT}/Android.h FALSE) ## copy app default files recursivly without overwrite
	if(ANDROID_32)
		DKCOPY(${DKPLUGINS}/_DKIMPORT/android32 ${DKPROJECT}/android32 FALSE) ## copy app default files recursivly without overwrite
	endif()
	if(ANDROID_64)
		DKCOPY(${DKPLUGINS}/_DKIMPORT/android64 ${DKPROJECT}/android64 FALSE) ## copy app default files recursivly without overwrite
	endif()
	
	## ICONS ##
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
	
	#DKSET(CMAKE_CXX_FLAGS "-DDKAPP -DUSE_DK -frtti -fexceptions -std=c++1z -lstdc++fs")
	#DKSET(CMAKE_CXX_FLAGS "-frtti -fexceptions -std=c++1z")
	#DKSET(CMAKE_CXX_FLAGS_DEBUG "-DDEBUG -D_DEBUG -g2 -gdwarf-2 -O0")
	#DKSET(CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG -03")
	#set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)
	
	set(CMAKE_ANDROID_GUI 1)
	#set(CMAKE_SYSTEM_NAME Android) 
	#set(CMAKE_SYSTEM_VERSION 26)
	#set(CMAKE_ANDROID_ARCH_ABI armeabi-v7a)
	#set(CMAKE_ANDROID_NDK ${ANDROIDNDK})
	#set(CMAKE_ANDROID_STL_TYPE c++_static)
	
	#add_executable(DKAndroid ${App_SRC})
	add_library(${APP_NAME} SHARED ${App_SRC})
	
	#target_include_directories(${APP_NAME} PUBLIC ${INCLUDE_DIRECTORIES}) #of ${DKINCLUDES_LIST}
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	#add_dependencies(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS})	
	#include_external_msproject(DKGradle ${DKPROJECT}/${OS}/DKGradle.androidproj)
	
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()	
endif()



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
	
message(STATUS "\n")
message(STATUS "**************************************************")
message(STATUS "****** Generated ${APP_NAME} - ${OS}  ************")
message(STATUS "**************************************************\n")

# https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609
