# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions :
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
include_guard()


get_filename_component(path ${CMAKE_SOURCE_DIR} ABSOLUTE)
set(DKCMAKE ${path} CACHE INTERNAL "")

include("${DKCMAKE}/DK.cmake")
include("${DKCMAKE}/DKDisabled.cmake")

dk_info("\n")
dk_info("############################################################")
dk_info("######################  DigitalKnob  #######################")
dk_info("############################################################")
dk_info("\n")
get_filename_component(APP_NAME ${DKPROJECT} NAME)
string(REPLACE " " "_" APP_NAME ${APP_NAME})
set(APP_NAME ${APP_NAME}_APP)

############################################################################################
############################   ADD EXECUTABLE  #############################################
############################################################################################
if(NOT TARGET)
	include(${DKCMAKE}/DKBuildFlags.cmake)
	PROJECT(${APP_NAME})
	dk_set(DKAPP ON)
endif()

##################################################
##### Scan the DKPlugins and build the lists #####
##################################################

include(${DKPROJECT}/DKMAKE.cmake)
file(REMOVE ${DKPROJECT}/${OS}/DKBUILD.log)
dk_printSettings()


dk_buildLog("##############################################")
dk_buildLog("######  Enabled Dependencies (sorted)  #######")
dk_buildLog("##############################################")
list(REMOVE_DUPLICATES dkdepend_list)
foreach(plugin ${dkdepend_list})
	dk_includes(${dk_disabled_list} ${plugin} isDisabled)
	if(NOT isDisabled)
		dk_buildLog("${plugin}")
	endif()
endforeach()
dk_buildLog("\n")

foreach(plugin ${dkdepend_list})
	dk_set(QUEUE_BUILD OFF)
	dk_set(LIBLIST "") # used for double checking
	
	dk_info("############################################################")
	dk_info("######  Processing   ${plugin} . . .                        ")
	dk_info("############################################################")
	
	## Strip any sublibrary named in the plugin, and enable it
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
	#dk_debug(${plugin_path})

	# This executes the 3rdParty library builds, and creates CMakeLists.txt files for DKPlugins
	include(${plugin_path}/DKMAKE.cmake)
	
	#check that each library is using the proper variables. Should be UPPERCASE plugin name.   I.E. boost = ${BOOST}
	if(NOT ${plugin})
		dk_error("${plugin} variable is invalid")
	endif()
	
	#NOTE: we won't have the library paths to remove until we've run DKCMake.cmake for the library
	# We can use this to refresh 3rdParty Plugins
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
	#if(INSTALL_DKLIBS)
	#	if(${isDKPlugin} EQUAL -1)
	#		if(EXISTS ${plugin_path}/${BUILD_DIR}/cmake_install.cmake)
	#			dk_queueCommand(${CMAKE_COMMAND} --install ${plugin_path}/${BUILD_DIR})
	#		endif()
	#	endif()
	#endif()
	
	if(${isDKPlugin} GREATER -1)
		# Install header files for DKPlugin
		if(INSTALL_DKLIBS)
			dk_info("Installing ${plugin} header files")
			file(INSTALL DIRECTORY ${plugin_path}/ DESTINATION ${CMAKE_INSTALL_PREFIX}/include/${plugin} FILES_MATCHING PATTERN "*.h")
			dk_deleteEmptyDirectories(${CMAKE_INSTALL_PREFIX}/include/${plugin})
		endif()
		
		#Add the DKPlugin to the app project
		if(INCLUDE_DKPLUGINS)
			if(EXISTS "${plugin_path}/CMakeLists.txt")
				if(MULTI_CONFIG)
					add_subdirectory(${plugin_path} ${plugin_path}/${OS})
				else()
					if(DEBUG)
						add_subdirectory(${plugin_path} ${plugin_path}/${OS}/Debug)
					elseif(RELEASE)
						add_subdirectory(${plugin_path} ${plugin_path}/${OS}/Release)
					endif()
				endif()
			endif()
		endif()
		
		## Prebuild DKPlugins switch
		## Only prebuild if the library binaries are missing
		#foreach(lib ${LIBLIST})
		#	if(NOT EXISTS ${lib})
				#dk_set(PREBUILD ON)
		#		dk_set(QUEUE_BUILD ON)
		#	endif()
		#endforeach()
		
		if(NOT INCLUDE_DKPLUGINS)
			dk_info("******* Prebuilding ${plugin} *******")
			dk_setPath(${plugin_path}/${BUILD_DIR})
			
			if(MULTI_CONFIG)
				ANDROID32_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_32=ON ${plugin_path})
				ANDROID64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_64=ON ${plugin_path})
				EMSCRIPTEN_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DEMSCRIPTEN=ON ${plugin_path})
				IOS32_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOS_32=ON ${plugin_path})
				IOS64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOS_64=ON ${plugin_path})
				IOSSIM32_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOSSIM_32=ON ${plugin_path})
				IOSSIM64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOSSIM_64=ON ${plugin_path})
				LINUX32_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DLINUX_32=ON ${plugin_path})
				LINUX64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DLINUX_64=ON ${plugin_path})
				MAC32_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DMAC_32=ON ${plugin_path})
				MAC64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DMAC_64=ON ${plugin_path})
				RASPBERRY32_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_32=ON ${plugin_path})
				RASPBERRY64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_64=ON ${plugin_path})
				WIN32_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DWIN_32=ON ${plugin_path})
				WIN64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DWIN_64=ON ${plugin_path})
				DEBUG_dk_queueCommand		(${CMAKE_COMMAND} --build . --config Debug)
				RELEASE_dk_queueCommand		(${CMAKE_COMMAND} --build . --config Release)
			else()
				if(DEBUG)
					ANDROID32_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_32=ON ${plugin_path})
					ANDROID64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_64=ON ${plugin_path})
					EMSCRIPTEN_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DEMSCRIPTEN=ON ${plugin_path})
					IOS32_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOS_32=ON ${plugin_path})
					IOS64_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOS_64=ON ${plugin_path})
					IOSSIM32_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOSSIM_32=ON ${plugin_path})
					IOSSIM64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOSSIM_64=ON ${plugin_path})
					LINUX32_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DLINUX_32=ON ${plugin_path})
					LINUX64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DLINUX_64=ON ${plugin_path})
					MAC32_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DMAC_32=ON ${plugin_path})
					MAC64_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DMAC_64=ON ${plugin_path})
					RASPBERRY32_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DRASPBERRY_32=ON ${plugin_path})
					RASPBERRY64_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DRASPBERRY_64=ON ${plugin_path})
					WIN32_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DWIN_32=ON ${plugin_path})
					WIN64_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DWIN_64=ON ${plugin_path})
					DEBUG_dk_queueCommand				(${CMAKE_COMMAND} --build . --config Debug)
				elseif(RELEASE)
					ANDROID32_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_32=ON ${plugin_path})
					ANDROID64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_64=ON ${plugin_path})
					EMSCRIPTEN_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DEMSCRIPTEN=ON ${plugin_path})
					IOS32_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOS_32=ON ${plugin_path})
					IOS64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOS_64=ON ${plugin_path})
					IOSSIM32_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOSSIM_32=ON ${plugin_path})
					IOSSIM64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOSSIM_64=ON ${plugin_path})
					LINUX32_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DLINUX_32=ON ${plugin_path})
					LINUX64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DLINUX_64=ON ${plugin_path})
					MAC32_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DMAC_32=ON ${plugin_path})
					MAC64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DMAC_64=ON ${plugin_path})
					RASPBERRY32_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_32=ON ${plugin_path})
					RASPBERRY64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_64=ON ${plugin_path})
					WIN32_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DWIN_32=ON ${plugin_path})
					WIN64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DWIN_64=ON ${plugin_path})
					RELEASE_dk_queueCommand				(${CMAKE_COMMAND} --build . --config Release)
				endif()
			endif()
			
			#set(PREBUILD OFF)

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
			
		endif() # NOT INCLUDE_DKPLUGINS
	endif() # isDKPlugin
	
	#foreach(lib ${LIBLIST})
	#	if(NOT EXISTS ${lib})
	#		dk_error("\n\n\n****************************\nFAILED to find: ${lib} \n***********************************")
	#	endif()
	#endforeach()
	
