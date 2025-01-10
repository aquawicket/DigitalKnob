#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
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
dk_assertPath("${DKCMAKE_DIR}/DKDisabled.cmake")
dk_load("${DKCMAKE_DIR}/DKDisabled.cmake")

dk_info("\n")
dk_info("############################################################")
dk_info("######################  DigitalKnob  #######################")
dk_info("############################################################")
dk_info("\n")

dk_validate(DK_Project_Dir "dk_target_triple()")
dk_assertPath(${DK_Project_Dir})
dk_basename(${DK_Project_Dir} APP_NAME)
dk_replaceAll(${APP_NAME} " " "_" APP_NAME)
set(APP_NAME ${APP_NAME}_APP)

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
dk_load(${DK_Project_Dir}/DKMAKE.cmake)
dk_assertVar(triple)
dk_delete(${DK_Project_Dir}/${triple}/DKBUILD.log NO_HALT)
dk_printSettings()

dk_buildLog("##############################################")
dk_buildLog("######  Enabled Dependencies (sorted)  #######")
dk_buildLog("##############################################")
#dk_printVar(dkdepend_list)
list(REMOVE_DUPLICATES dkdepend_list)
foreach(plugin ${dkdepend_list})
	if(NOT plugin IN_LIST dk_disabled_list)
		dk_buildLog("${plugin}")
	endif()
endforeach()
dk_buildLog("\n")

