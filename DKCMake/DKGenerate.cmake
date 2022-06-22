# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright noticeand this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
include_guard()

include($ENV{DKCMAKE}DK.cmake)
#include(DKFunctions.cmake)
#include(DKFileSystem.cmake)
#include(DKVariables.cmake)
#include(DKDisabled.cmake)

dk_info("\n")
dk_info("############################################################")
dk_info("######################  DigitalKnob  #######################")
dk_info("############################################################")
dk_info("\n")
get_filename_component(APP_NAME ${DKPROJECT} NAME)
string(REPLACE " " "_" APP_NAME ${APP_NAME})

############################################################################################
############################   ADD EXECUTABLE  #############################################
############################################################################################
if(NOT TARGET)
	PROJECT(${APP_NAME})
	dk_set(DKAPP ON)
endif()

##################################################
##### Scan the DKPlugins and build the lists #####
##################################################
include(${DKCMAKE}/DKBuildFlags.cmake)
include(${DKPROJECT}/DKMAKE.cmake)
file(REMOVE ${DKPROJECT}/${OS}/DKBUILD.log)
dk_printSettings()
#dk_printAllVariables()

dk_buildLog("##############################################")
dk_buildLog("######  Enabled Dependencies (sorted)  #######")
dk_buildLog("##############################################")
list(REMOVE_DUPLICATES dkdepend_list)
foreach(plugin ${dkdepend_list})
	dk_buildLog("${plugin}")
endforeach()
dk_buildLog("\n")