endforeach()

if(INSTALL_DKLIBS)
	# clean up empty directories
	dk_deleteEmptyDirectories(${CMAKE_INSTALL_PREFIX}/include)
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
	## copy app default files recursivly without overwrite
	dk_info("Copying DKPlugins/_DKIMPORT/ to App...")
	dk_copy(${DKPLUGINS}/_DKIMPORT/icons ${DKPROJECT}/icons) 
	dk_copy(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h)
	dk_copy(${DKPLUGINS}/_DKIMPORT/main.cpp ${DKPROJECT}/main.cpp)
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
			dk_makeDirectory(${DKPROJECT}/assets)
			dk_copy(${DKPROJECT}/icons/windows/icon.ico ${DKPROJECT}/assets/icon.ico OVERWRITE)
			dk_executeProcess(${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=16 ${DKPROJECT}/assets/favicon.ico)
		endif()
	endif()
	
	################# BACKUP USERDATA / INJECT ASSETS #####################	
	if(HAVE_DK)
		## ASSETS ##
		# Backup files and folders excluded from the package
		dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER OVERWRITE NOERROR)
		# Remove excluded files and folders before packaging
		file(REMOVE ${DKPROJECT}/assets/USER)
		#Compress the assets, they will be included by resource.rc
		dk_info("Creating assets.zip . . .")
		dk_zip(${DKPROJECT}/assets)
		# Restore the backed up files, excluded from assets
		dk_copy(${DKPROJECT}/Backup ${DKPROJECT}/assets OVERWRITE NOERROR)
		file(REMOVE ${DKPROJECT}/Backup)
		dk_copy(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h OVERWRITE) #required
	endif()	
		
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe.backup OVERWRITE NOERROR)
		endif()
		if(RELEASE)
			dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.exe.backup OVERWRITE NOERROR)
		endif()
	endif()
		
	####################### Create Executable Target ###################
	if(HAVE_DK)
		dk_copy(${DKPLUGINS}/_DKIMPORT/win/resource.h ${DKPROJECT}/resource.h)
		dk_copy(${DKPLUGINS}/_DKIMPORT/win/resource.rc ${DKPROJECT}/resource.rc)
		file(GLOB_RECURSE resources_SRC 
			${DKPROJECT}/*.manifest
			${DKPROJECT}/*.rc
			${DKPROJECT}/icons/windows/*.rc)
		list(APPEND App_SRC ${resources_SRC})
	endif()
	
	# https://stackoverflow.com/a/74491601
	if(MSVC)
		add_executable(${APP_NAME} WIN32 ${App_SRC})
	else()
		add_executable(${APP_NAME} ${App_SRC})
	endif()
	
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	
	########################## Add Dependencies ########################
	if(INCLUDE_DKPLUGINS)
		foreach(plugin ${dkdepend_list})
			if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
				add_dependencies(${APP_NAME} ${plugin})
			endif()	
		endforeach()
	endif()

	##set_source_files_properties(${DIGITALKNOB}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
	
	if(MSVC)
		list(APPEND DEBUG_LINK_FLAGS /MANIFEST:NO)
		list(APPEND DEBUG_LINK_FLAGS /MANIFESTUAC:NO)
		list(APPEND DEBUG_LINK_FLAGS /level='highestAvailable')
		list(APPEND DEBUG_LINK_FLAGS /uiAccess='true')
		#list(APPEND DEBUG_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
		list(APPEND DEBUG_LINK_FLAGS /SUBSYSTEM:CONSOLE)
		list(APPEND DEBUG_LINK_FLAGS /SAFESEH:NO)
		list(APPEND DEBUG_LINK_FLAGS /NODEFAULTLIB:msvcrtd.lib)
		string(REPLACE ";" " " DEBUG_FLAGS "${DEBUG_LINK_FLAGS}")
		
		##list(APPEND RELEASE_LINK_FLAGS /FORCE) ## This can be used to debug if libraries cause redefinitions
		list(APPEND RELEASE_LINK_FLAGS /INCREMENTAL:NO)
		list(APPEND RELEASE_LINK_FLAGS /OPT:NOREF)
		list(APPEND RELEASE_LINK_FLAGS /MANIFEST:NO)
		list(APPEND RELEASE_LINK_FLAGS /MANIFESTUAC:NO)
		list(APPEND RELEASE_LINK_FLAGS /level='highestAvailable')
		list(APPEND RELEASE_LINK_FLAGS /uiAccess='true')
		#list(APPEND RELEASE_LINK_FLAGS /SUBSYSTEM:CONSOLE,5.01)
		list(APPEND RELEASE_LINK_FLAGS /SUBSYSTEM:CONSOLE)
		list(APPEND RELEASE_LINK_FLAGS /SAFESEH:NO)
		list(APPEND RELEASE_LINK_FLAGS /NODEFAULTLIB:msvcrt.lib)
		string(REPLACE ";" " " RELEASE_FLAGS "${RELEASE_LINK_FLAGS}")
		
		set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
		
		# remove -bin from APP_NAME. Was added to avoid app/library same name conflicts
		#set_target_properties(${APP_NAME} PROPERTIES OUTPUT_NAME ${APP_NAME})
		#set_target_properties(${APP_NAME} PROPERTIES RUNTIME_OUTPUT_NAME ${APP_NAME})
		set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${APP_NAME})
	endif()
	
	
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
		dk_depend(imagemagick)
		if(IMAGEMAGICK_CONVERT)
			dk_info("Building icons for ${APP_NAME} . . .")
			dk_makeDirectory(${DKPROJECT}/icons/windows)
			dk_executeProcess(${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=256,128,64,48,32,16 ${DKPROJECT}/icons/windows/icon.ico)
			dk_makeDirectory(${DKPROJECT}/assets)
			dk_copy(${DKPROJECT}/icons/windows/icon.ico ${DKPROJECT}/assets/icon.ico OVERWRITE)
			dk_executeProcess(${IMAGEMAGICK_CONVERT} ${DKPROJECT}/icons/icon.png -define icon:auto-resize=16 ${DKPROJECT}/assets/favicon.ico)
		endif()
	endif()
			
	################# BACKUP USERDATA / INJECT ASSETS #####################
	if(HAVE_DK)
		dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER OVERWRITE NOERROR)
		file(REMOVE ${DKPROJECT}/assets/USER)
		#Compress the assets, they will be included by resource.rc
		dk_info("Creating assets.zip . . .")
		dk_zip(${DKPROJECT}/assets)
		# Restore the backed up files
		dk_copy(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/ OVERWRITE NOERROR)
		file(REMOVE ${DKPROJECT}/Backup)
		#dummy assets.h file, or the builder wil complain about assets.h missing
		dk_copy(${DKPLUGINS}/_DKIMPORT/assets.h ${DKPROJECT}/assets.h OVERWRITE NOERROR)
	endif()

	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.exe.backup OVERWRITE NOERROR)
		endif()
		if(RELEASE)
			dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.exe ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.exe.backup OVERWRITE NOERROR)
		endif()
	endif()
		
	####################### Create Executable Target ###################
	if(HAVE_DK)
		##set_source_files_properties(${DIGITALKNOB}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
		dk_copy(${DKPLUGINS}/_DKIMPORT/win/resource.h ${DKPROJECT}/resource.h)
		dk_copy(${DKPLUGINS}/_DKIMPORT/win/resource.rc ${DKPROJECT}/resource.rc)
		file(GLOB_RECURSE resources_SRC 
			${DKPROJECT}/*.manifest
			${DKPROJECT}/*.rc
			${DKPROJECT}/icons/windows/*.rc)
		list(APPEND App_SRC ${resources_SRC})
	endif()
	
	
	# https://stackoverflow.com/a/74491601
	if(MSVC)
		add_executable(${APP_NAME} WIN32 ${App_SRC})
	else()
		add_executable(${APP_NAME} ${App_SRC})
	endif()

	########################## Add Dependencies ########################
	if(INCLUDE_DKPLUGINS)
		foreach(plugin ${dkdepend_list})
			if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
				add_dependencies(${APP_NAME} ${plugin})
			endif()	
		endforeach()
	endif()
		
	############# Link Libraries, Set Startup Project #################
	if(MULTI_CONFIG)
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	else()
		target_link_libraries(${APP_NAME} -static gcc stdc++ winpthread -dynamic)
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
		string(REPLACE ";" " " DEBUG_FLAGS "${DEBUG_LINK_FLAGS}")
		
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
		string(REPLACE ";" " " RELEASE_FLAGS "${RELEASE_LINK_FLAGS}")
	
		set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
		set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${APP_NAME})
	endif()
		
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${APP_NAME}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	#CPP_DKFile_Copy(app_path+OS+"/Release/"+APP+".pdb", app_path+"assets/"+APP+".pdb", true)
	#CPP_DK_Execute(DIGITALKNOB+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/Release/"+APP+".exe")
endif(WIN_64)


#######
if(MAC)

	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			dk_copy(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app.backup OVERWRITE NOERROR)
		endif()
		if(RELEASE)
			dk_copy(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app.backup OVERWRITE NOERROR)
		endif()
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
	dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER OVERWRITE)
	file(REMOVE ${DKPROJECT}/assets/USER)
	dk_copy(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/)
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
	if(MAC_TERMINAL_WRAPPER)
		dk_set(CFBundleExecutable wrapper)
	else()
		dk_set(CFBundleExecutable ${APP_NAME})
	endif()
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
		
	############## Delete Exlusions and Copy Assets to Bundle #######################
	if(EXISTS ${DKPROJECT}/assets)
		file(REMOVE ${DKPROJECT}/assets/log.txt)
		file(REMOVE ${DKPROJECT}/assets/cef.txt)
		add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${DKPROJECT}/assets $<TARGET_BUNDLE_CONTENT_DIR:${APP_NAME}>/Resources)
	endif()
		
	############# Link Libraries, Set Startup Project #################
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY XCODE_STARTUP_PROJECT ${APP_NAME})
	
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${APP_NAME}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	
	# Copy the CEF framework into the app bundle
	if(EXISTS ${CEF_BINARY})
		dk_info("Adding Chromium Embedded Framework.framework to bundle . . .")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory "${CEF_BINARY}/$<CONFIG>/Chromium Embedded Framework.framework" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/Chromium Embedded Framework.framework")
	endif()
	
	# Copy the DKCefChild.app into the app bundle as "DKAppName Helper.app"
	if(EXISTS "${DKPLUGINS}/DKCefChild/${OS}/Release/DKCefChild.app")
		dk_info("Adding ${APP_NAME} Helper to bundle . . .")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory "${DKPLUGINS}/DKCefChild/${OS}/$<CONFIG>/DKCefChild.app" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/${APP_NAME} Helper.app")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${DKPLUGINS}/DKCefChild/${OS}/$<CONFIG>/DKCefChild.app/Contents/MacOS/DKCefChild" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/${APP_NAME} Helper.app/Contents/MacOS/${APP_NAME} Helper")
	endif()
	
	# Make bundle open with Terminal
	# https://github.com/pyinstaller/pyinstaller/issues/5154#issuecomment-690646012
	if(MAC_TERMINAL_WRAPPER)
		dk_info("Making bundle app run in terminal on double-click . . .")
		set(TERMINAL_SCRIPT 
			"\#!/bin/bash\n"
			"dir=$(cd \"$( dirname \"\${0}\")\" && pwd )\n"
			"Open -a \"Terminal\" \"\${dir}/${APP_NAME}\""
		)
		file(WRITE ${DKPROJECT}/${OS}/wrapper ${TERMINAL_SCRIPT})
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
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			if(EXISTS ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app)
				dk_remove(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app.backup)
				dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.app.backup OVERWRITE)
			endif()
		endif()
		if(RELEASE)
			if(EXISTS ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app)
				dk_remove(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app.backup)
				dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.app.backup OVERWRITE)
			endif()
		endif()
	endif()
	
	###################### BACKUP USERDATA ###############################
	# Backup files and folders excluded from the package
	#	dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER OVERWRITE)
	# Remove excluded files and folders before packaging
	#	file(REMOVE ${DKPROJECT}/assets/USER)
	# Restore the backed up files, excluded from assets
	#	dk_copy(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/)
	#	file(REMOVE ${DKPROJECT}/Backup)
	
	########################## ICONS ###############################
	if(EXISTS ${DKPROJECT}/icons/icon.png)
		dk_resizeImage(${DKPROJECT}/icons/icon.png 16 16 ${DKPROJECT}/icons/ios/icons.iconset/icon_16x16.png)
		dk_resizeImage(${DKPROJECT}/icons/icon.png 32 32 ${DKPROJECT}/icons/ios/icons.iconset/icon_16x16@2x.png)
		dk_resizeImage(${DKPROJECT}/icons/icon.png 32 32 ${DKPROJECT}/icons/ios/icons.iconset/icon_32x32.png)
		dk_resizeImage(${DKPROJECT}/icons/icon.png 64 64 ${DKPROJECT}/icons/ios/icons.iconset/icon_32x32@2x.png)
		dk_resizeImage(${DKPROJECT}/icons/icon.png 128 128 ${DKPROJECT}/icons/ios/icons.iconset/icon_128x128.png)
		dk_resizeImage(${DKPROJECT}/icons/icon.png 256 256 ${DKPROJECT}/icons/ios/icons.iconset/icon_128x128@2x.png)
		dk_resizeImage(${DKPROJECT}/icons/icon.png 256 256 ${DKPROJECT}/icons/ios/icons.iconset/icon_256x256.png)
		dk_resizeImage(${DKPROJECT}/icons/icon.png 512 512 ${DKPROJECT}/icons/ios/icons.iconset/icon_256x256@2x.png)
		dk_resizeImage(${DKPROJECT}/icons/icon.png 512 512 ${DKPROJECT}/icons/ios/icons.iconset/icon_512x512.png)
		dk_resizeImage(${DKPROJECT}/icons/icon.png 1024 1024 ${DKPROJECT}/icons/ios/icons.iconset/icon_512x512@2x.png)

		dk_executeProcess(iconutil -c icns -o ${DKPROJECT}/icons/ios/icons.icns ${DKPROJECT}/icons/ios/icons.iconset)
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
	
	###################### Disable bitcode ############################
	set_target_properties(${APP_NAME} PROPERTIES XCODE_ATTRIBUTE_ENABLE_BITCODE "NO")
	
	###################### Add Assets to Bundle #######################
	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${DKPROJECT}/assets $<TARGET_FILE_DIR:${APP_NAME}>/assets)
	#if(EXISTS ${DKPROJECT}/icons/mac/icons.icns)
	#	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${DKPROJECT}/icons/ios/icons.icns $<TARGET_FILE_DIR:${APP_NAME}>/Resources/icons.icns)
	#endif()
	
	############# Link Libraries, Set Startup Project #################
	target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY XCODE_STARTUP_PROJECT ${APP_NAME})
	
	################### Create Run.sh #################################
	if(IOSSIM)
		dk_info("Creating Run.sh . . .")
		if(DEBUG)
			set(RUN_SCRIPT_DEBUG
				"\#!/bin/bash\n"
				"open -a Simulator.app\n"
				"xcrun simctl install booted ${DKPROJECT}/iossim64/Debug-iphonesimulator/${APP_NAME}.app\n"
				"xcrun simctl launch --console-pty booted com.digitalknob.${APP_NAME}"
			)
			file(WRITE ${DKPROJECT}/iossim64/Debug-iphonesimulator/Run.sh ${RUN_SCRIPT_DEBUG})
			dk_executeProcess(chmod 777 ${DKPROJECT}/iossim64/Debug-iphonesimulator/Run.sh)
		endif()
		if(RELEASE)
			set(RUN_SCRIPT_RELEASE
				"\#!/bin/bash\n"
				"open -a Simulator.app\n"
				"xcrun simctl install booted ${DKPROJECT}/iossim64/Release-iphonesimulator/${APP_NAME}.app\n"
				"xcrun simctl launch --console-pty booted com.digitalknob.${APP_NAME}"
			)
			file(WRITE ${DKPROJECT}/iossim64/Release-iphonesimulator/Run.sh ${RUN_SCRIPT_RELEASE})
			dk_executeProcess(chmod 777 ${DKPROJECT}/iossim64/Release-iphonesimulator/Run.sh)
		endif()
	endif()
	
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${APP_NAME}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
endif()



#########
if(LINUX)
if(NOT RASPBERRY)
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			dk_copy(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup OVERWRITE NOERROR)
		elseif(RELEASE)
			dk_copy(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup OVERWRITE NOERROR)
		endif()
	endif()
	
	########################## CREATE ICONS ###############################
	dk_copy(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png OVERWRITE)
	
	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
		dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER OVERWRITE)
		file(REMOVE ${DKPROJECT}/assets/USER)
		# Remove excluded files and folders before packaging
		dk_info("Creating assets.zip . . .")
		dk_zip(${DKPROJECT}/assets)
		#dk_info("Creating assets.h . . .")
		bin2h(SOURCE_FILE ${DKPROJECT}/assets.zip HEADER_FILE ${DKPROJECT}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		dk_copy(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/)
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
		if(NOT TINYCORE)
			dk_executeProcess(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DKPROJECT}/${OS}/Release/${APP_NAME}.desktop WORKING_DIRECTORY ${DKPROJECT}/${OS}/Release)
		endif()
	endif()
	
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${APP_NAME}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	#CPP_DK_Execute("chmod +x "+app_path+OS+"/Debug/"+APP)
endif()
endif()



#############
if(RASPBERRY)
	########################## CREATE ICONS ###############################
	dk_copy(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png OVERWRITE)

	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
		dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER OVERWRITE)
		# Remove excluded files and folders before packaging
		file(REMOVE ${DKPROJECT}/assets/USER)
		dk_info("Creating assets.zip . . .")
		dk_zip(${DKPROJECT}/assets)
		#dk_info("Creating assets.h . . .")
		bin2h(SOURCE_FILE ${DKPROJECT}/assets.zip HEADER_FILE ${DKPROJECT}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		dk_copy(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/)
		file(REMOVE ${DKPROJECT}/Backup)
	endif()
	
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.backup OVERWRITE NOERROR)
		elseif(RELEASE)
			dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME} ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.backup OVERWRITE NOERROR)
		endif()
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
	#add_custom_command(
	#	TARGET ${APP_NAME}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	#CPP_DK_Execute("chmod +x "+app_path+OS+"/Debug/"+APP)
endif()

###########
if(ANDROID)
	
	################################ CMAKE_ANDROID_GUI ########################################
	#set(CMAKE_ANDROID_GUI 1)
	# CMAKE_ANDROID_GUI is set to 1 by DKSDLWindow/DKCMake.cmake
	
	if(CMAKE_ANDROID_GUI)
		########################## CREATE ICONS ###############################
		dk_info("Creating android icons for ${APP_NAME} . . .")
		if(DEBUG)
			dk_resizeImage(${DKPROJECT}/icons/icon.png 36 36 ${DKPROJECT}/${OS}/Debug/app/src/main/res/mipmap-ldpi/ic_launcher.png)
			dk_resizeImage(${DKPROJECT}/icons/icon.png 48 48 ${DKPROJECT}/${OS}/Debug/app/src/main/res/mipmap-mdpi/ic_launcher.png)
			dk_resizeImage(${DKPROJECT}/icons/icon.png 72 72 ${DKPROJECT}/${OS}/Debug/app/src/main/res/mipmap-hdpi/ic_launcher.png)
			dk_resizeImage(${DKPROJECT}/icons/icon.png 96 96 ${DKPROJECT}/${OS}/Debug/app/src/main/res/mipmap-xhdpi/ic_launcher.png)
			dk_resizeImage(${DKPROJECT}/icons/icon.png 144 144 ${DKPROJECT}/${OS}/Debug/app/src/main/res/mipmap-xxhdpi/ic_launcher.png)
			dk_resizeImage(${DKPROJECT}/icons/icon.png 192 192 ${DKPROJECT}/${OS}/Debug/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png)
		endif()
		if(RELEASE)
			dk_resizeImage(${DKPROJECT}/icons/icon.png 36 36 ${DKPROJECT}/${OS}/Release/app/src/main/res/mipmap-ldpi/ic_launcher.png)
			dk_resizeImage(${DKPROJECT}/icons/icon.png 48 48 ${DKPROJECT}/${OS}/Release/app/src/main/res/mipmap-mdpi/ic_launcher.png)
			dk_resizeImage(${DKPROJECT}/icons/icon.png 72 72 ${DKPROJECT}/${OS}/Release/app/src/main/res/mipmap-hdpi/ic_launcher.png)
			dk_resizeImage(${DKPROJECT}/icons/icon.png 96 96 ${DKPROJECT}/${OS}/Release/app/src/main/res/mipmap-xhdpi/ic_launcher.png)
			dk_resizeImage(${DKPROJECT}/icons/icon.png 144 144 ${DKPROJECT}/${OS}/Release/app/src/main/res/mipmap-xxhdpi/ic_launcher.png)
			dk_resizeImage(${DKPROJECT}/icons/icon.png 192 192 ${DKPROJECT}/${OS}/Release/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png)
		endif()
	
		dk_copy(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png OVERWRITE)
	
		###################### Backup Executable ###########################
		if(BACKUP_APP_EXECUTABLES)
			if(MULTI_CONFIG)
				DEBUG_dk_rename(${DKPROJECT}/${OS}/app/build/outputs/apk/debug/app-debug.apk ${DKPROJECT}/${OS}/app/build/outputs/apk/app-debug.apk.backup OVERWRITE NOERROR)
				RELEASE_dk_rename(${DKPROJECT}/${OS}/app/build/outputs/apk/release/app-release-unsigned.apk ${DKPROJECT}/${OS}/app/build/outputs/apk/release/app-release-unsigned.apk.backup OVERWRITE NOERROR)
			else()
				DEBUG_dk_rename(${DKPROJECT}/${OS}/Debug/app/build/outputs/apk/debug/app-debug.apk ${DKPROJECT}/${OS}/Debug/app/build/outputs/apk/app-debug.apk.backup OVERWRITE NOERROR)
				RELEASE_dk_rename(${DKPROJECT}/${OS}/Release/app/build/outputs/apk/release/app-release-unsigned.apk ${DKPROJECT}/${OS}/Release/app/build/outputs/apk/release/app-release-unsigned.apk.backup OVERWRITE NOERROR)
			endif()
		endif()
	
		####################### Create Library Target ###################
		#if(MSVC)
			set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/app/src/main/jniLibs/${ANDROID_ABI}")
			set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/app/src/main/jniLibs/${ANDROID_ABI}")
		#else()
		#	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/Debug/app/src/main/jniLibs/${ANDROID_ABI}")
		#	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/Release/app/src/main/jniLibs/${ANDROID_ABI}")
		#endif()
	
		######## Create local.properties file that points to android-sdk path #############
		set(localProperties "sdk.dir=${ANDROID_SDK}")
	
		####### Import Android Gui Build files ############################################
		if(DEBUG)
			dk_copy(${DKPLUGINS}/_DKIMPORT/android/ ${DKPROJECT}/${OS}/Debug)
			dk_copy(${DKPLUGINS}/_DKIMPORT/${OS}/ ${DKPROJECT}/${OS}/Debug)
			dk_copy(${DKPROJECT}/assets ${DKPROJECT}/${OS}/Debug/app/src/main/assets OVERWRITE)
			file(WRITE ${DKPROJECT}/${OS}/Debug/local.properties ${localProperties})
			dk_fileReplace(${DKPROJECT}/${OS}/Debug/app/src/main/res/values/strings.xml "_DKIMPORT" "${APP_NAME}" NOERROR)
			UNIX_HOST_dk_executeProcess(chmod 777 ${DKPROJECT}/${OS}/Debug/gradlew)
			UNIX_HOST_dk_executeProcess(sed -i -e "s/\r$//" "${DKPROJECT}/${OS}/Debug/gradlew")
		endif()
		if(RELEASE)
			dk_copy(${DKPLUGINS}/_DKIMPORT/android/ ${DKPROJECT}/${OS}/Release)
			dk_copy(${DKPLUGINS}/_DKIMPORT/${OS}/ ${DKPROJECT}/${OS}/Release)
			dk_copy(${DKPROJECT}/assets ${DKPROJECT}/${OS}/Release/app/src/main/assets OVERWRITE)
			file(WRITE ${DKPROJECT}/${OS}/Release/local.properties ${localProperties})
			dk_fileReplace(${DKPROJECT}/${OS}/Release/app/src/main/res/values/strings.xml "_DKIMPORT" "${APP_NAME}" NOERROR)
			UNIX_HOST_dk_executeProcess(chmod 777 ${DKPROJECT}/${OS}/Release/gradlew)
			UNIX_HOST_dk_executeProcess(sed -i -e "s/\r$//" "${DKPROJECT}/${OS}/Release/gradlew")
		endif()

		####### Append -frtti to C/CXX Flags ##############################
		#dk_set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} -frtti)
		#dk_set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -frtti)
		
		# https://stackoverflow.com/a/53806411/688352
		#set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS_RELEASE} -Wl,--hash-style=both")
		#set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS_RELEASE} -Wl,--hash-style=both")
		#set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS_RELEASE} -Wl,--hash-style=both")
		
		add_library(main SHARED ${App_SRC})
	else() 
		
		################################## !CMAKE_ANDROID_GUI ########################################
		add_executable(main ${App_SRC})
		
	endif()
		
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(main ${plugin})
		endif()	
	endforeach()
	
	######################### Link Libraries ###########################
	#target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	#target_include_directories(${APP_NAME} PUBLIC ${SDL2}/include)
	
	#if(MSVC)
	#	target_link_libraries(main ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	#else()
		if(DEBUG)
			target_link_libraries(main ${DEBUG_LIBS} ${LIBS})
		endif()
		if(RELEASE)
			target_link_libraries(main ${RELEASE_LIBS} ${LIBS})
		endif()
	#endif()
	target_include_directories(main PUBLIC ${SDL2}/include) # FIXME: this should be in sdl/DKMake.cmake somehow
	
	if(CMAKE_ANDROID_GUI)
		if(VISUAL_STUDIO)
			include_external_msproject(gradleAPK gradleAPK.androidproj TYPE 39E2626F-3545-4960-A6E8-258AD8476CE5)
			set_property(TARGET gradleAPK PROPERTY VS_SOLUTION_DEPLOY ON) # NOT WORKING
			set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT gradleAPK)
		endif()
	endif()
		
		
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET main
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:main>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:main>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	
	####################### Gradle Build #####################
	if(CMAKE_ANDROID_GUI)
		if(DEBUG)
			add_custom_command(
				POST_BUILD
				TARGET main
				COMMAND ${CMAKE_COMMAND} -E echo "Building with Gradle"
				COMMAND ${DKPROJECT}/${OS}/Debug/gradlew --project-dir ${DKPROJECT}/${OS}/Debug --info clean build #--offline
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished building with Gradle")
		endif()
		if(RELEASE)
			add_custom_command(
				POST_BUILD
				TARGET main
				COMMAND ${CMAKE_COMMAND} -E echo "Building with Gradle"
				COMMAND ${DKPROJECT}/${OS}/Release/gradlew --project-dir ${DKPROJECT}/${OS}/Release --info clean build #--offline
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished building with Gradle")
		endif()
	endif()
		
	#################### List packages ####################################
	#################### List packages matching PACKAGE_NAME ##############
	#################### Uninstall PACKAGE_NAME package ###################
		
	#################### Install apk to device ################
	#dk_set(INSTALL_APK 1)
	if(NOT ANDROID_HOST AND INSTALL_APK)
		if(WIN_HOST)
			set(CMD "cmd /c")
		endif()
		
		if(DEBUG)		
			add_custom_command(
				POST_BUILD
				TARGET main
				COMMAND ${CMAKE_COMMAND} -E echo "Installing <app-debug.apk> to device"
				COMMAND ${CMD} ${ANDROID_SDK}/platform-tools/adb install -r ${DKPROJECT}/${OS}/Debug/app/build/outputs/apk/debug/app-debug.apk
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished installing <app-debug.apk> to device")
		if(RELEASE)
		endif()
			add_custom_command(
				POST_BUILD
				TARGET main
				COMMAND ${CMAKE_COMMAND} -E echo "Installing <app-release-unsigned.apk> to device"
				COMMAND ${CMD} ${ANDROID_SDK}/platform-tools/adb install -r ${DKPROJECT}/${OS}/Release/app/build/outputs/apk/release/app-release-unsigned.apk
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished installing <app-release-unsigned.apk> to device")
		endif()
	endif()
	
endif()


# TODO: https://schellcode.github.io/webassembly-without-emscripten
##############
if(EMSCRIPTEN)
	########################## CREATE ICONS ###############################
	dk_copy(${DKPROJECT}/icons/icon.png ${DKPROJECT}/assets/icon.png OVERWRITE)

	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
		dk_copy(${DKPROJECT}/assets/USER ${DKPROJECT}/Backup/USER OVERWRITE NOERROR)
		# Remove excluded files and folders before packaging
		file(REMOVE ${DKPROJECT}/assets/USER)
		dk_info("Creating assets.zip . . .")
		dk_zip(${DKPROJECT}/assets)
		#dk_info("Creating assets.h . . .")
		bin2h(SOURCE_FILE ${DKPROJECT}/assets.zip HEADER_FILE ${DKPROJECT}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		dk_copy(${DKPROJECT}/Backup/ ${DKPROJECT}/assets/)
		file(REMOVE ${DKPROJECT}/Backup)
	endif()
	
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.data ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.data.backup OVERWRITE)
			dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.html ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.html.backup OVERWRITE)
			dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.js ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.js.backup OVERWRITE)
			dk_rename(${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.wasm ${DKPROJECT}/${OS}/${DEBUG_DIR}/${APP_NAME}.wasm.backup OVERWRITE)
		elseif(RELEASE)
			dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.data ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.data.backup OVERWRITE)
			dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.html ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.html.backup OVERWRITE)
			dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.js ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.js.backup OVERWRITE)
			dk_rename(${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.wasm ${DKPROJECT}/${OS}/${RELEASE_DIR}/${APP_NAME}.wasm.backup OVERWRITE)
		endif()
	endif()
	
	####################### Create Executable Target ###################
	add_executable(${APP_NAME} ${App_SRC})
	if(DEBUG)
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${LIBS})
	elseif(RELEASE)
		target_link_libraries(${APP_NAME} ${RELEASE_LIBS} ${LIBS})
	endif()
	set(CMAKE_EXECUTABLE_SUFFIX ".html")
	
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()

	########## Remove previous built files from assets #################
	dk_remove(${DKPROJECT}/assets/${APP_NAME}.data NOERROR)
	dk_remove(${DKPROJECT}/assets/${APP_NAME}.html NOERROR)
	dk_remove(${DKPROJECT}/assets/${APP_NAME}.js NOERROR)
	dk_remove(${DKPROJECT}/assets/${APP_NAME}.wasm NOERROR)

	########################## PACKAGE ASSETS ##########################
	set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS "-sASSERTIONS -sALLOW_MEMORY_GROWTH --preload-file ${DKPROJECT}/assets@/")
	
	################### Create Run.sh #################################
	dk_info("Creating Run scripts . . .")
	if(DEBUG)
		if(WIN_HOST)
			set(RUN_SCRIPT_DEBUG
				"${3RDPARTY}/emsdk-main/upstream/emscripten/emrun ${DKPROJECT}/emscripten/Debug/${APP_NAME}.html"
			)
			file(WRITE ${DKPROJECT}/emscripten/Debug/Run.bat ${RUN_SCRIPT_DEBUG})
		else()
			set(RUN_SCRIPT_DEBUG
				"\#!/bin/bash\n"
				"${3RDPARTY}/emsdk-main/upstream/emscripten/emrun ${DKPROJECT}/emscripten/Debug/${APP_NAME}.html"
			)
			file(WRITE ${DKPROJECT}/emscripten/Debug/Run.sh ${RUN_SCRIPT_DEBUG})
			dk_executeProcess(chmod 777 ${DKPROJECT}/emscripten/Debug/Run.sh)
		endif()
	endif()
	if(RELEASE)
		if(WIN_HOST)
			set(RUN_SCRIPT_RELEASE
				"${3RDPARTY}/emsdk-main/upstream/emscripten/emrun ${DKPROJECT}/emscripten/Release/${APP_NAME}.html"
			)
			file(WRITE ${DKPROJECT}/emscripten/Release/Run.bat ${RUN_SCRIPT_RELEASE})
		else()
			set(RUN_SCRIPT_RELEASE
				"\#!/bin/bash\n"
				"${3RDPARTY}/emsdk-main/upstream/emscripten/emrun ${DKPROJECT}/emscripten/Release/${APP_NAME}.html"
			)
			file(WRITE ${DKPROJECT}/emscripten/Release/Run.sh ${RUN_SCRIPT_RELEASE})
			dk_executeProcess(chmod 777 ${DKPROJECT}/emscripten/Release/Run.sh)
		endif()
	endif()

	
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${APP_NAME}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:APP_NAME = $<TARGET_FILE:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:APP_NAME = $<TARGET_FILE_DIR:${APP_NAME}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	
	###################### Copy WASM files to /assets #################
	#if(DEBUG)
	#	add_custom_command(
	#		TARGET ${APP_NAME} 
	#		POST_BUILD
	#		COMMAND ${CMAKE_COMMAND} -E echo "Copying ${APP_NAME} Debug wasm files to /assets"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DKPROJECT}/emscripten/Debug/${APP_NAME}.data" "${DKPROJECT}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DKPROJECT}/emscripten/Debug/${APP_NAME}.html" "${DKPROJECT}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DKPROJECT}/emscripten/Debug/${APP_NAME}.js" "${DKPROJECT}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DKPROJECT}/emscripten/Debug/${APP_NAME}.wasm" "${DKPROJECT}/assets/")
	#else()
	#	add_custom_command(
	#		TARGET ${APP_NAME} 
	#		POST_BUILD
	#		COMMAND ${CMAKE_COMMAND} -E echo "Copying ${APP_NAME} Release wasm files to /assets"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DKPROJECT}/emscripten/Release/${APP_NAME}.data" "${DKPROJECT}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DKPROJECT}/emscripten/Release/${APP_NAME}.html" "${DKPROJECT}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DKPROJECT}/emscripten/Release/${APP_NAME}.js" "${DKPROJECT}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DKPROJECT}/emscripten/Release/${APP_NAME}.wasm" "${DKPROJECT}/assets/")
	#endif()
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
dk_buildLog("\n")
dk_buildLog(" ### Disabled libraries ###")
foreach(lib ${DISABLED_LIBS})
		dk_buildLog(${lib})
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
