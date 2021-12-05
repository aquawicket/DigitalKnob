if(DKPROCESS_INCLUDED)
  return()
endif(DKPROCESS_INCLUDED)
set(DKPROCESS_INCLUDED true)


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

DKREMOVE(${DKPROJECT}/DKBUILD.log)
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
	DKSET(LIBLIST "") 
	## used for double checking
	#DKSET(CMAKE_FILE "")
	
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
	#message(STATUS "plugin_path = ${plugin_path}")

	#This executes the 3rdParty library builds, and dkplugin setup, creates CMakeLists.txt files
	include(${plugin_path}/DKMAKE.cmake)
	
	#NOTE: we won't have the library paths to remove until we've run DKCMake.cmake for the library
	# We want to to use this to refresh 3rdParty Plugins
	#if(REBUILDALL)
		#foreach(the_lib ${LIBLIST})
		#	DKREMOVE(${the_lib})
		#	message(STATUS "######  Removed ${the_lib}")
		#endforeach()
	#endif()
	
	# ADD THE 3rdParty library TO THE APP SOLUTION
	#string(TOUPPER ${plugin} PLUGIN_NAME)
	#if(EXISTS "${${PLUGIN_NAME}}/CMakeLists.txt")
	#	add_subdirectory(${${PLUGIN_NAME}} ${${PLUGIN_NAME}}/${OS})
	#	message(STATUS "add_subdirectory( ${${PLUGIN_NAME}} ${${PLUGIN_NAME}}/${OS} )")
	#endif()

	string(FIND "${DKPLUGIN_LIST}" "${plugin}" isDKPlugin) #isDKPlugin flag
	####################### DKPlugins #######################
	if(${isDKPlugin} GREATER -1)
		#Add the DKPlugin to the app project
		if(EXISTS "${plugin_path}/CMakeLists.txt")
			if(LINUX OR RASPBERRY)
				if(DEBUG)
					add_subdirectory(${plugin_path} ${plugin_path}/${OS}/Debug)
				elseif(RELEASE)
					add_subdirectory(${plugin_path} ${plugin_path}/${OS}/Release)
				endif()
			else()
				add_subdirectory(${plugin_path} ${plugin_path}/${OS})
			endif()
		endif()
		
		## Prebuild Plugins switch
		if(FALSE)
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
					IOS32_COMMAND(xcodebuild -configuration Debug build) #-sdk iphoneos13.0)
				endif()
				if(RELEASE)
					IOS32_COMMAND(xcodebuild -configuration Release build)
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
					IOSSIM32_COMMAND(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					IOSSIM32_COMMAND(xcodebuild -configuration Release build)
				endif()
			endif()
			if(IOSSIM_64)
				IOSSIM64_COMMAND(${DKCMAKE_IOSSIM64} -DIOSSIM_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					IOSSIM64_COMMAND(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					IOSSIM64_COMMAND(xcodebuild -configuration Release build)
				endif()
			endif()
			if(LINUX_32)
				if(DEBUG)
					DKSET(CURRENT_DIR ${plugin_path}/${OS}/${DEBUG_DIR})
					dk_makeDirectory(${CURRENT_DIR})
					LINUX32_COMMAND(${DKCMAKE_LINUX_DEBUG} -DLINUX_32=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
					LINUX32_COMMAND(make)
				elseif(RELEASE)
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
				elseif(RELEASE)
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
				elseif(RELEASE)
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
				elseif(RELEASE)
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
		
			## double check that the missing libs were built
			foreach(the_lib ${LIBLIST})
				if(NOT EXISTS ${the_lib})
					message(FATAL_ERROR "\n\n\n****************************\nFAILED to find: ${the_lib} \n***********************************")
					message(FATAL_ERROR " ")
				endif()
			endforeach()
		endif()
		
	endif()
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
#file(GLOB_RECURSE App_SRC
file(GLOB App_SRC
	${DKPROJECT}/*.h
	${DKPROJECT}/*.c
	${DKPROJECT}/*.cpp)
list(FILTER App_SRC EXCLUDE REGEX "${DKPROJECT}/assets/*")
list(FILTER App_SRC EXCLUDE REGEX "${DKPROJECT}/${OS}/*")
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
include_directories(${DKPROJECT})
include_directories(${DKPLUGINS})

##########
if(WIN_32)
	### PRE BUILD ###
	if(DEBUG)
		DKREMOVE(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup)
	endif()
	if(RELEASE)
		DKREMOVE(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup)
	endif()
	
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
	# Remove excluded files and folders before packaging
	DKREMOVE(${DKPROJECT}/assets/USER)
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
	
	target_compile_options(${APP_NAME} PRIVATE
		$<$<OR:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>,$<CXX_COMPILER_ID:GNU>>: -Wall -Werror>
		$<$<CXX_COMPILER_ID:MSVC>: /W4 /WX>)
	
	## TODO: can we use include_external_msproject() to include all of our third party libraries created with CMake?
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
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${APP_NAME})
	
	### POST BUILD ###
	#CPP_DKFile_Copy(app_path+OS+"/Release/"+APP+".pdb", app_path+"assets/"+APP+".pdb", true)
	#CPP_DK_Execute(DIGITALKNOB+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/Release/"+APP+".exe")
		
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${APP_NAME}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	
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
	### PRE BUILD ###
	if(DEBUG)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup)
	endif()
	if(RELEASE)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup)
	endif()
	
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
	# Remove excluded files and folders before packaging
	DKREMOVE(${DKPROJECT}/assets/USER)
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
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${APP_NAME})
	
	### POST BUILD ###
	#CPP_DKFile_Copy(app_path+OS+"/Release/"+APP+".pdb", app_path+"assets/"+APP+".pdb", true)
	#CPP_DK_Execute(DIGITALKNOB+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/Release/"+APP+".exe")
endif(WIN_64)

#######
if(MAC)
	### PRE BUILD ###
	if(DEBUG)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup)
	endif()
	if(RELEASE)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup)
	endif()
	
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
	# Remove excluded files and folders before packaging
	DKREMOVE(${DKPROJECT}/assets/USER)
	
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
        MACOSX_BUNDLE TRUE
		MACOSX_BUNDLE_EXECUTABLE_NAME "wrapper"
		#MACOSX_BUNDLE_EXECUTABLE_NAME "${APP_NAME}"
        MACOSX_BUNDLE_BUNDLE_NAME "${APP_NAME}"
		MACOSX_BUNDLE_ICON_FILE "logo"
        MACOSX_BUNDLE_BUNDLE_VERSION "1.0"
        MACOSX_BUNDLE_LONG_VERSION_STRING "${APP_NAME} v1.0"
        MACOSX_BUNDLE_SHORT_VERSION_STRING "1.0"
        MACOSX_BUNDLE_GUI_IDENTIFIER com.digitalknob.${APP_NAME}
        MACOSX_BUNDLE_COPYRIGHT "(C) 2021 DigitalKnob"
		MACOSX_FRAMEWORK_IDENTIFIER "com.digitalknob.bundle.${APP_NAME}"
		MACOSX_BUNDLE_INFO_PLIST ${DKCMAKE}/Info.plist
		#MACOSX_RPATH TRUE
        #XCODE_ATTRIBUTE_LD_RUNPATH_SEARCH_PATHS "@loader_path/Libraries"
        #RESOURCE "${RESOURCE_FILES}"
        #XCODE_ATTRIBUTE_ENABLE_HARDENED_RUNTIME TRUE
    )
	#set_xcode_property(${APP_NAME} "Other Code Signing Flags" "--deep")	
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY XCODE_STARTUP_PROJECT ${APP_NAME})
	
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			if(NOT ${plugin} MATCHES "DKCefChild")
				add_dependencies(${APP_NAME} ${plugin})
			endif()
		endif()
	endforeach()
	
	### POST BUILD ###
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
	if(EXISTS "${DKPLUGINS}/DKCefChild/${OS}/Release/DKCefChild.app")
		message(STATUS "Adding Chromium Embedded Framework.framework to bundle . . .")
		add_custom_command(
			TARGET ${APP_NAME}
			POST_BUILD
			COMMAND ${CMAKE_COMMAND} -E copy
				"${DKPLUGINS}/DKCefChild/${OS}/$<CONFIG>/DKCefChild.app"
				"$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/${APP_NAME} Helper.app"
		)
	endif()
	
	# Make bundle run in Terminal
	# https://github.com/pyinstaller/pyinstaller/issues/5154#issuecomment-690646012
	if(true)
		message(STATUS "Making bundle app run in terminal on double-click . . .")
		set(TERMINAL_SCRIPT 
			"\#!/bin/bash\n"
			"dir=$(cd \"$( dirname \"\${0}\")\" && pwd )\n"
			"Open -a \"Terminal\" \"\${dir}/${APP_NAME}\"" #${APP_NAME}_bin
		)
		file(WRITE ${DKPROJECT}/${OS}/wrapper ${TERMINAL_SCRIPT}) #${APP_NAME}
		DKEXECUTE_PROCESS(chmod +x ${DKPROJECT}/${OS}/wrapper WORKING_DIRECTORY ${DIGITALKNOB})
		add_custom_command(
			TARGET ${APP_NAME}
			POST_BUILD
			COMMAND ${CMAKE_COMMAND} -E copy
					"${DKPROJECT}/${OS}/wrapper"
					"$<TARGET_FILE_DIR:${APP_NAME}>/wrapper"
		)
	endif()
	
	#CPP_DK_Execute("chmod +x "+app_path+OS+"/Debug/"+APP)
#			if(CPP_DKFile_Exists(app_path+"assets/DKCef/mac64Debug/Chromium Embedded Framework.framework")){
#				CPP_DKFile_MkDir(app_path+"mac64/Debug/"+APP+".app/Contents/Frameworks")
#				CPP_DKFile_Copy(app_path+"assets/DKCef/mac64Debug/Chromium Embedded Framework.framework", app_path+"mac64/Debug/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework", true)
#				if(CPP_DKFile_Exists(DIGITALKNOB+"DK/DKPlugins/DKCefChild/mac64/Debug/DKCefChild.app")){
#					CPP_DKFile_Copy(DIGITALKNOB+"DK/DKPlugins/DKCefChild/mac64/Debug/DKCefChild.app", app_path+"mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app", true)
#					CPP_DKFile_Rename(app_path+"mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/DKCefChild", app_path+"mac64/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper", true)
#				}
#			}
#			//update the info.plist to include the logo icon
#			if(CPP_DKFile_Exists(app_path+OS+"/Debug/"+APP+".app/Contents/info.plist")){
#				let info_plist = CPP_DKFile_FileToString(app_path+OS+"/Debug/"+APP+".app/Contents/info.plist")
#				info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>")
#				CPP_DKFile_StringToFile(info_plist, app_path+OS+"/Debug/"+APP+".app/Contents/info.plist")
#			}
#			//update install_name_tool if cef present
#			if(CPP_DKFile_Exists(app_path+OS+"/Debug/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework")){
#				console.log("USING CHROMIUM EMBEDDED FRAMEWORK")
#				let command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+app_path+OS+"/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\""
#				console.log(command)
#				CPP_DK_Execute(command)
#				command = "install_name_tool -add_rpath \"@executable_path/../../../../\" \""+app_path+OS+"/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\""
#				console.log(command)
#				CPP_DK_Execute(command)
#				command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+app_path+OS+"/Debug/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+"\""
#				console.log(command)
#				CPP_DK_Execute(command)
#				command = "install_name_tool -add_rpath \"@executable_path/../\" \""+app_path+OS+"/Debug/"+APP+".app/Contents/MacOS/"+APP+"\""
#				console.log(command)
#				CPP_DK_Execute(command)
#			}
#			*/
endif()

#######
if(IOS AND NOT IOSSIM)
	### PRE BUILD ###
	if(DEBUG)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup)
	endif()
	if(RELEASE)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup)
	endif()
	
    ## ASSETS ##
	# Backup files and folders excluded from the package
	DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
	# Remove excluded files and folders before packaging
	DKREMOVE(${DKPROJECT}/assets/USER)
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

	#GET_TARGET_PROPERTY(MyExecutable_PATH ${APP_NAME} LOCATION)
	list(APPEND App_SRC ${DKPLUGINS}/DK/DKiPhone.mm)
	add_executable(${APP_NAME} MACOSX_BUNDLE ${App_SRC})
    set_target_properties(${APP_NAME} PROPERTIES
        XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ""
        MACOSX_BUNDLE TRUE
		MACOSX_BUNDLE_EXECUTABLE_NAME "${APP_NAME}"
        MACOSX_BUNDLE_BUNDLE_NAME "${APP_NAME}"
		MACOSX_BUNDLE_ICON_FILE "logo"
        MACOSX_BUNDLE_BUNDLE_VERSION "1.0"
        MACOSX_BUNDLE_LONG_VERSION_STRING "${APP_NAME} v1.0"
        MACOSX_BUNDLE_SHORT_VERSION_STRING "1.0"
        MACOSX_BUNDLE_GUI_IDENTIFIER com.digitalknob.${APP_NAME}
        MACOSX_BUNDLE_COPYRIGHT "(C) 2021 DigitalKnob"
		MACOSX_FRAMEWORK_IDENTIFIER "com.digitalknob.bundle.${APP_NAME}"
		MACOSX_BUNDLE_INFO_PLIST ${DKCMAKE}/Info.plist
		#MACOSX_RPATH TRUE
        #XCODE_ATTRIBUTE_LD_RUNPATH_SEARCH_PATHS "@loader_path/Libraries"
        #RESOURCE "${RESOURCE_FILES}"
        #XCODE_ATTRIBUTE_ENABLE_HARDENED_RUNTIME TRUE
    )
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
	
	### POST BUILD ###
	#CPP_DK_Execute("chmod +x "+app_path+OS+"/Debug/"+APP)
endif()

##########
if(IOSSIM)
	### PRE BUILD ###
	if(DEBUG)
		DKREMOVE(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup)
	endif()
	if(RELEASE)
		DKREMOVE(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup)
	endif()
	
	## ASSETS ##
	# Backup files and folders excluded from the package
	DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
	# Remove excluded files and folders before packaging
	DKREMOVE(${DKPROJECT}/assets/USER)
	
	## copy the assets into the app
	#if(DEBUG)
	#	dk_makeDirectory(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/assets)
	#	DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app/assets TRUE)
	#	DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app TRUE)
	#endif()
	#if(RELEASE)
	#	dk_makeDirectory(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/assets)
	#	DKCOPY(${DKPROJECT}/assets/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app/assets TRUE)
	#	DKCOPY(${DKPROJECT}/icons/ios/ ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app TRUE)
	#endif()
	
	# Restore the backed up files, excluded from assets
	DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
	DKREMOVE(${DKPROJECT}/Backup)
	
	#GET_TARGET_PROPERTY(MyExecutable_PATH ${APP_NAME} LOCATION)
	list(APPEND App_SRC ${DKPLUGINS}/DK/DKiPhone.mm)
	add_executable(${APP_NAME} MACOSX_BUNDLE ${App_SRC})
	set_target_properties(${APP_NAME} PROPERTIES
        XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ""
        MACOSX_BUNDLE TRUE
		MACOSX_BUNDLE_EXECUTABLE_NAME "${APP_NAME}"
        MACOSX_BUNDLE_BUNDLE_NAME "${APP_NAME}"
		MACOSX_BUNDLE_ICON_FILE "logo"
        MACOSX_BUNDLE_BUNDLE_VERSION "1.0"
        MACOSX_BUNDLE_LONG_VERSION_STRING "${APP_NAME} v1.0"
        MACOSX_BUNDLE_SHORT_VERSION_STRING "1.0"
        MACOSX_BUNDLE_GUI_IDENTIFIER com.digitalknob.${APP_NAME}
        MACOSX_BUNDLE_COPYRIGHT "(C) 2021 DigitalKnob"
		MACOSX_FRAMEWORK_IDENTIFIER "com.digitalknob.bundle.${APP_NAME}"
		#MACOSX_BUNDLE_INFO_PLIST ${DKCMAKE}/Info.plist
		#MACOSX_RPATH TRUE
        #XCODE_ATTRIBUTE_LD_RUNPATH_SEARCH_PATHS "@loader_path/Libraries"
        #RESOURCE "${RESOURCE_FILES}"
        #XCODE_ATTRIBUTE_ENABLE_HARDENED_RUNTIME TRUE
    )
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
	
	### POST BUILD ###
	#CPP_DK_Execute("chmod +x "+app_path+OS+"/Debug/"+APP)
endif()

#########
if(LINUX)
	### PRE BUILD ###
	if(DEBUG)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup)
	elseif(RELEASE)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup)
	endif()
	
	## ICONS ##
	DKCOPY(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)

	## ASSETS ##
	if(false)
		# backup files not going in the package
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		DKREMOVE(${DKPROJECT}/assets/USER)
		# Remove excluded files and folders before packaging
		message(STATUS "Creating assets.zip . . .")
		DKZIP(${DKPROJECT}/assets)
		#message(STATUS "Creating assets.h . . .")
		bin2h(SOURCE_FILE ${DKPROJECT}/assets.zip HEADER_FILE ${DKPROJECT}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
		DKREMOVE(${DKPROJECT}/Backup)
	endif()
	
	if(DEBUG)
		add_definitions(-DDEBUG)
		add_executable(${APP_NAME} ${App_SRC})
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${LIBS})
		#set_target_properties(${APP_NAME} PROPERTIES DEBUG_POSTFIX d)
	elseif(RELEASE)
		add_executable(${APP_NAME} ${App_SRC})
		target_link_libraries(${APP_NAME} ${RELEASE_LIBS} ${LIBS})
	endif()
	
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
	
	if(DEBUG)
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
	elseif(RELEASE)
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
	
	### POST BUILD ###
	#CPP_DK_Execute("chmod +x "+app_path+OS+"/Debug/"+APP)
endif()

#############
if(RASPBERRY)
	### PRE BUILD ###
	if(DEBUG)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup)
	elseif(RELEASE)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup)
	endif()
	
	## ICONS ##
	DKCOPY(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)

	## ASSETS ##
	if(false)
		# backup files not going in the package
		DKCOPY(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		# Remove excluded files and folders before packaging
		DKREMOVE(${DKPROJECT}/assets/USER)
		message(STATUS "Creating assets.zip . . .")
		DKZIP(${DKPROJECT}/assets)
		#message(STATUS "Creating assets.h . . .")
		bin2h(SOURCE_FILE ${DKPROJECT}/assets.zip HEADER_FILE ${DKPROJECT}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		DKCOPY(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
		DKREMOVE(${DKPROJECT}/Backup)
	endif()
	
	if(DEBUG)
		add_definitions(-DDEBUG)
		add_executable(${APP_NAME} ${App_SRC})
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${LIBS})
	elseif(RELEASE)
		add_executable(${APP_NAME} ${App_SRC})
		target_link_libraries(${APP_NAME} ${RELEASE_LIBS} ${LIBS})
	endif()

	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
	
	if(DEBUG)
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
	elseif(RELEASE)
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
	endif()
	
	# Install shortcut of Release build to the apps menu
	DKEXECUTE_PROCESS(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DKPROJECT}/${OS}/Release/${APP_NAME}.desktop WORKING_DIRECTORY ${DKPROJECT}/${OS}/Release)
	
	### POST BUILD ###
	#CPP_DK_Execute("chmod +x "+app_path+OS+"/Debug/"+APP)
endif()

###########
if(ANDROID)
	### PRE BUILD ###
	if(DEBUG)
		DKREMOVE(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup)
		DKRENAME(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.apk ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup)
	endif()
	if(RELEASE)
		DKREMOVE(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup)
		DKRENAME(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.apk ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup)
	endif()
	
	## OS SOURCE FILES ##
	DKCOPY(${DKPLUGINS}/_DKIMPORT/Android.h ${DKPROJECT}/Android.h FALSE)
	if(ANDROID_32)
		DKCOPY(${DKPLUGINS}/_DKIMPORT/android32 ${DKPROJECT}/android32 FALSE)
	endif()
	if(ANDROID_64)
		DKCOPY(${DKPLUGINS}/_DKIMPORT/android64 ${DKPROJECT}/android64 FALSE)
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
	#DKSET(CMAKE_CXX_FLAGS "-DDKAPP -DUSE_DK -frtti -fexceptions -std=c++1z")
	#DKSET(CMAKE_CXX_FLAGS_DEBUG "-DDEBUG -D_DEBUG -g2 -gdwarf-2 -O0")
	#DKSET(CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG -03")
	#set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)
	
	set(CMAKE_ANDROID_GUI 1)
	#add_executable(DKAndroid ${App_SRC})
	add_library(${APP_NAME} SHARED ${App_SRC})
	
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	#target_include_directories(${APP_NAME} PUBLIC ${INCLUDE_DIRECTORIES}) #of ${DKINCLUDES_LIST}
	target_include_directories(${APP_NAME} PUBLIC ${SDL2}/include)

	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()

	#include_external_msproject(DKGradle ${DKPROJECT}/${OS}/DKGradle.androidproj)	
	
	### POST BUILD ###
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
DKBUILD_LOG("           RELEASE_FLAGS:  ${RELEASE_FLAGS}")
DKBUILD_LOG("                   FLAGS:  ${FLAGS}")
DKBUILD_LOG("          DKDEFINES_LIST:  ${DKDEFINES_LIST}")
DKBUILD_LOG("         DKINCLUDES_LIST:  ${DKINCLUDES_LIST}")
DKBUILD_LOG("         DKLINKDIRS_LIST:  ${DKLINKDIRS_LIST}")


message(STATUS "\n")
message(STATUS "**************************************************")
message(STATUS "****** Generated ${APP_NAME} - ${OS}  ************")
message(STATUS "**************************************************\n")