foreach(plugin ${dkdepend_list})
	dk_set(QUEUE_BUILD OFF)
	dk_set(LIBLIST "") # used for double checking
	#dk_set(CMAKE_FILE "")
	
	dk_info("############################################################")
	dk_info("######  Processing   ${plugin} . . .                        ")
	dk_info("############################################################")
	
	##Strip any sublibrary named in the plugin, and enable it
	string(FIND "${plugin}" " " index)
	if(${index} GREATER -1)
		math(EXPR index "${index}+1")
		string(SUBSTRING ${plugin} ${index} -1 arg2)
		math(EXPR index "${index}-1")
		string(SUBSTRING ${plugin} 0 ${index} plugin)
		dk_enable(${arg2})
	endif()
	
	#################### 3rdParty libs #####################
	dk_getPathToPlugin(${plugin} plugin_path)
	if(NOT plugin_path)
		DEBUG_LINE()
		Wait()
		break()
		
	endif()
	#dk_info("plugin_path = ${plugin_path}")

	#This executes the 3rdParty library builds, and dkplugin setup, creates CMakeLists.txt files
	include(${plugin_path}/DKMAKE.cmake)
	
	#NOTE: we won't have the library paths to remove until we've run DKCMake.cmake for the library
	# We want to to use this to refresh 3rdParty Plugins
	#if(REBUILDALL)
		#foreach(lib ${LIBLIST})
		#	file(REMOVE ${lib})
		#	dk_info("######  Removed ${lib}")
		#endforeach()
	#endif()
	
	# ADD THE 3rdParty library TO THE APP SOLUTION
	#string(TOUPPER ${plugin} PLUGIN_NAME)
	#if(EXISTS "${${PLUGIN_NAME}}/CMakeLists.txt")
	#	add_subdirectory(${${PLUGIN_NAME}} ${${PLUGIN_NAME}}/${OS})
	#	dk_info("add_subdirectory( ${${PLUGIN_NAME}} ${${PLUGIN_NAME}}/${OS} )")
	#endif()
	
	#install(TARGETS <target_name> DESTINATION ${DIGITALKNOB}/DKInstall/lib/${OS})
	#install(FILES file.h DESTINATION ${DIGITALKNOB}/DKInstall/lib/${OS})
	
	####################### DKPlugins #######################
	# Libraries in the /DKPlugins folder
	string(TOLOWER "${DKPLUGIN_LIST}" DKPLUGIN_LIST_lower)
	string(TOLOWER "${plugin}" plugin_lower)	
	string(FIND "${DKPLUGIN_LIST_lower}" "${plugin_lower}" isDKPlugin)
	
	# Install 3rd Party Libs
	if(INSTALL_DKLIBS)
		if(${isDKPlugin} EQUAL -1)
			if(EXISTS ${plugin_path}/${BUILD_DIR}/cmake_install.cmake)
				dk_queueCommand(${CMAKE_COMMAND} --install ${plugin_path}/${BUILD_DIR})
			endif()
		endif()
	endif()
	
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
		
		## Prebuild DKPlugins switch
		## Only prebuild if the library binaries are missing
		foreach(lib ${LIBLIST})
			if(NOT EXISTS ${lib})
				dk_set(PREBUILD ON)
				dk_set(QUEUE_BUILD ON)
			endif()
		endforeach()
		
		#dk_set(PREBUILD ON)
		if(PREBUILD)
			dk_info("******* Prebuilding ${plugin} *******")
			#dk_set(CURRENT_DIR ${plugin_path}/${OS})
			#dk_makeDirectory(${CURRENT_DIR})
			dk_setPath(${plugin_path}/${BUILD_DIR})
			if(WIN_32)
				WIN_dk_queueCommand(${DKCMAKE_BUILD} -DWIN_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					WIN32_dk_queueCommand(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
				endif()
				if(RELEASE)
					WIN32_dk_queueCommand(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
				endif()
			endif()
			if(WIN_64)
				WIN_dk_queueCommand(${DKCMAKE_BUILD} -DWIN_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					WIN64_dk_queueCommand(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
				endif()
				if(RELEASE)
					WIN64_dk_queueCommand(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
				endif()
			endif()
			if(MAC_32)
				MAC_dk_queueCommand(${DKCMAKE_BUILD} -DMAC_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					MAC32_dk_queueCommand(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					MAC32_dk_queueCommand(xcodebuild -configuration Release build)
				endif()
			endif()
			if(MAC_64)
				MAC_dk_queueCommand(${DKCMAKE_BUILD} -DMAC_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					MAC_dk_queueCommand(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					MAC_dk_queueCommand(xcodebuild -configuration Release build)
				endif()
			endif()
			if(IOS_32)
				IOS_dk_queueCommand(${DKCMAKE_BUILD} -DIOS_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					IOS_dk_queueCommand(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					IOS_dk_queueCommand(xcodebuild -configuration Release build)
				endif()
			endif()
			if(IOS_64)
				IOS_dk_queueCommand(${DKCMAKE_BUILD} -DIOS_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					IOS_dk_queueCommand(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					IOS_dk_queueCommand(xcodebuild -configuration Release build)
				endif()
			endif()
			if(IOSSIM_32)
				IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} -DIOSSIM_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					IOSSIM_dk_queueCommand(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					IOSSIM_dk_queueCommand(xcodebuild -configuration Release build)
				endif()
			endif()
			if(IOSSIM_64)
				IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} -DIOSSIM_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					IOSSIM_dk_queueCommand(xcodebuild -configuration Debug build)
				endif()
				if(RELEASE)
					IOSSIM_dk_queueCommand(xcodebuild -configuration Release build)
				endif()
			endif()
			if(LINUX_32)
				if(DEBUG)
					LINUX_dk_queueCommand(${DKCMAKE_BUILD} -DLINUX_32=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
					LINUX_dk_queueCommand(make)
				elseif(RELEASE)
					LINUX_dk_queueCommand(${DKCMAKE_BUILD} -DLINUX_32=ON -DREBUILD=ON -DRELEASE=ON ${plugin_path})
					LINUX_dk_queueCommand(make)
				endif()
			endif()
			if(LINUX_64)
				if(DEBUG)
					LINUX_dk_queueCommand(${DKCMAKE_BUILD} -DLINUX_64=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
					LINUX_dk_queueCommand(make)
				elseif(RELEASE)
					LINUX_dk_queueCommand(${DKCMAKE_BUILD} -DLINUX_64=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
					LINUX_dk_queueCommand(make)
				endif()
			endif()
			if(RASPBERRY_32)
				if(DEBUG)
					RASPBERRY_dk_queueCommand(${DKCMAKE_BUILD} -DRASPBERRY_32=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
					RASPBERRY_dk_queueCommand(make)
				elseif(RELEASE)
					RASPBERRY_dk_queueCommand(${DKCMAKE_BUILD} -DRASPBERRY_32=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
					RASPBERRY_dk_queueCommand(make)
				endif()
			endif()
			if(RASPBERRY_64)
				if(DEBUG)
					RASPBERRY_dk_queueCommand(${DKCMAKE_BUILD} -DRASPBERRY_64=ON -DDEBUG=ON -DREBUILD=ON ${plugin_path})
					RASPBERRY_dk_queueCommand(make)
				elseif(RELEASE)
					RASPBERRY_dk_queueCommand(${DKCMAKE_BUILD} -DRASPBERRY_64=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
					RASPBERRY_dk_queueCommand(make)
				endif()
			endif()
			if(ANDROID_32)
				ANDROID_dk_queueCommand(${DKCMAKE_BUILD} -DANDROID_32=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					ANDROID32_dk_queueCommand(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
				endif()
				if(RELEASE)
					ANDROID32_dk_queueCommand(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
				endif()
			endif()
			if(ANDROID_64)
				ANDROID_dk_queueCommand(${DKCMAKE_BUILD} -DANDROID_64=ON -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON ${plugin_path})
				if(DEBUG)
					ANDROID64_dk_queueCommand(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Debug)
				endif()
				if(RELEASE)
					ANDROID64_dk_queueCommand(${MSBUILD} ${CURRENT_DIR}/${plugin}.sln /p:Configuration=Release)
				endif()
			endif()
		
			set(PREBUILD OFF)

			## double check that the missing libs were built
			foreach(lib ${LIBLIST})
				if(NOT EXISTS ${lib})
					dk_warn("\n\n\n****************************\nFAILED to find: ${lib} \n***********************************")
				else()
				
					# Install DKPlugin Libs
					if(INSTALL_DKLIBS)
						if(EXISTS ${plugin_path}/${BUILD_DIR}/cmake_install.cmake)
							dk_queueCommand(${CMAKE_COMMAND} --install ${plugin_path}/${BUILD_DIR})
						endif()
					endif()
					
				endif()
			endforeach()
			
		endif()
	endif()
endforeach()

if(INSTALL_DKLIBS)
	dk_deleteEmptyDirectories(${CMAKE_INSTALL_PREFIX})
endif()

if(NOT DKAPP)
	return()
endif()	

dk_info("\n")
dk_info("***************************************")
dk_info("********** Creating ${APP_NAME} **********")
dk_info("***************************************\n")

# Create version from date
string(TIMESTAMP year "%y")
string(TIMESTAMP month "%m")
string(TIMESTAMP day "%d")
dk_set(APP_VERSION "${year}.${month}.${day}")

## Create the DKPlugins.h header file
if(PLUGINS_FILE)
	string(REPLACE "#include \"DKWindow.h\"" "" PLUGINS_FILE ${PLUGINS_FILE})
	string(REPLACE "\\n" "\n" PLUGINS_FILE ${PLUGINS_FILE})
	file(WRITE ${DKPROJECT}/DKPlugins.h ${PLUGINS_FILE})
endif()

if(HAVE_DK)
	dk_info("Copying DKPlugins/_DKIMPORT/ to App...")
	dk_copy(${DKPLUGINS}/_DKIMPORT/icons ${DKPROJECT}/icons FALSE) ## copy app default files recursivly without overwrite
	dk_copy(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h FALSE) ## copy app default files recursivly without overwrite
	#dk_copy(${DKPLUGINS}/_DKIMPORT/App.h ${DKPROJECT}/App.h FALSE) ## copy app default files recursivly without overwrite
	#dk_copy(${DKPLUGINS}/_DKIMPORT/App.cpp ${DKPROJECT}/App.cpp FALSE) ## copy app default files recursivly without overwrite
	dk_copy(${DKPLUGINS}/_DKIMPORT/main.cpp ${DKPROJECT}/main.cpp FALSE)
endif()
	
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
	########################## CREATE ICONS ###############################
	if(EXISTS ${DKPROJECT}/icons/icon.png)
		if(IMAGEMAGICK_CONVERT)
			dk_info("Building icons for ${APP_NAME} . . .")
			dk_makeDirectory(${DKPROJECT}/icons/windows)
			dk_executeProcess(${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=256,128,64,48,32,16 ${DKPROJECT}/icons/windows/icon.ico)
			dk_copy(${DKPROJECT}/icons/windows/icon.ico ${DKPROJECT}/assets/icon.ico TRUE) # copy the icon to assets
			dk_executeProcess(${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=16 ${DKPROJECT}/assets/favicon.ico)
		endif()
	endif()
	
	################# BACKUP USERDATA / INJECT ASSETS #####################	
	if(HAVE_DK)
		## ASSETS ##
		# Backup files and folders excluded from the package
		dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		# Remove excluded files and folders before packaging
		file(REMOVE ${DKPROJECT}/assets/USER)
		#Compress the assets, they will be included by resource.rc
		dk_info("Creating assets.zip . . .")
		dk_zip(${DKPROJECT}/assets)
		# Restore the backed up files, excluded from assets
		dk_copy(${DKPROJECT}/Backup ${DKPROJECT}/assets TRUE)
		file(REMOVE ${DKPROJECT}/Backup)
		dk_copy(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h TRUE) #required
	endif()	
		
	###################### Backup Executable ###########################
	if(DEBUG)
		dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe.backup true)
	endif()
	if(RELEASE)
		dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.exe.backup true)
	endif()
		
	####################### Create Executable Target ###################
	if(HAVE_DK)
		dk_copy(${DKPLUGINS}/_DKIMPORT/win/resource.h ${DKPROJECT}/resource.h FALSE)
		dk_copy(${DKPLUGINS}/_DKIMPORT/win/resource.rc ${DKPROJECT}/resource.rc FALSE)
		file(GLOB_RECURSE resources_SRC 
			${DKPROJECT}/*.manifest
			${DKPROJECT}/*.rc
			${DKPROJECT}/icons/windows/*.rc)
			list(APPEND App_SRC ${resources_SRC})
	endif()
	add_executable(${APP_NAME} WIN32 ${App_SRC})
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	########################## Add Dependencies ########################
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
	
	
	#dk_set(CMAKE_BUILD_TYPE "")
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${APP_NAME}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#	#COMMAND cmd /c ${CMAKE_COMMAND} --build ${DKPROJECT}/${OS} --target ${APP_NAME}
	#)
	
	#add_custom_command(
    #TARGET ${APP_NAME}
    #POST_BUILD
    #COMMAND "mt.exe" -nologo
    #        -manifest \"${DKPROJECT}/compatibility.manifest\"
    #        -outputresource:"${DKPROJECT}/win32/Debug/${APP_NAME}.exe"\;\#1
    #COMMENT "Adding manifest..."
    #)
	
	#CPP_DKFile_Copy(app_path+OS+"/Release/"+APP+".pdb", app_path+"assets/"+APP+".pdb", true)
	#CPP_DK_Execute(DIGITALKNOB+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/Release/"+APP+".exe")
	

endif(WIN_32)
	
##########
if(WIN_64)
	########################## CREATE ICONS ###############################
	if(EXISTS ${DKPROJECT}/icons/icon.png)
		if(IMAGEMAGICK_CONVERT)
			dk_info("Building icons for ${APP_NAME} . . .")
			dk_makeDirectory(${DKPROJECT}/icons/windows)
			dk_executeProcess(${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=256,128,64,48,32,16 ${DKPROJECT}/icons/windows/icon.ico)
			dk_copy(${DKPROJECT}/icons/windows/icon.ico ${DKPROJECT}/assets/icon.ico TRUE)
			dk_executeProcess(${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=16 ${DKPROJECT}/assets/favicon.ico)
		endif()
	endif()
			
	################# BACKUP USERDATA / INJECT ASSETS #####################
	if(HAVE_DK)
		dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		file(REMOVE ${DKPROJECT}/assets/USER)
		#Compress the assets, they will be included by resource.rc
		dk_info("Creating assets.zip . . .")
		dk_zip(${DKPROJECT}/assets)
		# Restore the backed up files
		dk_copy(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ TRUE)
		file(REMOVE ${DKPROJECT}/Backup)
		#dummy assets.h file, or the builder wil complain about assets.h missing
		dk_copy(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h TRUE)
	endif()

	###################### Backup Executable ###########################
	if(DEBUG)
		dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe.backup true)
	endif()
	if(RELEASE)
		dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.exe.backup true)
	endif()
		
	####################### Create Executable Target ###################
	if(HAVE_DK)
		##set_source_files_properties(${DIGITALKNOB}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
		dk_copy(${DKPLUGINS}/_DKIMPORT/win/resource.h ${DKPROJECT}/resource.h FALSE)
		dk_copy(${DKPLUGINS}/_DKIMPORT/win/resource.rc ${DKPROJECT}/resource.rc FALSE)
		file(GLOB_RECURSE resources_SRC 
			${DKPROJECT}/*.manifest
			${DKPROJECT}/*.rc
			${DKPROJECT}/icons/windows/*.rc)
	endif()
	list(APPEND App_SRC ${resources_SRC})
	add_executable(${APP_NAME} WIN32 ${App_SRC})

	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
		
	############# Link Libraries, Set Startup Project #################
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
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
		
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	add_custom_command(
		TARGET ${APP_NAME}
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	)
	#CPP_DKFile_Copy(app_path+OS+"/Release/"+APP+".pdb", app_path+"assets/"+APP+".pdb", true)
	#CPP_DK_Execute(DIGITALKNOB+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/Release/"+APP+".exe")
endif(WIN_64)


#######
if(MAC)
	###################### Backup Executable ###########################
	if(DEBUG)
		dk_copy(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app.backup TRUE)
	endif()
	if(RELEASE)
		dk_copy(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app.backup TRUE)
	endif()
		
	########################## CREATE ICONS ###############################
	if(EXISTS ${DKPROJECT}/icons/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/mac)
		dk_makeDirectory(${DKPROJECT}/icons/mac/icons.iconset)
		dk_executeProcess(sips -z 16 16 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_16x16.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 32 32 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_16x16@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 32 32 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_32x32.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 64 64 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_32x32@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 128 128 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_128x128.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 256 256 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_128x128@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 256 256 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_256x256.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 512 512 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_256x256@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 512 512 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_512x512.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 1024 1024 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/mac/icons.iconset/icon_512x512@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(iconutil -c icns -o ${DKPROJECT}/icons/mac/icons.icns ${DKPROJECT}/icons/mac/icons.iconset WORKING_DIRECTORY ${DIGITALKNOB})
		set(MACOSX_BUNDLE_ICON_FILE icons.icns)
		set(app_ICONS ${DKPROJECT}/icons/mac/icons.icns)
		set_source_files_properties(${app_ICONS} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
	endif()
		
	################# BACKUP USERDATA / INJECT ASSETS #####################	
	dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
	file(REMOVE ${DKPROJECT}/assets/USER)
	dk_copy(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
	file(REMOVE ${DKPROJECT}/Backup)
	
	####################### Create Executable Target ###################
	file(GLOB_RECURSE m_SRC 
		${DKPROJECT}/*.m
		${DKPROJECT}/*.mm)
	list(APPEND App_SRC ${m_SRC})
	add_executable(${APP_NAME} MACOSX_BUNDLE ${app_ICONS} ${App_SRC})
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			if(NOT ${plugin} MATCHES "DKCefChild")
				add_dependencies(${APP_NAME} ${plugin})
			endif()
		endif()
	endforeach()
		
	######################### Create Info.plist #######################
	dk_set(PRODUCT_BUNDLE_IDENTIFIER com.digitalknob.${APP_NAME})
	dk_set(CFBundleDevelopmentRegion en)
	dk_set(CFBundleDisplayName ${APP_NAME})
	dk_set(CFBundleExecutable wrapper) ##${APP_NAME})
	dk_set(CFBundleGetInfoString "DigitalKnob")
	dk_set(CFBundleIconFile "icons.icns")
	#dk_set(CFBundleIconFiles "icons.icns")
	dk_set(CFBundleIdentifier ${PRODUCT_BUNDLE_IDENTIFIER})
	dk_set(CFBundleInfoDictionaryVersion 6.0)
	dk_set(CFBundleLongVersionString "${APP_NAME}-${APP_VERSION}")
	dk_set(CFBundleName ${APP_NAME})
	dk_set(CFBundlePackageType APPL)
	dk_set(CFBundleShortVersionString ${APP_VERSION})
	dk_set(CFBundleSignature ????)
	dk_set(CFBundleVersion 1.0)
	#dk_set(LSRequiresIPhoneOS NO)
	dk_set(NSMainNibFile "")
	#dk_set(UILaunchStoryboardName dk)
	#dk_set(UIMainStoryboardFile dk.storyboard)
	set_target_properties(${APP_NAME} PROPERTIES 
		MACOSX_BUNDLE TRUE 
		XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ""
		MACOSX_BUNDLE_INFO_PLIST ${DKPLUGINS}/_DKIMPORT/mac/Info.plist)
		
	##############Delete Exlusions and Copy Assets to Bundle #######################
	
	file(REMOVE ${DKPROJECT}/assets/log.txt)
	file(REMOVE ${DKPROJECT}/assets/cef.txt)
	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${DKPROJECT}/assets $<TARGET_BUNDLE_CONTENT_DIR:${APP_NAME}>/Resources)
		
	############# Link Libraries, Set Startup Project #################
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY XCODE_STARTUP_PROJECT ${APP_NAME})
	
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	add_custom_command(
		TARGET ${APP_NAME}
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	)
	
	# Copy the CEF framework into the app bundle
	if(EXISTS ${CEF})
		dk_info("Adding Chromium Embedded Framework.framework to bundle . . .")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory "${CEF}/$<CONFIG>/Chromium Embedded Framework.framework" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/Chromium Embedded Framework.framework")
	endif()
	
	# Copy the DKCefChild into the app bundle
	if(EXISTS "${DKPLUGINS}/DKCefChild/${OS}/Release/DKCefChild.app")
		dk_info("Adding Chromium Embedded Framework.framework to bundle . . .")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${DKPLUGINS}/DKCefChild/${OS}/$<CONFIG>/DKCefChild.app" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/${APP_NAME} Helper.app")
	endif()
	
	# Make bundle open with Terminal
	# https://github.com/pyinstaller/pyinstaller/issues/5154#issuecomment-690646012
	if(true)
		dk_info("Making bundle app run in terminal on double-click . . .")
		set(TERMINAL_SCRIPT 
			"\#!/bin/bash\n"
			"dir=$(cd \"$( dirname \"\${0}\")\" && pwd )\n"
			"Open -a \"Terminal\" \"\${dir}/${APP_NAME}\""
		)
		file(WRITE ${DKPROJECT}/${OS}/wrapper ${TERMINAL_SCRIPT}) #${APP_NAME}
		dk_executeProcess(chmod +x ${DKPROJECT}/${OS}/wrapper WORKING_DIRECTORY ${DKPROJECT}/${OS})
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${DKPROJECT}/${OS}/wrapper" "$<TARGET_FILE_DIR:${APP_NAME}>/wrapper")
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


# https://github.com/forexample/testapp/blob/master/CMakeLists.txt
#################
if(IOS OR IOSSIM)
	
	###################### Backup Executable ###########################
	if(DEBUG)
		dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app.backup true)
	endif()
	if(RELEASE)
		dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app.backup true)
	endif()
	
	###################### BACKUP USERDATA ###############################
	# Backup files and folders excluded from the package
	#dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
	# Remove excluded files and folders before packaging
	#file(REMOVE ${DKPROJECT}/assets/USER)
	# Restore the backed up files, excluded from assets
	#dk_copy(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
	#file(REMOVE ${DKPROJECT}/Backup)
		
	########################## Images ##############################
	#TODO
	
	########################## ICONS ###############################
	if(EXISTS ${DKPROJECT}/icons/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/ios)
		dk_makeDirectory(${DKPROJECT}/icons/ios/icons.iconset)
		dk_executeProcess(sips -z 16 16 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_16x16.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 32 32 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_16x16@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 32 32 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_32x32.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 64 64 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_32x32@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 128 128 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_128x128.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 256 256 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_128x128@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 256 256 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_256x256.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 512 512 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_256x256@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 512 512 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_512x512.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(sips -z 1024 1024 ${DKPROJECT}/icons/icon.png --out ${DKPROJECT}/icons/ios/icons.iconset/icon_512x512@2x.png WORKING_DIRECTORY ${DIGITALKNOB})
		dk_executeProcess(iconutil -c icns -o ${DKPROJECT}/icons/ios/icons.icns ${DKPROJECT}/icons/ios/icons.iconset WORKING_DIRECTORY ${DIGITALKNOB})
		set(MACOSX_BUNDLE_ICON_FILE icons.icns)
		set(app_ICONS ${DKPROJECT}/icons/ios/icons.icns)
		set_source_files_properties(${app_ICONS} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
	endif()
	
	####################### Storyboards ############################
	#TODO
		
	####################### Create Executable Target ###################
	file(GLOB_RECURSE m_SRC 
	${DKPROJECT}/*.m
	${DKPROJECT}/*.mm)
	list(APPEND App_SRC ${m_SRC})
	#if(HAVE_DK)
	#	list(APPEND App_SRC ${DKPLUGINS}/DK/DKAppDelegate.h)
	#	list(APPEND App_SRC ${DKPLUGINS}/DK/DKAppDelegate.m)
	#endif()
	add_executable(${APP_NAME} MACOSX_BUNDLE ${app_ICONS} ${App_SRC} ${RES_FILES})
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
		
	######################### Create Info.plist #######################
	dk_set(PRODUCT_BUNDLE_IDENTIFIER com.digitalknob.${APP_NAME})
	dk_set(CFBundleDevelopmentRegion en)
	dk_set(CFBundleDisplayName ${APP_NAME})
	dk_set(CFBundleExecutable ${APP_NAME})
	dk_set(CFBundleGetInfoString DigitalKnob)
	dk_set(CFBundleIconFile "icons.icns")
	dk_set(CFBundleIdentifier ${PRODUCT_BUNDLE_IDENTIFIER})
	dk_set(CFBundleInfoDictionaryVersion 6.0)
	dk_set(CFBundleLongVersionString 1.0.0)
	dk_set(CFBundleName ${APP_NAME})
	dk_set(CFBundlePackageType APPL)
	dk_set(CFBundleShortVersionString 1.0)
	dk_set(CFBundleSignature ????)
	dk_set(CFBundleVersion 1.0)
	#dk_set(LSRequiresIPhoneOS NO)
	dk_set(NSMainNibFile "")
	#dk_set(UILaunchStoryboardName dk)
	#dk_set(UIMainStoryboardFile dk.storyboard)
	set_target_properties(${APP_NAME} PROPERTIES MACOSX_BUNDLE TRUE MACOSX_BUNDLE_INFO_PLIST ${DKPLUGINS}/_DKIMPORT/ios/Info.plist)
			
	###################### Add Assets to Bundle #######################
	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${DKPROJECT}/assets $<TARGET_FILE_DIR:${APP_NAME}>/assets)
	#if(EXISTS ${DKPROJECT}/icons/mac/icons.icns)
	#	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${DKPROJECT}/icons/ios/icons.icns $<TARGET_FILE_DIR:${APP_NAME}>/Resources/icons.icns)
	#endif()
	
	############# Link Libraries, Set Startup Project #################
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY XCODE_STARTUP_PROJECT ${APP_NAME})
	
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	add_custom_command(
		TARGET ${APP_NAME}
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	)
endif()



#########
if(LINUX)
if(NOT RASPBERRY)
	###################### Backup Executable ###########################
	if(DEBUG)
		dk_copy(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup TRUE)
	elseif(RELEASE)
		dk_copy(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup TRUE)
	endif()
	
	########################## CREATE ICONS ###############################
	dk_copy(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)
	
	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
		dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		file(REMOVE ${DKPROJECT}/assets/USER)
		# Remove excluded files and folders before packaging
		dk_info("Creating assets.zip . . .")
		dk_zip(${DKPROJECT}/assets)
		#dk_info("Creating assets.h . . .")
		bin2h(SOURCE_FILE ${DKPROJECT}/assets.zip HEADER_FILE ${DKPROJECT}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		dk_copy(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
		file(REMOVE ${DKPROJECT}/Backup)
	endif()
	
	####################### Create Executable Target ###################
	add_executable(${APP_NAME} ${App_SRC})
	if(DEBUG)
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${LIBS})
	elseif(RELEASE)
		target_link_libraries(${APP_NAME} ${RELEASE_LIBS} ${LIBS})
	endif()
	
	###################### Add Build Dependencies ######################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
	
	############# Create .desktop Icon Files / Install ################
	if(DEBUG)
		dk_set(DESKTOP_FILE
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
		dk_set(DESKTOP_FILE
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
		dk_executeProcess(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DKPROJECT}/${OS}/Release/${APP_NAME}.desktop WORKING_DIRECTORY ${DKPROJECT}/${OS}/Release)
	endif()
	
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	add_custom_command(
		TARGET ${APP_NAME}
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	)
	#CPP_DK_Execute("chmod +x "+app_path+OS+"/Debug/"+APP)
endif()
endif()



#############
if(RASPBERRY)
	########################## CREATE ICONS ###############################
	dk_copy(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)

	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
		dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER TRUE)
		# Remove excluded files and folders before packaging
		file(REMOVE ${DKPROJECT}/assets/USER)
		dk_info("Creating assets.zip . . .")
		dk_zip(${DKPROJECT}/assets)
		#dk_info("Creating assets.h . . .")
		bin2h(SOURCE_FILE ${DKPROJECT}/assets.zip HEADER_FILE ${DKPROJECT}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		dk_copy(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ FALSE)
		file(REMOVE ${DKPROJECT}/Backup)
	endif()
	
	###################### Backup Executable ###########################
	if(DEBUG)
		dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup true)
	elseif(RELEASE)
		dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup true)
	endif()
	
	####################### Create Executable Target ###################
	add_executable(${APP_NAME} ${App_SRC})
	if(DEBUG)
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${LIBS})
	elseif(RELEASE)
		target_link_libraries(${APP_NAME} ${RELEASE_LIBS} ${LIBS})
	endif()

	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
		
	############# Create .desktop Icon Files and Install ##############
	if(DEBUG)
	# Create .desktop file for Debug
	dk_set(DESKTOP_FILE
		"[Desktop Entry]\n"
		"Encoding=UTF-8\n"
		"Version=1.0\n"
		"Type=Application\n"
		"Terminal=true\n"
		"Name=${APP_NAME}\n"
		"Exec=${DKPROJECT}/${OS}/Debug/${APP_NAME}\n"
		"Icon=${DKPROJECT}/icons/icon.png\n")
	file(WRITE ${DKPROJECT}/${OS}/Debug/${APP_NAME}.desktop ${DESKTOP_FILE})
	endif()
	if(RELEASE)
	# Create .desktop file for Release
	dk_set(DESKTOP_FILE
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
	if(RELEASE)
		dk_executeProcess(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DKPROJECT}/${OS}/Release/${APP_NAME}.desktop WORKING_DIRECTORY ${DKPROJECT}/${OS}/Release)
	endif()
		
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	add_custom_command(
		TARGET ${APP_NAME}
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	)
	#CPP_DK_Execute("chmod +x "+app_path+OS+"/Debug/"+APP)
endif()

###########
if(ANDROID)
	########################## CREATE ICONS ###############################
	if(IMAGEMAGICK_CONVERT)
		dk_info("Building android icons for ${APP_NAME} . . .")
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-hdpi)
		dk_executeProcess(${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 72x72 ${DKPROJECT}/icons/android/drawable-hdpi/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-ldpi)
		dk_executeProcess(${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 36x36 ${DKPROJECT}/icons/android/drawable-ldpi/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-mdpi)
		dk_executeProcess(${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 48x48 ${DKPROJECT}/icons/android/drawable-mdpi/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-xhdpi)
		dk_executeProcess(${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 96x96 ${DKPROJECT}/icons/android/drawable-xhdpi/icon.png)
		dk_makeDirectory(${DKPROJECT}/icons/android/drawable-xxhdpi)
		dk_executeProcess(${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -resize 144x144 ${DKPROJECT}/icons/android/drawable-xxhdpi/icon.png)
	endif()
	dk_copy(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png TRUE)
	dk_copy(${DKPROJECT}/icons/icon.png ${DKPROJECT}/${OS}/res/drawable/icon.png TRUE)
		
	###################### Backup Executable ###########################
	if(DEBUG)
		dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.apk ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.apk.backup true)
	endif()
	if(RELEASE)
		dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.apk ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.apk.backup true)
	endif()
		
	####################### Create Library Target ###################
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/app/src/main/jniLibs/${ANDROID_ABI}")
	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/app/src/main/jniLibs/${ANDROID_ABI}")

	if(ANDROID_32)
		dk_copy(${DKPLUGINS}/_DKIMPORT/android/ ${DKPROJECT}/android32/ FALSE)
		dk_copy(${DKPLUGINS}/_DKIMPORT/android32/ ${DKPROJECT}/android32/ FALSE)
	endif()
	if(ANDROID_64)
		dk_copy(${DKPLUGINS}/_DKIMPORT/android/ ${DKPROJECT}/android64/ FALSE)
		dk_copy(${DKPLUGINS}/_DKIMPORT/android64/ ${DKPROJECT}/android64/ FALSE)
	endif()
	set(CMAKE_ANDROID_GUI 1)
	
	dk_set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} -frtti)
	dk_set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -frtti)
	
	#add_library(${APP_NAME} SHARED ${App_SRC})
	add_library(main SHARED ${App_SRC})
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			#add_dependencies(${APP_NAME} ${plugin})
			add_dependencies(main ${plugin})
		endif()	
	endforeach()
	
	######################### Link Libraries ###########################
	#target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	#target_include_directories(${APP_NAME} PUBLIC ${SDL2}/include)
	target_link_libraries(main ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	target_include_directories(main PUBLIC ${SDL2}/include)
	
	include_external_msproject(gradleAPK gradleAPK.androidproj TYPE 39E2626F-3545-4960-A6E8-258AD8476CE5)
	set_property(TARGET gradleAPK PROPERTY VS_SOLUTION_DEPLOY ON) # NOT WORKING
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT gradleAPK)
		
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	add_custom_command(
		TARGET main
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:main>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:main>"
		COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	)
	
	#if(CPP_DK_Execute(app_path+OS+"/gradlew --project-dir "+app_path+OS+" --info clean build").error)
	#	return
	#if(CPP_DK_Execute(app_path+OS+"/___Install.cmd").error)
	#	return
		
endif()




dk_buildLog("\n\n")
dk_buildLog("########### ${APP_NAME} Post-Generated Compiler Settings ###########")
dk_buildLog("     COMPILE_DEFINITIONS:  ${COMPILE_DEFINITIONS}")
dk_buildLog("           DEFINE_SYMBOL:  ${DEFINE_SYMBOL}")
dk_buildLog("         COMPILE_OPTIONS:  ${COMPILE_OPTIONS}")
dk_buildLog("     INCLUDE_DIRECTORIES:  ${INCLUDE_DIRECTORIES}")
dk_buildLog("        LINK_DIRECTORIES:  ${LINK_DIRECTORIES}")
dk_buildLog("  STATIC_LIBRARY_OPTIONS:  ${STATIC_LIBRARY_OPTIONS}")
dk_buildLog("             DEBUG_FLAGS:  ${DEBUG_FLAGS}")
dk_buildLog("           RELEASE_FLAGS:  ${RELEASE_FLAGS}")
dk_buildLog("                   FLAGS:  ${FLAGS}")
dk_buildLog("          DKDEFINES_LIST:  ${DKDEFINES_LIST}")
dk_buildLog("         DKLINKDIRS_LIST:  ${DKLINKDIRS_LIST}")

dk_buildLog("\n\n")
dk_buildLog("###################  ${APP_NAME} Source Files  ##################")
foreach(src ${App_SRC})
	dk_buildLog(${src})
endforeach()

dk_buildLog("\n\n")
dk_buildLog("###############  ${APP_NAME} Include Diretories  ##############")
foreach(dir ${DKINCLUDES_LIST})
	dk_buildLog(${dir})
endforeach()

dk_buildLog("\n\n")
dk_buildLog("###############  ${APP_NAME} Include Libraries  ##############")
dk_buildLog("### Common libraries ###")
foreach(lib ${LIBS})
	dk_buildLog(${lib})
endforeach()
dk_buildLog("\n")
dk_buildLog(" ### Debug libraries ###")
foreach(lib ${DEBUG_LIBS})
	if(NOT "${lib}" STREQUAL "debug")
		dk_buildLog(${lib})
	endif()
endforeach()
dk_buildLog("\n")
dk_buildLog(" ### Release libraries ###")
foreach(lib ${RELEASE_LIBS})
	if(NOT "${lib}" STREQUAL "optimized")
		dk_buildLog(${lib})
	endif()
endforeach()

# This needs to be a Post-Build after the executable is available
#dk_buildLog("\n")
#dk_buildLog(" ### Dynamic libraries ###")
#if(LINUX OR RASPBERRY OR ANDROID)
#	dk_command(ldd >> ${DKPROJECT}/${OS}/DKBUILD.log)
#elseif(MAC OR IOS)
	# TODO
	#dk_command(otool -L ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app)
#elseif(WIN)	
	# TODO
	#"C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.30.30705/bin/Hostx86/x86/dumpbin.exe" /dependents ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe
#endif()

dk_info("\n\n")
dk_info("**************************************************")
dk_info("****** Generated ${APP_NAME} - ${OS}  ************")
dk_info("**************************************************\n")