foreach(plugin ${dkdepend_list})
	dk_set(QUEUE_BUILD 0)
	dk_set(PREBUILD 0)
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
	#dk_printVar(plugin_path)

	# This executes the 3rdParty library builds, and creates CMakeLists.txt files for DKPlugins
	dk_info("dk_depend(${plugin})")
	dk_depend(${plugin})
	
	#check that each library is using the proper variables. Should be UPPERCASE plugin name.   I.E. boost = ${BOOST}
	if(NOT ${plugin})
		if(plugin IN_LIST dk_disabled_list)
			dk_notice("plugin:${plugin} disabled, skipping...")
			continue()
		endif()
		dk_fatal("${plugin} variable is invalid")
	endif()
	
	#NOTE: we won't have the library paths to remove until we've run DKCMake.cmake for the library
	# We can use this to refresh 3rdParty Plugins
	#if(REBUILDALL)
		#foreach(lib ${LIBLIST})
		#	dk_delete(${lib})
		#	dk_info("######  Removed ${lib}")
		#endforeach()
	#endif()
	
	# ADD THE 3rdParty library TO THE APP SOLUTION
	if(PROJECT_INCLUDE_3RDPARTY)
		dk_toUpper(${plugin} PLUGIN_NAME)
		if(EXISTS "${${PLUGIN_NAME}}/CMakeLists.txt")
			#if(MULTI_CONFIG)
			#	add_subdirectory(${${PLUGIN_NAME}} ${${PLUGIN_NAME}}/${triple})
			#else()
			#	if(DEBUG)
			#		add_subdirectory(${plugin_path} ${plugin_path}/${triple}/Debug)
			#	elseif(RELEASE)
			#		add_subdirectory(${plugin_path} ${plugin_path}/${triple}/Release)
			#	endif()
			#endif()
			dk_debug("adding ${${PLUGIN_NAME}}")
			add_subdirectory(${${PLUGIN_NAME}} ${${PLUGIN_NAME}}/${CONFIG_PATH})
		endif()
	endif(PROJECT_INCLUDE_3RDPARTY)
	
	#install(TARGETS <target_name> DESTINATION ${DIGITALKNOB_DIR}/DKInstall/lib/${triple})
	#install(FILES file.h DESTINATION ${DIGITALKNOB_DIR}/DKInstall/lib/${triple})
	
	####################### DKPlugins #######################
	# Libraries in the /DKPlugins folder
	dk_toLower("${DKPLUGIN_LIST}" DKPLUGIN_LIST_lower)
	dk_toLower("${plugin}" plugin_lower)
	string(FIND "${DKPLUGIN_LIST_lower}" "${plugin_lower}" isDKPlugin)
	
	# Install 3rd Party Libs
	if(INSTALL_DKLIBS)
		if(${isDKPlugin} EQUAL -1)
			if(EXISTS ${plugin_path}/${CONFIG_PATH}/cmake_install.cmake)
				dk_queueCommand(${CMAKE_COMMAND} --install ${plugin_path}/${CONFIG_PATH})
			endif()
		endif()
	endif(INSTALL_DKLIBS)
	
	if(${isDKPlugin} GREATER -1)
		# Install header files for DKPlugin
		if(INSTALL_DKLIBS)
			dk_info("Installing ${plugin} header files")
			file(INSTALL DIRECTORY ${plugin_path}/ DESTINATION ${CMAKE_INSTALL_PREFIX}/include/${plugin} FILES_MATCHING PATTERN "*.h")
			dk_deleteEmptyDirectories(${CMAKE_INSTALL_PREFIX}/include/${plugin})
		endif()
		
		#Add the DKPlugin to the app project
		if(PROJECT_INCLUDE_DKPLUGINS)
			if(EXISTS "${plugin_path}/CMakeLists.txt")
				#if(MULTI_CONFIG)
				#	add_subdirectory(${plugin_path} ${plugin_path}/${triple})
				#else()
				#	if(DEBUG)
				#		add_subdirectory(${plugin_path} ${plugin_path}/${triple}/Debug)
				#	elseif(RELEASE)
				#		add_subdirectory(${plugin_path} ${plugin_path}/${triple}/Release)
				#	endif()
				#endif()
				add_subdirectory(${plugin_path} ${plugin_path}/${CONFIG_PATH})
			endif()
		endif()
		
		## Prebuild DKPlugins prior to app
		if(NOT PROJECT_INCLUDE_DKPLUGINS)
			dk_set(PREBUILD ON) ## Always prebuild all DKPlugins
			
			foreach(lib ${LIBLIST})
				if(NOT EXISTS ${lib})
					dk_warning("MISSING: ${lib}")
					dk_set(PREBUILD ON)	## Only prebuild if the library binaries are missing
				else()
					dk_success("FOUND: ${lib}")
				endif()
			endforeach()
		
			if(PREBUILD)
				dk_set(QUEUE_BUILD ON)
				dk_info("************* Building ${plugin} *************")
				dk_cd(${plugin_path}/${CONFIG_PATH})
				
				if(MULTI_CONFIG)
					###### Configure ######
					ANDROID_ARM32_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM32=ON 	${plugin_path})
					ANDROID_ARM64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM64=ON 	${plugin_path})
					ANDROID_X86_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_X86=ON 	${plugin_path})
					ANDROID_X86_64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_X86_64=ON 	${plugin_path})
					EMSCRIPTEN_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DEMSCRIPTEN=ON 		${plugin_path})
					IOS_ARM32_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOS_ARM32=ON 		${plugin_path})
					IOS_ARM64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOS_ARM64=ON 		${plugin_path})
					IOSSIM_X86_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86=ON 		${plugin_path})
					IOSSIM_X86_64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86_64=ON 	${plugin_path})
					LINUX_X86_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DLINUX_X86=ON 		${plugin_path})
					LINUX_X86_64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DLINUX_X86_64=ON 	${plugin_path})
					MAC_X86_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DMAC_X86=ON 		${plugin_path})
					MAC_X86_64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DMAC_X86_64=ON 		${plugin_path})
					RASPBERRY_ARM32_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM32=ON ${plugin_path})
					RASPBERRY_ARM64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM64=ON ${plugin_path})
					WIN_X86_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DWIN_X86=ON 		${plugin_path})
					WIN_X86_64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DWIN_X86_64=ON 		${plugin_path})
					
					###### Build ######
					DEBUG_dk_queueCommand			(${CMAKE_COMMAND} --build . --config Debug)
					RELEASE_dk_queueCommand			(${CMAKE_COMMAND} --build . --config Release)
				else()
					if(DEBUG)
						###### Configure ######
						ANDROID_ARM32_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_ARM32=ON 	${plugin_path})
						ANDROID_ARM64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_ARM64=ON 	${plugin_path})
						ANDROID_X86_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_X86=ON 		${plugin_path})
						ANDROID_X86_64_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_X86_64=ON 	${plugin_path})
						EMSCRIPTEN_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DEMSCRIPTEN=ON 		${plugin_path})
						IOS_ARM32_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOS_ARM32=ON 		${plugin_path})
						IOS_ARM64_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOS_ARM64=ON 		${plugin_path})
						IOSSIM_X86_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOSSIM_X86=ON 		${plugin_path})
						IOSSIM_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOSSIM_X86_64=ON 	${plugin_path})
						LINUX_X86_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DLINUX_X86=ON 		${plugin_path})
						LINUX_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DLINUX_X86_64=ON 	${plugin_path})
						MAC_X86_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DMAC_X86=ON 			${plugin_path})
						MAC_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DMAC_X86_64=ON 		${plugin_path})
						RASPBERRY_ARM32_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DRASPBERRY_ARM32=ON 	${plugin_path})
						RASPBERRY_ARM64_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DRASPBERRY_ARM64=ON 	${plugin_path})
						WIN_X86_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DWIN_X86=ON 			${plugin_path})
						WIN_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DWIN_X86_64=ON 		${plugin_path})
						
						###### Build ######
						DEBUG_dk_queueCommand					(${CMAKE_COMMAND} --build . --config Debug)
						
					elseif(RELEASE)
						###### Configure ######
						ANDROID_ARM32_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM32=ON 		${plugin_path})
						ANDROID_ARM64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM64=ON 		${plugin_path})
						ANDROID_X86_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_X86=ON 		${plugin_path})
						ANDROID_X86_64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_X86_64=ON 	${plugin_path})
						EMSCRIPTEN_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DEMSCRIPTEN=ON 		${plugin_path})
						IOS_ARM32_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOS_ARM32=ON 			${plugin_path})
						IOS_ARM64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOS_ARM64=ON 			${plugin_path})
						IOSSIM_X86_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86=ON 		${plugin_path})
						IOSSIM_X86_64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86_64=ON 		${plugin_path})
						LINUX_X86_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DLINUX_X86=ON 			${plugin_path})
						LINUX_X86_64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DLINUX_X86_64=ON 		${plugin_path})
						MAC_X86_RELEASE_dk_queueCommand			(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DMAC_X86=ON 			${plugin_path})
						MAC_X86_64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DMAC_X86_64=ON 		${plugin_path})
						RASPBERRY_ARM32_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM32=ON 	${plugin_path})
						RASPBERRY_ARM64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM64=ON 	${plugin_path})
						WIN_X86_RELEASE_dk_queueCommand			(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DWIN_X86=ON 			${plugin_path})
						WIN_X86_64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DWIN_X86_64=ON 		${plugin_path})
						
						###### Build ######
						RELEASE_dk_queueCommand					(${CMAKE_COMMAND} --build . --config Release)
					endif()
				endif()

				## double check that the missing libs were built
				foreach(lib ${LIBLIST})
					if(NOT EXISTS ${lib})
						dk_fatal("\n\n\n****************************\nFAILED to find: ${lib} \n****************************")
					else()
						# Install DKPlugin Libs
						if(INSTALL_DKLIBS)
							if(EXISTS ${plugin_path}/${CONFIG_PATH}/cmake_install.cmake)
								dk_queueCommand(${CMAKE_COMMAND} --install ${plugin_path}/${CONFIG_PATH})
							endif()
						endif()
					endif()
				endforeach()

			endif(PREBUILD)
		endif(NOT PROJECT_INCLUDE_DKPLUGINS) # NOT PROJECT_INCLUDE_DKPLUGINS)	
	else()
	
		foreach(lib ${LIBLIST})
			if(NOT EXISTS ${lib})
				dk_fatal("\n\n\n****************************\nFAILED to find: ${lib} \n***********************************")
			else()	
				# Install DKPlugin Libs
				if(INSTALL_DKLIBS)
					if(EXISTS ${plugin_path}/${CONFIG_PATH}/cmake_install.cmake)
						dk_queueCommand(${CMAKE_COMMAND} --install ${plugin_path}/${CONFIG_PATH})
					endif()
				endif()
			endif()
		endforeach()
	endif(${isDKPlugin} GREATER -1) # isDKPlugin
	
endforeach()

if(INSTALL_DKLIBS)
	# clean up empty directories
	dk_deleteEmptyDirectories(${CMAKE_INSTALL_PREFIX}/include)
endif()
		
if(NOT DKAPP)
	return()
endif()	

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
	dk_fileWrite("${DK_Project_Dir}/DKPlugins.h" "${PLUGINS_FILE}")
endif()

if(HAVE_DK)
	## copy app default files without overwrite
	dk_info("Copying DKPlugins/_DKIMPORT/ to App...")
	dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/icons ${DK_Project_Dir}/icons) 
	dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/assets.h ${DK_Project_Dir}/assets.h)
	dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/main.cpp ${DK_Project_Dir}/main.cpp)
endif()

# Copy VSCode project files to app
dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/DKApp.code-workspace ${DK_Project_Dir}/DKApp.code-workspace)
dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/.vscode ${DK_Project_Dir}/.vscode)
	
### Include all source files from the app folder for the compilers
#file(GLOB_RECURSE App_SRC
file(GLOB App_SRC
	${DK_Project_Dir}/*.h
	${DK_Project_Dir}/*.c
	${DK_Project_Dir}/*.hpp
	${DK_Project_Dir}/*.cpp)
list(FILTER App_SRC EXCLUDE REGEX "${DK_Project_Dir}/assets/*")
list(FILTER App_SRC EXCLUDE REGEX "${DK_Project_Dir}/${triple}/*")
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
include_directories(${DK_Project_Dir})
include_directories(${DKPLUGINS_DIR})


###########
if(ANDROID)
	################################ CMAKE_ANDROID_GUI ########################################
	if(CMAKE_ANDROID_GUI) # CMAKE_ANDROID_GUI is set to 1 by DKSDLWindow/DKCMake.cmake
		########################## CREATE ICONS ###############################
		if(EXISTS "${DK_Project_Dir}/icons/icon.png")
			dk_createIcons("${DK_Project_Dir}/icons/icon.png")
		endif()
		#if(EXISTS ${DK_Project_Dir}/icons/icon.png)
		#	dk_copy(${DK_Project_Dir}/icons/icon.png ${DK_Project_Dir}/assets/icon.png OVERWRITE)
		#endif()
	
		###################### Backup Executable ###########################
		if(BACKUP_APP_EXECUTABLES)
			if(MULTI_CONFIG)
				if(DEBUG)
					dk_rename(${DK_Project_Dir}/${triple}/app/build/outputs/apk/debug/app-debug.apk ${DK_Project_Dir}/${triple}/app/build/outputs/apk/app-debug.apk.backup OVERWRITE NO_HALT)
				endif()
				if(RELEASE)
					dk_rename(${DK_Project_Dir}/${triple}/app/build/outputs/apk/release/app-release-unsigned.apk ${DK_Project_Dir}/${triple}/app/build/outputs/apk/release/app-release-unsigned.apk.backup OVERWRITE NO_HALT)
				endif()
			else()
				if(DEBUG)
					dk_rename(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/app/build/outputs/apk/debug/app-debug.apk ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/app/build/outputs/apk/app-debug.apk.backup OVERWRITE NO_HALT)
				endif()
				if(RELEASE)
					dk_rename(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/app/build/outputs/apk/release/app-release-unsigned.apk ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/app/build/outputs/apk/release/app-release-unsigned.apk.backup OVERWRITE NO_HALT)
				endif()
			endif()
		endif()
	
		####################### Create Library Target ###################
		#if(MSVC)
			set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/app/src/main/jniLibs/${ANDROID_ABI}")
			set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/app/src/main/jniLibs/${ANDROID_ABI}")
		#else()
		#	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/${DEBUG_DIR}/app/src/main/jniLibs/${ANDROID_ABI}")
		#	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/${RELEASE_DIR}/app/src/main/jniLibs/${ANDROID_ABI}")
		#endif()
	
		######## Create local.properties file that points to android-sdk path #############
		set(localProperties "sdk.dir=${ANDROID_SDK}")
	
		####### Import Android Gui Build files ############################################
		if(DEBUG)
			dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/android/ ${DK_Project_Dir}/${triple}/Debug)
			if(EXISTS ${DKPLUGINS_DIR}/_DKIMPORT/${triple})
				dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/${triple}/ ${DK_Project_Dir}/${triple}/Debug)
			endif()
			dk_copy(${DK_Project_Dir}/assets ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/app/src/main/assets OVERWRITE)
			dk_fileWrite(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/local.properties ${localProperties})
			dk_fileReplace(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/app/src/main/res/values/strings.xml "_DKIMPORT" "${APP_NAME}" NO_HALT)
			if(UNIX_HOST)
				dk_executeProcess(chmod 777 ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/gradlew)
				dk_executeProcess(sed -i -e "s/\r$//" "${DK_Project_Dir}/${triple}/${DEBUG_DIR}/gradlew")
			endif()
			#TODO: set GRADLE_USER_HOME environment variable. Location of .gradle cache
		endif()
		if(RELEASE)
			dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/android/ ${DK_Project_Dir}/${triple}/Release)
			dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/${triple}/ ${DK_Project_Dir}/${triple}/Release)
			dk_copy(${DK_Project_Dir}/assets ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/app/src/main/assets OVERWRITE)
			dk_fileWrite(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/local.properties ${localProperties})
			dk_fileReplace(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/app/src/main/res/values/strings.xml "_DKIMPORT" "${APP_NAME}" NO_HALT)
			if(UNIX_HOST)
				dk_executeProcess(chmod 777 ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/gradlew)
				dk_executeProcess(sed -i -e "s/\r$//" "${DK_Project_Dir}/${triple}/${RELEASE_DIR}/gradlew")
			endif()
			#TODO: set GRADLE_USER_HOME environment variable. Location of .gradle cache
		endif()
		
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
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
			add_dependencies(main ${plugin})
		endif()	
	endforeach()
	
	######################### Link Libraries ###########################
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
		if(MSVC)
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
		#if(WIN_HOST)
		#	dk_command(${OPENJDK}/registerJDK.cmd)
		#endif()
		dk_depend(openjdk)
		dk_depend(gradle)
		
		if(WIN_HOST)
			set(setVar "set")
		else()
			set(setVar "export")
		endif()
	
		if(DEBUG)
			add_custom_command(
				TARGET main
				POST_BUILD
				COMMAND ${CMAKE_COMMAND} -E echo "Building with Gradle"
				COMMAND ${setVar} "JAVA_HOME=$ENV{JAVA_HOME}" & ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/gradlew${bat} --gradle-user-home ${GRADLE_USER_HOME} --project-dir ${DK_Project_Dir}/${triple}/Debug --info clean build #--offline
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished building with Gradle"
				WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
				VERBATIM)
		endif()
		if(RELEASE)
			add_custom_command(
				TARGET main
				POST_BUILD
				COMMAND ${CMAKE_COMMAND} -E echo "Building with Gradle"
				COMMAND ${setVar} "JAVA_HOME=$ENV{JAVA_HOME}" & ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/gradlew${bat} --gradle-user-home ${GRADLE_USER_HOME} --project-dir ${DK_Project_Dir}/${triple}/Release --info clean build #--offline
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished building with Gradle"
				WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
				VERBATIM)
		endif()
	endif()
		
	#################### List packages ####################################
	#################### List packages matching PACKAGE_NAME ##############
	#################### Uninstall PACKAGE_NAME package ###################
		
	#################### Install apk to device ################
	#dk_set(INSTALL_APK ON)
	if(NOT ANDROID_HOST AND INSTALL_APK)
		dk_depend(cmd)	
		if(DEBUG)		
			add_custom_command(
				POST_BUILD
				TARGET main
				COMMAND ${CMAKE_COMMAND} -E echo "Installing <app-debug.apk> to device"
				COMMAND ${CMD_EXE} ${ANDROID_SDK}/platform-tools/adb install -r ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/app/build/outputs/apk/debug/app-debug.apk
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished installing <app-debug.apk> to device")
		if(RELEASE)
		endif()
			add_custom_command(
				POST_BUILD
				TARGET main
				COMMAND ${CMAKE_COMMAND} -E echo "Installing <app-release-unsigned.apk> to device"
				COMMAND ${CMD_EXE} ${ANDROID_SDK}/platform-tools/adb install -r ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/app/build/outputs/apk/release/app-release-unsigned.apk
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished installing <app-release-unsigned.apk> to device")
		endif()
	endif()
endif(ANDROID)


#############
if(COSMOPOLITAN)
	####################### Create Executable Target ###################
	add_executable(${APP_NAME} ${App_SRC})
	
	########################### Add libraries ##########################
	if(DEBUG)
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${LIBS})
	elseif(RELEASE)
		target_link_libraries(${APP_NAME} ${RELEASE_LIBS} ${LIBS})
	endif()

	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
endif(COSMOPOLITAN)


##############
if(EMSCRIPTEN)
	# TODO: https://schellcode.github.io/webassembly-without-emscripten
	
	########################## CREATE ICONS ###############################
	if(EXISTS "${DK_Project_Dir}/icons/icon.png")
		dk_createIcons("${DK_Project_Dir}/icons/icon.png")
	endif()
	#if(EXISTS ${DK_Project_Dir}/icons/icon.png)
	#	dk_copy(${DK_Project_Dir}/icons/icon.png ${DK_Project_Dir}/assets/icon.png OVERWRITE)
	#endif()

	############### BACKUP USERDATA / inject assets #######################
	if(false)
		dk_copy(${DK_Project_Dir}/assets/USER ${DK_Project_Dir}/Backup/USER OVERWRITE NO_HALT)  # backup files not going in the package
		dk_delete(${DK_Project_Dir}/assets/USER)		# Remove excluded files and folders before packaging
		dk_info("Creating assets.zip . . .")
		dk_compressAssets(${DK_Project_Dir}/assets)
		#dk_info("Creating assets.h . . .")
		dk_bin2h(SOURCE_FILE ${DK_Project_Dir}/assets.zip HEADER_FILE ${DK_Project_Dir}/assets.h VARIABLE_NAME "ASSETS_H")
		dk_copy(${DK_Project_Dir}/Backup/ ${DK_Project_Dir}/assets/) # Restore the backed up assets
		dk_delete(${DK_Project_Dir}/Backup)
	endif()
	
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			dk_rename(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.data ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.data.backup OVERWRITE NO_HALT)
			dk_rename(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.html ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.html.backup OVERWRITE NO_HALT)
			dk_rename(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.js ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.js.backup OVERWRITE NO_HALT)
			dk_rename(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.wasm ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.wasm.backup OVERWRITE NO_HALT)
		elseif(RELEASE)
			dk_rename(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.data ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.data.backup OVERWRITE NO_HALT)
			dk_rename(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.html ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.html.backup OVERWRITE NO_HALT)
			dk_rename(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.js ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.js.backup OVERWRITE NO_HALT)
			dk_rename(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.wasm ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.wasm.backup OVERWRITE NO_HALT)
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
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()

	########## Remove previous built files from assets #################
	dk_delete(${DK_Project_Dir}/assets/${APP_NAME}.data NO_HALT)
	dk_delete(${DK_Project_Dir}/assets/${APP_NAME}.html NO_HALT)
	dk_delete(${DK_Project_Dir}/assets/${APP_NAME}.js NO_HALT)
	dk_delete(${DK_Project_Dir}/assets/${APP_NAME}.wasm NO_HALT)

	########################## PACKAGE ASSETS ##########################
	if(EXISTS ${DK_Project_Dir}/assets)
		set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS "-sASSERTIONS -sALLOW_MEMORY_GROWTH --preload-file ${DK_Project_Dir}/assets@/")
	endif()
	
	################### Create Run.sh #################################
	dk_info("Creating Run scripts . . .")
	if(DEBUG)
		if(WIN_HOST)
			set(RUN_SCRIPT_DEBUG
				"${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun.bat ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.html"
			)
			dk_fileWrite(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/Run.bat ${RUN_SCRIPT_DEBUG})
		else()
			set(RUN_SCRIPT_DEBUG
				"\#!/bin/bash\n${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.html"
			)
			dk_fileWrite(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/Run.sh "${RUN_SCRIPT_DEBUG}")
			dk_executeProcess(chmod 777 ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/Run.sh)
		endif()
	endif()
	if(RELEASE)
		if(WIN_HOST)
			set(RUN_SCRIPT_RELEASE
				"${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun.bat ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.html"
			)
			dk_fileWrite(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/Run.bat ${RUN_SCRIPT_RELEASE})
		else()
			set(RUN_SCRIPT_RELEASE
				"\#!/bin/bash\n"
				"${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.html"
			)
			dk_fileWrite(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/Run.sh ${RUN_SCRIPT_RELEASE})
			dk_executeProcess(chmod 777 ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/Run.sh)
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
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.data" "${DK_Project_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.html" "${DK_Project_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.js" "${DK_Project_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.wasm" "${DK_Project_Dir}/assets/")
	#else()
	#	add_custom_command(
	#		TARGET ${APP_NAME} 
	#		POST_BUILD
	#		COMMAND ${CMAKE_COMMAND} -E echo "Copying ${APP_NAME} Release wasm files to /assets"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.data" "${DK_Project_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.html" "${DK_Project_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.js" "${DK_Project_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.wasm" "${DK_Project_Dir}/assets/")
	#endif()
endif(EMSCRIPTEN)


#################
if(IOS OR IOSSIM)
	# https://github.com/forexample/testapp/blob/master/CMakeLists.txt
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			if(EXISTS ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.app)
				dk_delete(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.app.backup)
				dk_rename(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.app ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.app.backup OVERWRITE)
			endif()
		endif()
		if(RELEASE)
			if(EXISTS ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.app)
				dk_delete(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.app.backup)
				dk_rename(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.app ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.app.backup OVERWRITE)
			endif()
		endif()
	endif()
	
	###################### BACKUP USERDATA ###############################
	# Backup files and folders excluded from the package
	#	dk_copy(${DK_Project_Dir}/assets/USER ${DK_Project_Dir}/Backup/USER OVERWRITE)
	# Remove excluded files and folders before packaging
	#	dk_delete(${DK_Project_Dir}/assets/USER)
	# Restore the backed up files, excluded from assets
	#	dk_copy(${DK_Project_Dir}/Backup/ ${DK_Project_Dir}/assets/)
	#	dk_delete(${DK_Project_Dir}/Backup)
	
	########################## ICONS ###############################
	if(EXISTS "${DK_Project_Dir}/icons/icon.png")
		dk_createIcons("${DK_Project_Dir}/icons/icon.png")
	endif()
	
	####################### Storyboards ############################
	#TODO
		
	####################### Create Executable Target ###################
	file(GLOB_RECURSE m_SRC 
	${DK_Project_Dir}/*.m
	${DK_Project_Dir}/*.mm)
	list(APPEND App_SRC ${m_SRC})
	#if(HAVE_DK)
	#	list(APPEND App_SRC ${DKPLUGINS_DIR}/DK/DKAppDelegate.h)
	#	list(APPEND App_SRC ${DKPLUGINS_DIR}/DK/DKAppDelegate.m)
	#endif()
	add_executable(${APP_NAME} MACOSX_BUNDLE ${app_ICONS} ${App_SRC} ${RES_FILES})
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
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
	set_target_properties(${APP_NAME} PROPERTIES MACOSX_BUNDLE TRUE MACOSX_BUNDLE_INFO_PLIST ${DKPLUGINS_DIR}/_DKIMPORT/ios/Info.plist)
	
	###################### Disable bitcode ############################
	set_target_properties(${APP_NAME} PROPERTIES XCODE_ATTRIBUTE_ENABLE_BITCODE "NO")
	
	###################### Add Assets to Bundle #######################
	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${DK_Project_Dir}/assets $<TARGET_FILE_DIR:${APP_NAME}>/assets)
	#if(EXISTS ${DK_Project_Dir}/icons/mac/icons.icns)
	#	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${DK_Project_Dir}/icons/ios/icons.icns $<TARGET_FILE_DIR:${APP_NAME}>/Resources/icons.icns)
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
				"xcrun simctl install booted ${DK_Project_Dir}/iossim_x86_64/Debug-iphonesimulator/${APP_NAME}.app\n"
				"xcrun simctl launch --console-pty booted com.digitalknob.${APP_NAME}"
			)
			dk_fileWrite(${DK_Project_Dir}/iossim_x86_64/Debug-iphonesimulator/Run.sh ${RUN_SCRIPT_DEBUG})
			dk_executeProcess(chmod 777 ${DK_Project_Dir}/iossim_x86_64/Debug-iphonesimulator/Run.sh)
		endif()
		if(RELEASE)
			set(RUN_SCRIPT_RELEASE
				"\#!/bin/bash\n"
				"open -a Simulator.app\n"
				"xcrun simctl install booted ${DK_Project_Dir}/iossim_x86_64/Release-iphonesimulator/${APP_NAME}.app\n"
				"xcrun simctl launch --console-pty booted com.digitalknob.${APP_NAME}"
			)
			dk_fileWrite(${DK_Project_Dir}/iossim_x86_64/Release-iphonesimulator/Run.sh ${RUN_SCRIPT_RELEASE})
			dk_executeProcess(chmod 777 ${DK_Project_Dir}/iossim_x86_64/Release-iphonesimulator/Run.sh)
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
endif(IOS OR IOSSIM)


#########
if(LINUX)
if(NOT RASPBERRY)
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			dk_copy(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME} ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.backup OVERWRITE NO_HALT)
		elseif(RELEASE)
			dk_copy(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME} ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.backup OVERWRITE NO_HALT)
		endif()
	endif()
	
	########################## CREATE ICONS ###############################
	if(EXISTS "${DK_Project_Dir}/icons/icon.png")
		dk_createIcons("${DK_Project_Dir}/icons/icon.png")
	endif()
	#if(EXISTS ${DK_Project_Dir}/icons/icon.png)
	#	dk_copy(${DK_Project_Dir}/icons/icon.png ${DK_Project_Dir}/assets/icon.png OVERWRITE)
	#endif()
	
	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
		dk_copy(${DK_Project_Dir}/assets/USER ${DK_Project_Dir}/Backup/USER OVERWRITE)
		dk_delete(${DK_Project_Dir}/assets/USER)
		# Remove excluded files and folders before packaging
		dk_info("Creating assets.zip . . .")
		dk_compressAssets(${DK_Project_Dir}/assets)
		#dk_info("Creating assets.h . . .")
		dk_bin2h(SOURCE_FILE ${DK_Project_Dir}/assets.zip HEADER_FILE ${DK_Project_Dir}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		dk_copy(${DK_Project_Dir}/Backup/ ${DK_Project_Dir}/assets/)
		dk_delete(${DK_Project_Dir}/Backup)
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
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
	
	############# Create .desktop Icon Files / Install ################
	## https://specifications.freedesktop.org
	if(DEBUG)
		set(DESKTOP_FILE
			"[Desktop Entry]\n"
			"Encoding=UTF-8\n"
			"Version=1.0\n"
			"Type=Application\n"
			"Terminal=true\n"
			"Name=${APP_NAME}\n"
			"Exec=${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}\n"
			"Icon=${DK_Project_Dir}/icons/icon.png\n")
		list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
		dk_fileWrite("${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.desktop" "${DESKTOP_FILE}")
	elseif(RELEASE)
		set(DESKTOP_FILE
			"[Desktop Entry]\n"
			"Encoding=UTF-8\n"
			"Version=1.0\n"
			"Type=Application\n"
			"Terminal=true\n"
			"Name=${APP_NAME}\n"
			"Exec=${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}\n"
			"Icon=${DK_Project_Dir}/icons/icon.png\n")
		list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
		dk_fileWrite("${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.desktop" "${DESKTOP_FILE}")
	endif()
	
	# Create windows shortcut for WSL
	if(DEFINED ENV{WSL_DISTRO_NAME})
		dk_info("creating WSL shortcut")
		dk_depend(wsl)
		if(DEBUG)
			execute_process(COMMAND ${WSLPATH_EXE} -m "${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.lnk" OUTPUT_VARIABLE SHORTCUT_PATH OUTPUT_STRIP_TRAILING_WHITESPACE)
			dk_debug("WSL SHORTCUT_PATH = ${SHORTCUT_PATH}")
			dk_createShortcut("${SHORTCUT_PATH}" "${WSL_EXE}" "${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}")
		elseif(RELEASE)
			execute_process(COMMAND ${WSLPATH_EXE} -m "${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.lnk" OUTPUT_VARIABLE SHORTCUT_PATH OUTPUT_STRIP_TRAILING_WHITESPACE)
			dk_createShortcut("${SHORTCUT_PATH}" "${WSL_EXE}" "${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}")
		endif()
	endif()
	
	# Install shortcut of Release build to the apps menu
	if(NOT TINYCORE)
		if(DEBUG)
			#dk_executeProcess(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.desktop WORKING_DIRECTORY ${DK_Project_Dir}/${triple}/${DEBUG_DIR})
		elseif(RELEASE)
			dk_executeProcess(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.desktop WORKING_DIRECTORY ${DK_Project_Dir}/${triple}/${RELEASE_DIR})
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
	#CPP_Execute("chmod +x "+app_path+OS+"/${DEBUG_DIR}/"+target_app)
endif()
endif(LINUX)


#######
if(MAC)
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			dk_copy(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.app ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.app.backup OVERWRITE NO_HALT)
		endif()
		if(RELEASE)
			dk_copy(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.app ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.app.backup OVERWRITE NO_HALT)
		endif()
	endif()
		
	########################## CREATE ICONS ###############################
	if(EXISTS "${DK_Project_Dir}/icons/icon.png")
		dk_createIcons("${DK_Project_Dir}/icons/icon.png")
	endif()
	#if(EXISTS ${DK_Project_Dir}/icons/icon.png)
	#	dk_makeDirectory(${DK_Project_Dir}/icons/mac)
	#	dk_makeDirectory(${DK_Project_Dir}/icons/mac/icons.iconset)
	#	dk_resizeImage(${DK_Project_Dir}/icons/icon.png 16 16 ${DK_Project_Dir}/icons/mac/icons.iconset/icon_16x16.png)
	#	dk_resizeImage(${DK_Project_Dir}/icons/icon.png 32 32 ${DK_Project_Dir}/icons/mac/icons.iconset/icon_16x16@2x.png)
	#	dk_resizeImage(${DK_Project_Dir}/icons/icon.png 32 32 ${DK_Project_Dir}/icons/mac/icons.iconset/icon_32x32.png)
	#	dk_resizeImage(${DK_Project_Dir}/icons/icon.png 64 64 ${DK_Project_Dir}/icons/mac/icons.iconset/icon_32x32@2x.png)
	#	dk_resizeImage(${DK_Project_Dir}/icons/icon.png 128 128 ${DK_Project_Dir}/icons/mac/icons.iconset/icon_128x128.png)
	#	dk_resizeImage(${DK_Project_Dir}/icons/icon.png 256 256 ${DK_Project_Dir}/icons/mac/icons.iconset/icon_128x128@2x.png)
	#	dk_resizeImage(${DK_Project_Dir}/icons/icon.png 256 256 ${DK_Project_Dir}/icons/mac/icons.iconset/icon_256x256.png)
	#	dk_resizeImage(${DK_Project_Dir}/icons/icon.png 512 512 ${DK_Project_Dir}/icons/mac/icons.iconset/icon_256x256@2x.png)
	#	dk_resizeImage(${DK_Project_Dir}/icons/icon.png 512 512 ${DK_Project_Dir}/icons/mac/icons.iconset/icon_512x512.png)
	#	dk_resizeImage(${DK_Project_Dir}/icons/icon.png 1024 1024 ${DK_Project_Dir}/icons/mac/icons.iconset/icon_512x512@2x.png)
	#	dk_executeProcess(iconutil -c icns -o ${DK_Project_Dir}/icons/mac/icons.icns ${DK_Project_Dir}/icons/mac/icons.iconset WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	#	set(MACOSX_BUNDLE_ICON_FILE icons.icns)
	#	set(app_ICONS ${DK_Project_Dir}/icons/mac/icons.icns)
	#	set_source_files_properties(${app_ICONS} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
	#endif()
		
	################# BACKUP USERDATA / INJECT ASSETS #####################	
	dk_copy(${DK_Project_Dir}/assets/USER ${DK_Project_Dir}/Backup/USER OVERWRITE NO_HALT)
	dk_delete(${DK_Project_Dir}/assets/USER NO_HALT)
	dk_copy(${DK_Project_Dir}/Backup/ ${DK_Project_Dir}/assets/ OVERWRITE NO_HALT)
	dk_delete(${DK_Project_Dir}/Backup NO_HALT)
	
	####################### Create Executable Target ###################
	file(GLOB_RECURSE m_SRC 
		${DK_Project_Dir}/*.m
		${DK_Project_Dir}/*.mm)
	list(APPEND App_SRC ${m_SRC})
	add_executable(${APP_NAME} MACOSX_BUNDLE ${app_ICONS} ${App_SRC})
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
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
		MACOSX_BUNDLE_INFO_PLIST ${DKPLUGINS_DIR}/_DKIMPORT/mac/Info.plist)
		
	############## Delete Exlusions and Copy Assets to Bundle #######################
	if(EXISTS ${DK_Project_Dir}/assets)
		dk_delete(${DK_Project_Dir}/assets/log.txt)
		dk_delete(${DK_Project_Dir}/assets/cef.txt)
		add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${DK_Project_Dir}/assets $<TARGET_BUNDLE_CONTENT_DIR:${APP_NAME}>/Resources)
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
	if(EXISTS "${DKPLUGINS_DIR}/DKCefChild/${triple}/${RELEASE_DIR}/DKCefChild.app")
		dk_info("Adding ${APP_NAME} Helper to bundle . . .")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory "${DKPLUGINS_DIR}/DKCefChild/${triple}/$<CONFIG>/DKCefChild.app" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/${APP_NAME} Helper.app")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${DKPLUGINS_DIR}/DKCefChild/${triple}/$<CONFIG>/DKCefChild.app/Contents/MacOS/DKCefChild" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/${APP_NAME} Helper.app/Contents/MacOS/${APP_NAME} Helper")
	endif()
	
	# Make bundle open with Terminal
	# https://github.com/pyinstaller/pyinstaller/issues/5154#issuecomment-690646012
	if(MAC_TERMINAL_WRAPPER)
		dk_info("Making bundle app run in terminal on double-click . . .")
		set(TERMINAL_SCRIPT
			"\#!/bin/bash \ndir=$(cd \"$( dirname \"\${0}\")\" && pwd ) \nOpen -a \"Terminal\" \"\${dir}/${APP_NAME}\""
			#"\#!/bin/bash \n"
			#"dir=$(cd \"$( dirname \"\${0}\")\" && pwd ) \n"
			#"Open -a \"Terminal\" \"\${dir}/${APP_NAME}\""
		)
		dk_fileWrite(${DK_Project_Dir}/${triple}/wrapper ${TERMINAL_SCRIPT})
		dk_executeProcess(chmod +x ${DK_Project_Dir}/${triple}/wrapper WORKING_DIRECTORY ${DK_Project_Dir}/${triple})
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${triple}/wrapper" "$<TARGET_FILE_DIR:${APP_NAME}>/wrapper")
	endif()
	
	#CPP_Execute("chmod +x "+app_path+OS+"/${DEBUG_DIR}/"+target_app)
#			if(CPP_DKFile_Exists(app_path+"assets/DKCef/mac_x86_64_Debug/Chromium Embedded Framework.framework")){
#				CPP_DKFile_MkDir(app_path+"mac_x86_64/${DEBUG_DIR}/"+target_app+".app/Contents/Frameworks")
#				CPP_DKFile_Copy(app_path+"assets/DKCef/mac_x86_64_Debug/Chromium Embedded Framework.framework", app_path+"mac_x86_64/${DEBUG_DIR}/"+target_app+".app/Contents/Frameworks/Chromium Embedded Framework.framework", true)
#				if(CPP_DKFile_Exists(DIGITALKNOB_DIR+"DK/DKPlugins/DKCefChild/mac_x86_64/${DEBUG_DIR}/DKCefChild.app")){
#					CPP_DKFile_Copy(DIGITALKNOB_DIR+"DK/DKPlugins/DKCefChild/mac_x86_64/${DEBUG_DIR}/DKCefChild.app", app_path+"mac_x86_64/${DEBUG_DIR}/"+target_app+".app/Contents/Frameworks/"+target_app+" Helper.app", true)
#					CPP_DKFile_Rename(app_path+"mac_x86_64/${DEBUG_DIR}/"+target_app+".app/Contents/Frameworks/"+target_app+" Helper.app/Contents/MacOS/DKCefChild", app_path+"mac_x86_64/${DEBUG_DIR}/"+target_app+".app/Contents/Frameworks/"+target_app+" Helper.app/Contents/MacOS/"+target_app+" Helper", true)
#				}
#			}
#			//update the info.plist to include the logo icon
#			if(CPP_DKFile_Exists(app_path+OS+"/${DEBUG_DIR}/"+target_app+".app/Contents/info.plist")){
#				let info_plist = CPP_DKFile_FileToString(app_path+OS+"/${DEBUG_DIR}/"+target_app+".app/Contents/info.plist")
#				info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>")
#				CPP_DKFile_StringToFile(info_plist, app_path+OS+"/${DEBUG_DIR}/"+target_app+".app/Contents/info.plist")
#			}
#			//update install_name_tool if cef present
#			if(CPP_DKFile_Exists(app_path+OS+"/${DEBUG_DIR}/"+target_app+".app/Contents/Frameworks/Chromium Embedded Framework.framework")){
#				console.log("USING CHROMIUM EMBEDDED FRAMEWORK")
#				let command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+app_path+OS+"/${DEBUG_DIR}/"+target_app+".app/Contents/Frameworks/"+target_app+" Helper.app/Contents/MacOS/"+target_app+" Helper\""
#				console.log(command)
#				CPP_Execute(command)
#				command = "install_name_tool -add_rpath \"@executable_path/../../../../\" \""+app_path+OS+"/${DEBUG_DIR}/"+target_app+".app/Contents/Frameworks/"+target_app+" Helper.app/Contents/MacOS/"+target_app+" Helper\""
#				console.log(command)
#				CPP_Execute(command)
#				command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+app_path+OS+"/${DEBUG_DIR}/"+target_app+".app/Contents/Frameworks/"+target_app+" Helper.app/Contents/MacOS/"+target_app+"\""
#				console.log(command)
#				CPP_Execute(command)
#				command = "install_name_tool -add_rpath \"@executable_path/../\" \""+app_path+OS+"/${DEBUG_DIR}/"+target_app+".app/Contents/MacOS/"+target_app+"\""
#				console.log(command)
#				CPP_Execute(command)
#			}
#			*/
endif(MAC)


#############
if(RASPBERRY)
	########################## CREATE ICONS ###############################
	if(EXISTS "${DK_Project_Dir}/icons/icon.png")
		dk_createIcons("${DK_Project_Dir}/icons/icon.png")
	endif()

	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
		dk_copy(${DK_Project_Dir}/assets/USER ${DK_Project_Dir}/Backup/USER OVERWRITE)
		# Remove excluded files and folders before packaging
		dk_delete(${DK_Project_Dir}/assets/USER)
		dk_info("Creating assets.zip . . .")
		dk_compressAssets(${DK_Project_Dir}/assets)
		#dk_info("Creating assets.h . . .")
		dk_bin2h(SOURCE_FILE ${DK_Project_Dir}/assets.zip HEADER_FILE ${DK_Project_Dir}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		dk_copy(${DK_Project_Dir}/Backup/ ${DK_Project_Dir}/assets/)
		dk_delete(${DK_Project_Dir}/Backup)
	endif()
	
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			dk_rename(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME} ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.backup OVERWRITE NO_HALT)
		elseif(RELEASE)
			dk_rename(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME} ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.backup OVERWRITE NO_HALT)
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
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
		
	############# Create .desktop Icon Files and Install ##############
	## https://specifications.freedesktop.org
	if(DEBUG)
	# Create .desktop file for Debug
	dk_set(DESKTOP_FILE
		"[Desktop Entry]\n"
		"Encoding=UTF-8\n"
		"Version=1.0\n"
		"Type=Application\n"
		"Terminal=true\n"
		"Name=${APP_NAME}\n"
		"Exec=${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}\n"
		"Icon=${DK_Project_Dir}/icons/icon.png\n")
	list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
	dk_fileWrite(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.desktop ${DESKTOP_FILE})
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
		"Exec=${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}\n"
		"Icon=${DK_Project_Dir}/icons/icon.png\n")
	list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
	dk_fileWrite(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.desktop ${DESKTOP_FILE})
	endif()
	
	# Install shortcut of Release build to the apps menu
	if(RELEASE)
		dk_executeProcess(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.desktop WORKING_DIRECTORY ${DK_Project_Dir}/${triple}/Release)
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
	#CPP_Execute("chmod +x "+app_path+OS+"/${DEBUG_DIR}/"+target_app)
endif(RASPBERRY)


##########
if(WIN_X86)
	########################## CREATE ICONS ###############################
	if(EXISTS "${DK_Project_Dir}/icons/icon.png")
		dk_createIcons("${DK_Project_Dir}/icons/icon.png")
	endif()
	
	################# BACKUP USERDATA / INJECT ASSETS #####################	
	if(HAVE_DK)
		dk_copy(${DK_Project_Dir}/assets/USER ${DK_Project_Dir}/Backup/USER OVERWRITE NO_HALT)
		dk_delete(${DK_Project_Dir}/assets/USER)
		# Compress the assets, they will be included by resource.rc
		dk_info("Creating assets.zip . . .")
		dk_compressAssets(${DK_Project_Dir}/assets)
		# Restore the backed up files, excluded from assets
		dk_copy(${DK_Project_Dir}/Backup ${DK_Project_Dir}/assets OVERWRITE NO_HALT)
		dk_delete(${DK_Project_Dir}/Backup)
		dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/assets.h ${DK_Project_Dir}/assets.h OVERWRITE) #required
	endif()	
		
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			dk_rename(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.exe ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.exe.backup OVERWRITE NO_HALT)
		endif()
		if(RELEASE)
			dk_rename(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.exe ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.exe.backup OVERWRITE NO_HALT)
		endif()
	endif()
		
	####################### Create Executable Target ###################
	if(HAVE_DK)
		##set_source_files_properties(${DIGITALKNOB_DIR}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
		dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/win/resource.h ${DK_Project_Dir}/resource.h)
		dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/win/resource.rc ${DK_Project_Dir}/resource.rc)
		file(GLOB_RECURSE resources_SRC 
			${DK_Project_Dir}/*.manifest
			${DK_Project_Dir}/*.rc
			${DK_Project_Dir}/icons/windows/*.rc)
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
			if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
				add_dependencies(${APP_NAME} ${plugin})
			endif()	
		endforeach()
	endif()

	############# Link Libraries, Set Startup Project #################
	if(MULTI_CONFIG)
		target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	else()
		#target_link_libraries(${APP_NAME} -static -static-libgcc -static-libstdc++ winpthread)# -dynamic)
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
		list(APPEND DEBUG_LINK_FLAGS /NODEFAULTLIB:msvcrtd.lib)
		dk_replaceAll("${DEBUG_LINK_FLAGS}"  ";"  " "  DEBUG_FLAGS)
		
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
		dk_replaceAll("${RELEASE_LINK_FLAGS}"  ";"  " "  RELEASE_FLAGS)
		
		set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
		
		# remove -bin from APP_NAME. Was added to avoid app/library same name conflicts
		#set_target_properties(${APP_NAME} PROPERTIES OUTPUT_NAME ${APP_NAME})
		#set_target_properties(${APP_NAME} PROPERTIES RUNTIME_OUTPUT_NAME ${APP_NAME})
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
	#	#COMMAND cmd /c ${CMAKE_COMMAND} --build ${DK_Project_Dir}/${triple} --target ${APP_NAME}
	#)
	
	#add_custom_command(
    #TARGET ${APP_NAME}
    #POST_BUILD
    #COMMAND "mt.exe" -nologo
    #        -manifest \"${DK_Project_Dir}/compatibility.manifest\"
    #        -outputresource:"${DK_Project_Dir}/win_x86/${DEBUG_DIR}/${APP_NAME}.exe"\;\#1
    #COMMENT "Adding manifest..."
    #)
	
	#CPP_DKFile_Copy(app_path+OS+"/${RELEASE_DIR}/"+target_app+".pdb", app_path+"assets/"+target_app+".pdb", true)
	#CPP_Execute(DIGITALKNOB_DIR+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/${RELEASE_DIR}/"+target_app+".exe")
endif(WIN_X86)
	
	
##########
if(WIN_X86_64)
	########################## CREATE ICONS ###############################
	if(EXISTS "${DK_Project_Dir}/icons/icon.png")
		dk_createIcons("${DK_Project_Dir}/icons/icon.png")
	endif()
			
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
		dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/assets.h ${DK_Project_Dir}/assets.h OVERWRITE NO_HALT)
	endif()

	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
			dk_rename(${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.exe ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.exe.backup OVERWRITE NO_HALT)
		endif()
		if(RELEASE)
			dk_rename(${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.exe ${DK_Project_Dir}/${triple}/${RELEASE_DIR}/${APP_NAME}.exe.backup OVERWRITE NO_HALT)
		endif()
	endif()
		
	####################### Create Executable Target ###################
	if(HAVE_DK)
		##set_source_files_properties(${DIGITALKNOB_DIR}/stdafx.cpp PROPERTIES COMPILE_FLAGS "/Ycstdafx.h")
		dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/win/resource.h ${DK_Project_Dir}/resource.h)
		dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/win/resource.rc ${DK_Project_Dir}/resource.rc)
		file(GLOB_RECURSE resources_SRC 
			${DK_Project_Dir}/*.manifest
			${DK_Project_Dir}/*.rc
			${DK_Project_Dir}/icons/windows/*.rc)
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
			if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
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
	#CPP_DKFile_Copy(app_path+OS+"/${RELEASE_DIR}/"+target_app+".pdb", app_path+"assets/"+target_app+".pdb", true)
	#CPP_Execute(DIGITALKNOB_DIR+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/${RELEASE_DIR}/"+target_app+".exe")
endif(WIN_X86_64)



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
#	dk_command(ldd >> ${DK_Project_Dir}/${triple}/DKBUILD.log)
#elseif(MAC OR IOS)
	# TODO
	#dk_command(otool -L ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.app)
#elseif(WIN)	
	# TODO
	#"C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.30.30705/bin/Hostx86/x86/dumpbin.exe" /dependents ${DK_Project_Dir}/${triple}/${DEBUG_DIR}/${APP_NAME}.exe
#endif()

dk_info("\n\n")
dk_info("******************************************************")
dk_info("****** Generated ${APP_NAME} - ${triple}  ************")
dk_info("******************************************************\n")

