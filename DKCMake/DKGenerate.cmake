#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(TO_CMAKE_PATH "$ENV{USERPROFILE}$ENV{HOME}/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "$ENV{DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
# Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
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
dk_assertPath("$ENV{DKCMAKE_DIR}/DKDisabled.cmake")
dk_load("$ENV{DKCMAKE_DIR}/DKDisabled.cmake")

dk_info("\n")
dk_info("############################################################")
dk_info("######################  DigitalKnob  #######################")
dk_info("############################################################")
dk_info("\n")





############ Target_Tuple_Dir ############
dk_getFullPath("${CMAKE_BINARY_DIR}" Target_Bin_Dir)
if(Target_Bin_Dir MATCHES "Release")
	dk_dirname(${Target_Bin_Dir} Target_Tuple_Dir)
elseif(Target_Bin_Dir MATCHES "Debug")
	dk_dirname(${Target_Bin_Dir} Target_Tuple_Dir)
else()
	set(Target_Tuple_Dir ${Target_Bin_Dir})
endif()
dk_set(Target_Tuple_Dir ${Target_Tuple_Dir})

############ Target_App_Dir ############
dk_dirname(${Target_Tuple_Dir} Target_App_Dir)
dk_set(Target_App_Dir ${Target_App_Dir})
dk_assertPath(Target_App_Dir)	
	
############ Target_App ############	
dk_basename(${Target_App_Dir} Target_App)
dk_replaceAll(${Target_App} " " "_" Target_App)
set(Target_App ${Target_App}_APP)

############################################################################################
############################   ADD EXECUTABLE  #############################################
############################################################################################
if(NOT TARGET)
	PROJECT(${Target_App})
	dk_set(DKAPP ON)
endif()

######################################################
##### Scan the DKCpp/plugins and build the lists #####
######################################################
dk_load(${Target_App_Dir}/DKINSTALL.cmake)
dk_assertVar(Target_Tuple)
dk_delete(${Target_App_Dir}/${Target_Tuple}/DKBUILD.log NO_HALT)
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
	if(plugin IN_LIST dk_disabled_list)
		dk_notice("plugin:${plugin} disabled, skipping...")
		continue()
	endif()
		
	dk_set(QUEUE_BUILD 0)
	dk_set(PREBUILD 0)
	dk_set(LIBLIST "") # used for double checking
	
	dk_info("############################################################")
	dk_info("######  Processing   ${plugin} . . .                        ")
	dk_info("############################################################")
	dk_debug("plugin = ${plugin} = ${${plugin}}")
	
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
	dk_getPathToPlugin(${plugin} Plugin_Path)
	if(NOT Plugin_Path)
		DEBUG_LINE()
		Wait()
		break()
	endif()
	#dk_printVar(Plugin_Path)

	# This executes the 3rdParty library builds, and creates CMakeLists.txt files for DKCpp/plugins
	dk_depend(${plugin})
	#if(NOT "${plugin}")
	#	dk_error("${plugin} is invalid")
	#endif()
	
	
	#check that each library is using the proper variables. Should be UPPERCASE plugin name.   I.E. boost = ${BOOST}
	dk_toUpper(${plugin} PLUGIN)
	dk_debug("PLUGIN = ${PLUGIN} = ${${PLUGIN}}")
	if(NOT "${PLUGIN}")
		dk_error("${PLUGIN}'${${PLUGIN}}' is invalid")
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
		dk_toUpper(${plugin} PLUGIN)
		if(EXISTS "${${PLUGIN}}/CMakeLists.txt")
			#if(MULTI_CONFIG)
			#	add_subdirectory(${${PLUGIN}} ${${PLUGIN}}/${Target_Tuple})
			#else()
			#	if(Debug)
			#		add_subdirectory(${Plugin_Path} ${Plugin_Path}/${Target_Tuple}/Debug)
			#	elseif(Release)
			#		add_subdirectory(${Plugin_Path} ${Plugin_Path}/${Target_Tuple}/Release)
			#	endif()
			#endif()
			dk_debug("adding ${${PLUGIN}}")
			add_subdirectory(${${PLUGIN}} ${${PLUGIN}}/${CONFIG_PATH})
		endif()
	endif(PROJECT_INCLUDE_3RDPARTY)
	
	#install(TARGETS <target_name> DESTINATION $ENV{DIGITALKNOB_DIR}/DKInstall/lib/${Target_Tuple})
	#install(FILES file.h DESTINATION $ENV{DIGITALKNOB_DIR}/DKInstall/lib/${Target_Tuple})
	
	####################### DKCpp/plugins #######################
	# Libraries in the /DKCpp/plugins folder
	dk_toLower("${DKPLUGIN_LIST}" dkplugin_list)
	#dk_toLower("${PLUGIN}" plugin)
	string(FIND "${dkplugin_list}" "${plugin}" isDKPlugin)
	
	# Install 3rd Party Libs
	if(INSTALL_DKLIBS)
		if(${isDKPlugin} EQUAL -1)
			if(EXISTS ${Plugin_Path}/${CONFIG_PATH}/cmake_install.cmake)
				dk_queueCommand(${CMAKE_COMMAND} --install ${Plugin_Path}/${CONFIG_PATH})
			endif()
		endif()
	endif(INSTALL_DKLIBS)
	
	if(${isDKPlugin} GREATER -1)
		# Install header files for DKPlugin
		if(INSTALL_DKLIBS)
			dk_info("Installing ${plugin} header files")
			file(INSTALL DIRECTORY ${Plugin_Path}/ DESTINATION ${CMAKE_INSTALL_PREFIX}/include/${plugin} FILES_MATCHING PATTERN "*.h")
			dk_deleteEmptyDirectories(${CMAKE_INSTALL_PREFIX}/include/${plugin})
		endif()
		
		#Add the DKPlugin to the app project
		if(PROJECT_INCLUDE_DKPLUGINS)
			if(EXISTS "${Plugin_Path}/CMakeLists.txt")
				#if(MULTI_CONFIG)
				#	add_subdirectory(${Plugin_Path} ${Plugin_Path}/${Target_Tuple})
				#else()
				#	if(Debug)
				#		add_subdirectory(${Plugin_Path} ${Plugin_Path}/${Target_Tuple}/Debug)
				#	elseif(Release)
				#		add_subdirectory(${Plugin_Path} ${Plugin_Path}/${Target_Tuple}/Release)
				#	endif()
				#endif()
				add_subdirectory(${Plugin_Path} ${Plugin_Path}/${CONFIG_PATH})
			endif()
		endif()
		
#		## Prebuild DKCpp/plugins prior to app
#		if(NOT PROJECT_INCLUDE_DKPLUGINS)
#			dk_set(PREBUILD ON) ## Always prebuild all DKCpp/plugins
#			
#			foreach(lib ${LIBLIST})
#				if(NOT EXISTS ${lib})
#					dk_warning("MISSING: ${lib}")
#					dk_set(PREBUILD ON)	## Only prebuild if the library binaries are missing
#				else()
#					dk_success("FOUND: ${lib}")
#				endif()
#			endforeach()
#		
#			if(PREBUILD)
#				dk_fatal("This is still being used")
#				dk_set(QUEUE_BUILD ON)
#				dk_info("************* Building ${plugin} *************")
#				dk_chdir(${Plugin_Path}/${CONFIG_PATH})
#				
#				if(MULTI_CONFIG)
#					dk_fatal("This is still being used")
#					###### Configure ######
#					ANDROID_ARM32_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM32=ON 	${Plugin_Path})
#					ANDROID_ARM64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM64=ON 	${Plugin_Path})
#					ANDROID_X86_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_X86=ON 	${Plugin_Path})
#					ANDROID_X86_64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_X86_64=ON 	${Plugin_Path})
#					EMSCRIPTEN_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DEMSCRIPTEN=ON 		${Plugin_Path})
#					IOS_ARM32_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOS_ARM32=ON 		${Plugin_Path})
#					IOS_ARM64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOS_ARM64=ON 		${Plugin_Path})
#					IOSSIM_X86_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86=ON 		${Plugin_Path})
#					IOSSIM_X86_64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86_64=ON 	${Plugin_Path})
#					LINUX_X86_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DLINUX_X86=ON 		${Plugin_Path})
#					LINUX_X86_64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DLINUX_X86_64=ON 	${Plugin_Path})
#					MAC_X86_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DMAC_X86=ON 		${Plugin_Path})
#					MAC_X86_64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DMAC_X86_64=ON 		${Plugin_Path})
#					RASPBERRY_ARM32_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM32=ON ${Plugin_Path})
#					RASPBERRY_ARM64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM64=ON ${Plugin_Path})
#					WIN_X86_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DWIN_X86=ON 		${Plugin_Path})
#					WIN_X86_64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DWIN_X86_64=ON 		${Plugin_Path})
#					
#					###### Build ######
#					DEBUG_dk_queueCommand			(${CMAKE_COMMAND} --build . --config Debug)
#					RELEASE_dk_queueCommand			(${CMAKE_COMMAND} --build . --config Release)
#				else()
#					dk_fatal("This is still being used")
#					if(Debug)
#						dk_fatal("This is still being used")
#						###### Configure ######
#						ANDROID_ARM32_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_ARM32=ON 	${Plugin_Path})
#						ANDROID_ARM64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_ARM64=ON 	${Plugin_Path})
#						ANDROID_X86_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_X86=ON 		${Plugin_Path})
#						ANDROID_X86_64_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_X86_64=ON 	${Plugin_Path})
#						EMSCRIPTEN_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DEMSCRIPTEN=ON 		${Plugin_Path})
#						IOS_ARM32_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOS_ARM32=ON 		${Plugin_Path})
#						IOS_ARM64_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOS_ARM64=ON 		${Plugin_Path})
#						IOSSIM_X86_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOSSIM_X86=ON 		${Plugin_Path})
#						IOSSIM_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOSSIM_X86_64=ON 	${Plugin_Path})
#						LINUX_X86_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DLINUX_X86=ON 		${Plugin_Path})
#						LINUX_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DLINUX_X86_64=ON 	${Plugin_Path})
#						MAC_X86_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DMAC_X86=ON 			${Plugin_Path})
#						MAC_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DMAC_X86_64=ON 		${Plugin_Path})
#						RASPBERRY_ARM32_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DRASPBERRY_ARM32=ON 	${Plugin_Path})
#						RASPBERRY_ARM64_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DRASPBERRY_ARM64=ON 	${Plugin_Path})
#						WIN_X86_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DWIN_X86=ON 			${Plugin_Path})
#						WIN_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DWIN_X86_64=ON 		${Plugin_Path})
#						
#						###### Build ######
#						DEBUG_dk_queueCommand					(${CMAKE_COMMAND} --build . --config Debug)
#						
#					elseif(Release)
#						dk_fatal("This is still being used")
#						###### Configure ######
#						ANDROID_ARM32_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM32=ON 		${Plugin_Path})
#						ANDROID_ARM64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM64=ON 		${Plugin_Path})
#						ANDROID_X86_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_X86=ON 		${Plugin_Path})
#						ANDROID_X86_64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_X86_64=ON 	${Plugin_Path})
#						EMSCRIPTEN_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DEMSCRIPTEN=ON 		${Plugin_Path})
#						IOS_ARM32_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOS_ARM32=ON 			${Plugin_Path})
#						IOS_ARM64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOS_ARM64=ON 			${Plugin_Path})
#						IOSSIM_X86_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86=ON 		${Plugin_Path})
#						IOSSIM_X86_64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86_64=ON 		${Plugin_Path})
#						LINUX_X86_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DLINUX_X86=ON 			${Plugin_Path})
#						LINUX_X86_64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DLINUX_X86_64=ON 		${Plugin_Path})
#						MAC_X86_RELEASE_dk_queueCommand			(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DMAC_X86=ON 			${Plugin_Path})
#						MAC_X86_64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DMAC_X86_64=ON 		${Plugin_Path})
#						RASPBERRY_ARM32_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM32=ON 	${Plugin_Path})
#						RASPBERRY_ARM64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM64=ON 	${Plugin_Path})
#						WIN_X86_RELEASE_dk_queueCommand			(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DWIN_X86=ON 			${Plugin_Path})
#						WIN_X86_64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DWIN_X86_64=ON 		${Plugin_Path})
#						
#						###### Build ######
#						RELEASE_dk_queueCommand					(${CMAKE_COMMAND} --build . --config Release)
#					endif()
#				endif()
#
#				## double check that the missing libs were built
#				foreach(lib ${LIBLIST})
#					if(NOT EXISTS ${lib})
#						dk_fatal("\n\n\n****************************\nFAILED to find: ${lib} \n****************************")
#					else()
#						# Install DKPlugin Libs
#						if(INSTALL_DKLIBS)
#							if(EXISTS ${Plugin_Path}/${CONFIG_PATH}/cmake_install.cmake)
#								dk_queueCommand(${CMAKE_COMMAND} --install ${Plugin_Path}/${CONFIG_PATH})
#							endif()
#						endif()
#					endif()
#				endforeach()
#
#			endif(PREBUILD)
#		endif(NOT PROJECT_INCLUDE_DKPLUGINS)
	else()
		foreach(lib ${LIBLIST})
			if(NOT EXISTS ${lib})
				dk_fatal("\n\n\n****************************\nFAILED to find: ${lib} \n***********************************")
			else()	
				# Install DKPlugin Libs
				if(INSTALL_DKLIBS)
					if(EXISTS ${Plugin_Path}/${CONFIG_PATH}/cmake_install.cmake)
						dk_queueCommand(${CMAKE_COMMAND} --install ${Plugin_Path}/${CONFIG_PATH})
					endif()
				endif()
			endif()
		endforeach()
	endif(${isDKPlugin} GREATER -1)
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


###########
if(Android)
	################################ CMAKE_ANDROID_GUI ########################################
	if(CMAKE_ANDROID_GUI) # CMAKE_ANDROID_GUI is set to 1 by DKSDLWindow/DKCMake.cmake
		########################## CREATE ICONS ###############################
		if(EXISTS "${Target_App_Dir}/icons/icon.png")
			dk_createIcons("${Target_App_Dir}/icons/icon.png")
		endif()
		#if(EXISTS ${Target_App_Dir}/icons/icon.png)
		#	dk_copy(${Target_App_Dir}/icons/icon.png ${Target_App_Dir}/assets/icon.png OVERWRITE)
		#endif()
	
		###################### Backup Executable ###########################
		if(BACKUP_APP_EXECUTABLES)
			if(MULTI_CONFIG)
				if(Debug)
					dk_rename(${Target_App_Dir}/${Target_Tuple}/app/build/outputs/apk/debug/app-debug.apk ${Target_App_Dir}/${Target_Tuple}/app/build/outputs/apk/app-debug.apk.backup OVERWRITE NO_HALT)
				endif()
				if(Release)
					dk_rename(${Target_App_Dir}/${Target_Tuple}/app/build/outputs/apk/release/app-release-unsigned.apk ${Target_App_Dir}/${Target_Tuple}/app/build/outputs/apk/release/app-release-unsigned.apk.backup OVERWRITE NO_HALT)
				endif()
			else()
				if(Debug)
					dk_rename(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/app/build/outputs/apk/debug/app-debug.apk ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/app/build/outputs/apk/app-debug.apk.backup OVERWRITE NO_HALT)
				endif()
				if(Release)
					dk_rename(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/app/build/outputs/apk/release/app-release-unsigned.apk ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/app/build/outputs/apk/release/app-release-unsigned.apk.backup OVERWRITE NO_HALT)
				endif()
			endif()
		endif()
	
		####################### Create Library Target ###################
		#if(MSVC)
			set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/app/src/main/jniLibs/${ANDROID_ABI}")
			set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/app/src/main/jniLibs/${ANDROID_ABI}")
		#else()
		#	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/${Debug_Dir}/app/src/main/jniLibs/${ANDROID_ABI}")
		#	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/${Release_Dir}/app/src/main/jniLibs/${ANDROID_ABI}")
		#endif()
	
		######## Create local.properties file that points to android-sdk path #############
		set(localProperties "sdk.dir=${ANDROID_SDK}")
	
		####### Import Android Gui Build files ############################################
		if(Debug)
			dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/android/ ${Target_App_Dir}/${Target_Tuple}/Debug)
			if(EXISTS ${DKCPP_PLUGINS_DIR}/_DKIMPORT/${Target_Tuple})
				dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/${Target_Tuple}/ ${Target_App_Dir}/${Target_Tuple}/Debug)
			endif()
			dk_copy(${Target_App_Dir}/assets ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/app/src/main/assets OVERWRITE)
			dk_fileWrite(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/local.properties ${localProperties})
			dk_fileReplace(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/app/src/main/res/values/strings.xml "_DKIMPORT" "${Target_App}" NO_HALT)
			if(UNIX_HOST)
				dk_exec(chmod 777 ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/gradlew)
				dk_exec(sed -i -e "s/\r$//" "${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/gradlew")
			endif()
			#TODO: set GRADLE_USER_HOME environment variable. Location of .gradle cache
		endif()
		if(Release)
			dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/android/ ${Target_App_Dir}/${Target_Tuple}/Release)
			dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/${Target_Tuple}/ ${Target_App_Dir}/${Target_Tuple}/Release)
			dk_copy(${Target_App_Dir}/assets ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/app/src/main/assets OVERWRITE)
			dk_fileWrite(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/local.properties ${localProperties})
			dk_fileReplace(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/app/src/main/res/values/strings.xml "_DKIMPORT" "${Target_App}" NO_HALT)
			if(UNIX_HOST)
				dk_exec(chmod 777 ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/gradlew)
				dk_exec(sed -i -e "s/\r$//" "${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/gradlew")
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
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
			add_dependencies(main ${plugin})
		endif()	
	endforeach()
	
	######################### Link Libraries ###########################
	#if(MSVC)
	#	target_link_libraries(main ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	#else()
		if(Debug)
			target_link_libraries(main ${DEBUG_LIBS} ${LIBS})
		endif()
		if(Release)
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
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:Target_App = $<TARGET_FILE:main>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:Target_App = $<TARGET_FILE_DIR:main>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	
	####################### Gradle Build #####################
	if(CMAKE_ANDROID_GUI)
		#if(Windows_Host)
		#	dk_command(${OPENJDK}/registerJDK.cmd)
		#endif()
		dk_depend(openjdk)
		dk_depend(gradle)
		
		if(Windows_Host)
			set(setVar "set")
		else()
			set(setVar "export")
		endif()
	
		if(Debug)
			add_custom_command(
				TARGET main
				POST_BUILD
				COMMAND ${CMAKE_COMMAND} -E echo "Building with Gradle"
				COMMAND ${setVar} JAVA_HOME=$ENV{JAVA_HOME} && ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/gradlew${bat} --gradle-user-home ${GRADLE_USER_HOME} --project-dir ${Target_App_Dir}/${Target_Tuple}/Debug --info clean build #--offline
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished building with Gradle"
				WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
				VERBATIM)
		endif()
		if(Release)
			add_custom_command(
				TARGET main
				POST_BUILD
				COMMAND ${CMAKE_COMMAND} -E echo "Building with Gradle"
				COMMAND ${setVar} "JAVA_HOME=$ENV{JAVA_HOME}" & ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/gradlew${bat} --gradle-user-home ${GRADLE_USER_HOME} --project-dir ${Target_App_Dir}/${Target_Tuple}/Release --info clean build #--offline
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
	if(NOT Android_Host AND INSTALL_APK)
		dk_depend(cmd)	
		if(Debug)
			dk_validate(CMD_EXE "dk_CMD_EXE()")
			add_custom_command(
				POST_BUILD
				TARGET main
				COMMAND ${CMAKE_COMMAND} -E echo "Installing <app-debug.apk> to device"
				COMMAND ${CMD_EXE} ${ANDROID_SDK}/platform-tools/adb install -r ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/app/build/outputs/apk/debug/app-debug.apk
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished installing <app-debug.apk> to device")
		if(Release)
		endif()
			dk_validate(CMD_EXE "dk_CMD_EXE()")
			add_custom_command(
				POST_BUILD
				TARGET main
				COMMAND ${CMAKE_COMMAND} -E echo "Installing <app-release-unsigned.apk> to device"
				COMMAND ${CMD_EXE} ${ANDROID_SDK}/platform-tools/adb install -r ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/app/build/outputs/apk/release/app-release-unsigned.apk
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished installing <app-release-unsigned.apk> to device")
		endif()
	endif()
#endif(Android)


#############
elseif(Cosmopolitan)
	####################### Create Executable Target ###################
	add_executable(${Target_App} ${App_SRC})
	
	########################### Add libraries ##########################
	if(Debug)
		target_link_libraries(${Target_App} ${DEBUG_LIBS} ${LIBS})
	elseif(Release)
		target_link_libraries(${Target_App} ${RELEASE_LIBS} ${LIBS})
	endif()

	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
			add_dependencies(${Target_App} ${plugin})
		endif()	
	endforeach()
#endif(Cosmopolitan)


##############
elseif(Emscripten)
	# TODO: https://schellcode.github.io/webassembly-without-emscripten
	
	########################## CREATE ICONS ###############################
	if(EXISTS "${Target_App_Dir}/icons/icon.png")
		dk_createIcons("${Target_App_Dir}/icons/icon.png")
	endif()

	############### BACKUP USERDATA / inject assets #######################
	if(false)
		dk_copy(${Target_App_Dir}/assets/USER ${Target_App_Dir}/Backup/USER OVERWRITE NO_HALT)  # backup files not going in the package
		dk_delete(${Target_App_Dir}/assets/USER)		# Remove excluded files and folders before packaging
		dk_info("Creating assets.zip . . .")
		dk_compressAssets(${Target_App_Dir}/assets)
		#dk_info("Creating assets.h . . .")
		dk_bin2h(SOURCE_FILE ${Target_App_Dir}/assets.zip HEADER_FILE ${Target_App_Dir}/assets.h VARIABLE_NAME "ASSETS_H")
		dk_copy(${Target_App_Dir}/Backup/ ${Target_App_Dir}/assets/) # Restore the backed up assets
		dk_delete(${Target_App_Dir}/Backup)
	endif()
	
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(Debug)
			dk_rename(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.data ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.data.backup OVERWRITE NO_HALT)
			dk_rename(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.html ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.html.backup OVERWRITE NO_HALT)
			dk_rename(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.js ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.js.backup OVERWRITE NO_HALT)
			dk_rename(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.wasm ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.wasm.backup OVERWRITE NO_HALT)
		elseif(Release)
			dk_rename(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.data ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.data.backup OVERWRITE NO_HALT)
			dk_rename(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.html ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.html.backup OVERWRITE NO_HALT)
			dk_rename(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.js ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.js.backup OVERWRITE NO_HALT)
			dk_rename(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.wasm ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.wasm.backup OVERWRITE NO_HALT)
		endif()
	endif()
	
	####################### Create Executable Target ###################
	add_executable(${Target_App} ${App_SRC})
	if(Debug)
		target_link_libraries(${Target_App} ${DEBUG_LIBS} ${LIBS})
	elseif(Release)
		target_link_libraries(${Target_App} ${RELEASE_LIBS} ${LIBS})
	endif()
	set(CMAKE_EXECUTABLE_SUFFIX ".html")
	
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
			add_dependencies(${Target_App} ${plugin})
		endif()	
	endforeach()

	########## Remove previous built files from assets #################
	dk_delete(${Target_App_Dir}/assets/${Target_App}.data NO_HALT)
	dk_delete(${Target_App_Dir}/assets/${Target_App}.html NO_HALT)
	dk_delete(${Target_App_Dir}/assets/${Target_App}.js NO_HALT)
	dk_delete(${Target_App_Dir}/assets/${Target_App}.wasm NO_HALT)

	########################## PACKAGE ASSETS ##########################
	if(EXISTS ${Target_App_Dir}/assets)
		set_target_properties(${Target_App} PROPERTIES LINK_FLAGS "-sASSERTIONS -sALLOW_MEMORY_GROWTH --preload-file ${Target_App_Dir}/assets@/")
	endif()
	
	################### Create Run.sh #################################
	dk_info("Creating Run scripts . . .")
	if(Debug)
		if(Windows_Host)
			set(RUN_SCRIPT_DEBUG
				"${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun.bat ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.html"
			)
			dk_fileWrite(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/Run.bat ${RUN_SCRIPT_DEBUG})
		else()
			set(RUN_SCRIPT_DEBUG
				"\#!/bin/bash\n${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.html"
			)
			dk_fileWrite(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/Run.sh "${RUN_SCRIPT_DEBUG}")
			dk_exec(chmod 777 ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/Run.sh)
		endif()
	endif()
	if(Release)
		if(Windows_Host)
			set(RUN_SCRIPT_RELEASE
				"${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun.bat ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.html"
			)
			dk_fileWrite(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/Run.bat ${RUN_SCRIPT_RELEASE})
		else()
			set(RUN_SCRIPT_RELEASE
				"\#!/bin/bash\n"
				"${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.html"
			)
			dk_fileWrite(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/Run.sh ${RUN_SCRIPT_RELEASE})
			dk_exec(chmod 777 ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/Run.sh)
		endif()
	endif()

	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${Target_App}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:Target_App = $<TARGET_FILE:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:Target_App = $<TARGET_FILE_DIR:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	
	###################### Copy WASM files to /assets #################
	#if(Debug)
	#	add_custom_command(
	#		TARGET ${Target_App} 
	#		POST_BUILD
	#		COMMAND ${CMAKE_COMMAND} -E echo "Copying ${Target_App} Debug wasm files to /assets"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.data" "${Target_App_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.html" "${Target_App_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.js" "${Target_App_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.wasm" "${Target_App_Dir}/assets/")
	#else()
	#	add_custom_command(
	#		TARGET ${Target_App} 
	#		POST_BUILD
	#		COMMAND ${CMAKE_COMMAND} -E echo "Copying ${Target_App} Release wasm files to /assets"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.data" "${Target_App_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.html" "${Target_App_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.js" "${Target_App_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.wasm" "${Target_App_Dir}/assets/")
	#endif()
#endif(Emscripten)


#################
elseif(Ios OR Iossim)
	# https://github.com/forexample/testapp/blob/master/CMakeLists.txt
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(Debug)
			if(EXISTS ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.app)
				dk_delete(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.app.backup)
				dk_rename(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.app ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.app.backup OVERWRITE)
			endif()
		endif()
		if(Release)
			if(EXISTS ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.app)
				dk_delete(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.app.backup)
				dk_rename(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.app ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.app.backup OVERWRITE)
			endif()
		endif()
	endif()
	
	###################### BACKUP USERDATA ###############################
	# Backup files and folders excluded from the package
	#	dk_copy(${Target_App_Dir}/assets/USER ${Target_App_Dir}/Backup/USER OVERWRITE)
	# Remove excluded files and folders before packaging
	#	dk_delete(${Target_App_Dir}/assets/USER)
	# Restore the backed up files, excluded from assets
	#	dk_copy(${Target_App_Dir}/Backup/ ${Target_App_Dir}/assets/)
	#	dk_delete(${Target_App_Dir}/Backup)
	
	########################## ICONS ###############################
	if(EXISTS "${Target_App_Dir}/icons/icon.png")
		dk_createIcons("${Target_App_Dir}/icons/icon.png")
	endif()
	
	####################### Storyboards ############################
	#TODO
		
	####################### Create Executable Target ###################
	file(GLOB_RECURSE m_SRC 
	${Target_App_Dir}/*.m
	${Target_App_Dir}/*.mm)
	list(APPEND App_SRC ${m_SRC})
	#if(HAVE_DK)
	#	list(APPEND App_SRC ${DKCPP_PLUGINS_DIR}/DK/DKAppDelegate.h)
	#	list(APPEND App_SRC ${DKCPP_PLUGINS_DIR}/DK/DKAppDelegate.m)
	#endif()
	add_executable(${Target_App} MACOSX_BUNDLE ${app_ICONS} ${App_SRC} ${RES_FILES})
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
			add_dependencies(${Target_App} ${plugin})
		endif()	
	endforeach()
		
	######################### Create Info.plist #######################
	dk_set(PRODUCT_BUNDLE_IDENTIFIER com.digitalknob.${Target_App})
	dk_set(CFBundleDevelopmentRegion en)
	dk_set(CFBundleDisplayName ${Target_App})
	dk_set(CFBundleExecutable ${Target_App})
	dk_set(CFBundleGetInfoString DigitalKnob)
	dk_set(CFBundleIconFile "icons.icns")
	dk_set(CFBundleIdentifier ${PRODUCT_BUNDLE_IDENTIFIER})
	dk_set(CFBundleInfoDictionaryVersion 6.0)
	dk_set(CFBundleLongVersionString 1.0.0)
	dk_set(CFBundleName ${Target_App})
	dk_set(CFBundlePackageType APPL)
	dk_set(CFBundleShortVersionString 1.0)
	dk_set(CFBundleSignature ????)
	dk_set(CFBundleVersion 1.0)
	#dk_set(LSRequiresIPhoneOS NO)
	dk_set(NSMainNibFile "")
	#dk_set(UILaunchStoryboardName dk)
	#dk_set(UIMainStoryboardFile dk.storyboard)
	set_target_properties(${Target_App} PROPERTIES MACOSX_BUNDLE TRUE MACOSX_BUNDLE_INFO_PLIST ${DKCPP_PLUGINS_DIR}/_DKIMPORT/ios/Info.plist)
	
	###################### Disable bitcode ############################
	set_target_properties(${Target_App} PROPERTIES XCODE_ATTRIBUTE_ENABLE_BITCODE "NO")
	
	###################### Add Assets to Bundle #######################
	add_custom_command(TARGET ${Target_App} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${Target_App_Dir}/assets $<TARGET_FILE_DIR:${Target_App}>/assets)
	#if(EXISTS ${Target_App_Dir}/icons/mac/icons.icns)
	#	add_custom_command(TARGET ${Target_App} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${Target_App_Dir}/icons/ios/icons.icns $<TARGET_FILE_DIR:${Target_App}>/Resources/icons.icns)
	#endif()
	
	############# Link Libraries, Set Startup Project #################
	target_link_libraries(${Target_App} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY XCODE_STARTUP_PROJECT ${Target_App})
	
	################### Create Run.sh #################################
	if(Iossim)
		dk_info("Creating Run.sh . . .")
		if(Debug)
			set(RUN_SCRIPT_DEBUG
				"\#!/bin/bash\n"
				"open -a Simulator.app\n"
				"xcrun simctl install booted ${Target_App_Dir}/iossim_x86_64/Debug-iphonesimulator/${Target_App}.app\n"
				"xcrun simctl launch --console-pty booted com.digitalknob.${Target_App}"
			)
			dk_fileWrite(${Target_App_Dir}/iossim_x86_64/Debug-iphonesimulator/Run.sh ${RUN_SCRIPT_DEBUG})
			dk_exec(chmod 777 ${Target_App_Dir}/iossim_x86_64/Debug-iphonesimulator/Run.sh)
		endif()
		if(Release)
			set(RUN_SCRIPT_RELEASE
				"\#!/bin/bash\n"
				"open -a Simulator.app\n"
				"xcrun simctl install booted ${Target_App_Dir}/iossim_x86_64/Release-iphonesimulator/${Target_App}.app\n"
				"xcrun simctl launch --console-pty booted com.digitalknob.${Target_App}"
			)
			dk_fileWrite(${Target_App_Dir}/iossim_x86_64/Release-iphonesimulator/Run.sh ${RUN_SCRIPT_RELEASE})
			dk_exec(chmod 777 ${Target_App_Dir}/iossim_x86_64/Release-iphonesimulator/Run.sh)
		endif()
	endif()
	
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${Target_App}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:Target_App = $<TARGET_FILE:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:Target_App = $<TARGET_FILE_DIR:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
#endif(Ios OR Iossim)


#########
elseif(Linux)
if(NOT Raspberry)
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(Debug)
			dk_copy(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App} ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.backup OVERWRITE NO_HALT)
		elseif(Release)
			dk_copy(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App} ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.backup OVERWRITE NO_HALT)
		endif()
	endif()
	
	########################## CREATE ICONS ###############################
	if(EXISTS "${Target_App_Dir}/icons/icon.png")
		dk_createIcons("${Target_App_Dir}/icons/icon.png")
	endif()
	#if(EXISTS ${Target_App_Dir}/icons/icon.png)
	#	dk_copy(${Target_App_Dir}/icons/icon.png ${Target_App_Dir}/assets/icon.png OVERWRITE)
	#endif()
	
	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
		dk_copy(${Target_App_Dir}/assets/USER ${Target_App_Dir}/Backup/USER OVERWRITE)
		dk_delete(${Target_App_Dir}/assets/USER)
		# Remove excluded files and folders before packaging
		dk_info("Creating assets.zip . . .")
		dk_compressAssets(${Target_App_Dir}/assets)
		#dk_info("Creating assets.h . . .")
		dk_bin2h(SOURCE_FILE ${Target_App_Dir}/assets.zip HEADER_FILE ${Target_App_Dir}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		dk_copy(${Target_App_Dir}/Backup/ ${Target_App_Dir}/assets/)
		dk_delete(${Target_App_Dir}/Backup)
	endif()
	
	####################### Create Executable Target ###################
	add_executable(${Target_App} ${App_SRC})
	if(Debug)
		target_link_libraries(${Target_App} ${DEBUG_LIBS} ${LIBS})
	elseif(Release)
		target_link_libraries(${Target_App} ${RELEASE_LIBS} ${LIBS})
	endif()
	
	###################### Add Build Dependencies ######################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
			add_dependencies(${Target_App} ${plugin})
		endif()	
	endforeach()
	
	############# Create .desktop Icon Files / Install ################
	## https://specifications.freedesktop.org
	if(Debug)
		set(DESKTOP_FILE
			"[Desktop Entry]\n"
			"Encoding=UTF-8\n"
			"Version=1.0\n"
			"Type=Application\n"
			"Terminal=true\n"
			"Name=${Target_App}\n"
			"Exec=${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}\n"
			"Icon=${Target_App_Dir}/icons/icon.png\n")
		list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
		dk_fileWrite("${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.desktop" "${DESKTOP_FILE}")
	elseif(Release)
		set(DESKTOP_FILE
			"[Desktop Entry]\n"
			"Encoding=UTF-8\n"
			"Version=1.0\n"
			"Type=Application\n"
			"Terminal=true\n"
			"Name=${Target_App}\n"
			"Exec=${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}\n"
			"Icon=${Target_App_Dir}/icons/icon.png\n")
		list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
		dk_fileWrite("${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.desktop" "${DESKTOP_FILE}")
	endif()
	
	# Create windows shortcut for WSL
	if(DEFINED ENV{WSL_DISTRO_NAME})
		dk_info("creating WSL shortcut")
		dk_depend(wsl)
		if(Debug)
			execute_process(COMMAND ${WSLPATH_EXE} -m "${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.lnk" OUTPUT_VARIABLE SHORTCUT_PATH OUTPUT_STRIP_TRAILING_WHITESPACE)
			dk_debug("WSL SHORTCUT_PATH = ${SHORTCUT_PATH}")
			dk_createShortcut("${SHORTCUT_PATH}" "${WSL_EXE}" "${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}")
		elseif(Release)
			execute_process(COMMAND ${WSLPATH_EXE} -m "${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.lnk" OUTPUT_VARIABLE SHORTCUT_PATH OUTPUT_STRIP_TRAILING_WHITESPACE)
			dk_createShortcut("${SHORTCUT_PATH}" "${WSL_EXE}" "${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}")
		endif()
	endif()
	
	# Install shortcut of Release build to the apps menu
	if(NOT TINYCORE)
		if(Debug)
			#dk_exec(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.desktop WORKING_DIRECTORY ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir})
		elseif(Release)
			dk_exec(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.desktop WORKING_DIRECTORY ${Target_App_Dir}/${Target_Tuple}/${Release_Dir})
		endif()
	endif()
		
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${Target_App}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:Target_App = $<TARGET_FILE:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:Target_App = $<TARGET_FILE_DIR:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	#CPP_Execute("chmod +x "+app_path+OS+"/${Debug_Dir}/"+Target_App)
endif(NOT Raspberry)
#endif(Linux)


#######
elseif(Mac)
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(Debug)
			dk_copy(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.app ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.app.backup OVERWRITE NO_HALT)
		endif()
		if(Release)
			dk_copy(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.app ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.app.backup OVERWRITE NO_HALT)
		endif()
	endif()
		
	########################## CREATE ICONS ###############################
	if(EXISTS "${Target_App_Dir}/icons/icon.png")
		dk_createIcons("${Target_App_Dir}/icons/icon.png")
	endif()
	#if(EXISTS ${Target_App_Dir}/icons/icon.png)
	#	dk_mkdir(${Target_App_Dir}/icons/mac)
	#	dk_mkdir(${Target_App_Dir}/icons/mac/icons.iconset)
	#	dk_resizeImage(${Target_App_Dir}/icons/icon.png 16 16 ${Target_App_Dir}/icons/mac/icons.iconset/icon_16x16.png)
	#	dk_resizeImage(${Target_App_Dir}/icons/icon.png 32 32 ${Target_App_Dir}/icons/mac/icons.iconset/icon_16x16@2x.png)
	#	dk_resizeImage(${Target_App_Dir}/icons/icon.png 32 32 ${Target_App_Dir}/icons/mac/icons.iconset/icon_32x32.png)
	#	dk_resizeImage(${Target_App_Dir}/icons/icon.png 64 64 ${Target_App_Dir}/icons/mac/icons.iconset/icon_32x32@2x.png)
	#	dk_resizeImage(${Target_App_Dir}/icons/icon.png 128 128 ${Target_App_Dir}/icons/mac/icons.iconset/icon_128x128.png)
	#	dk_resizeImage(${Target_App_Dir}/icons/icon.png 256 256 ${Target_App_Dir}/icons/mac/icons.iconset/icon_128x128@2x.png)
	#	dk_resizeImage(${Target_App_Dir}/icons/icon.png 256 256 ${Target_App_Dir}/icons/mac/icons.iconset/icon_256x256.png)
	#	dk_resizeImage(${Target_App_Dir}/icons/icon.png 512 512 ${Target_App_Dir}/icons/mac/icons.iconset/icon_256x256@2x.png)
	#	dk_resizeImage(${Target_App_Dir}/icons/icon.png 512 512 ${Target_App_Dir}/icons/mac/icons.iconset/icon_512x512.png)
	#	dk_resizeImage(${Target_App_Dir}/icons/icon.png 1024 1024 ${Target_App_Dir}/icons/mac/icons.iconset/icon_512x512@2x.png)
	#	dk_exec(iconutil -c icns -o ${Target_App_Dir}/icons/mac/icons.icns ${Target_App_Dir}/icons/mac/icons.iconset WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})
	#	set(MACOSX_BUNDLE_ICON_FILE icons.icns)
	#	set(app_ICONS ${Target_App_Dir}/icons/mac/icons.icns)
	#	set_source_files_properties(${app_ICONS} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
	#endif()
		
	################# BACKUP USERDATA / INJECT ASSETS #####################	
	dk_copy(${Target_App_Dir}/assets/USER ${Target_App_Dir}/Backup/USER OVERWRITE NO_HALT)
	dk_delete(${Target_App_Dir}/assets/USER NO_HALT)
	dk_copy(${Target_App_Dir}/Backup/ ${Target_App_Dir}/assets/ OVERWRITE NO_HALT)
	dk_delete(${Target_App_Dir}/Backup NO_HALT)
	
	####################### Create Executable Target ###################
	file(GLOB_RECURSE m_SRC 
		${Target_App_Dir}/*.m
		${Target_App_Dir}/*.mm)
	list(APPEND App_SRC ${m_SRC})
	add_executable(${Target_App} MACOSX_BUNDLE ${app_ICONS} ${App_SRC})
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
			if(NOT ${plugin} MATCHES "DKCefChild")
				add_dependencies(${Target_App} ${plugin})
			endif()
		endif()
	endforeach()
		
	######################### Create Info.plist #######################
	dk_set(PRODUCT_BUNDLE_IDENTIFIER com.digitalknob.${Target_App})
	dk_set(CFBundleDevelopmentRegion en)
	dk_set(CFBundleDisplayName ${Target_App})
	if(MAC_TERMINAL_WRAPPER)
		dk_set(CFBundleExecutable wrapper)
	else()
		dk_set(CFBundleExecutable ${Target_App})
	endif()
	dk_set(CFBundleGetInfoString "DigitalKnob")
	dk_set(CFBundleIconFile "icons.icns")
	#dk_set(CFBundleIconFiles "icons.icns")
	dk_set(CFBundleIdentifier ${PRODUCT_BUNDLE_IDENTIFIER})
	dk_set(CFBundleInfoDictionaryVersion 6.0)
	dk_set(CFBundleLongVersionString "${Target_App}-${APP_VERSION}")
	dk_set(CFBundleName ${Target_App})
	dk_set(CFBundlePackageType APPL)
	dk_set(CFBundleShortVersionString ${APP_VERSION})
	dk_set(CFBundleSignature ????)
	dk_set(CFBundleVersion 1.0)
	#dk_set(LSRequiresIPhoneOS NO)
	dk_set(NSMainNibFile "")
	#dk_set(UILaunchStoryboardName dk)
	#dk_set(UIMainStoryboardFile dk.storyboard)
	set_target_properties(${Target_App} PROPERTIES 
		MACOSX_BUNDLE TRUE 
		XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ""
		MACOSX_BUNDLE_INFO_PLIST ${DKCPP_PLUGINS_DIR}/_DKIMPORT/mac/Info.plist)
		
	############## Delete Exlusions and Copy Assets to Bundle #######################
	if(EXISTS ${Target_App_Dir}/assets)
		dk_delete(${Target_App_Dir}/assets/log.txt)
		dk_delete(${Target_App_Dir}/assets/cef.txt)
		add_custom_command(TARGET ${Target_App} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${Target_App_Dir}/assets $<TARGET_BUNDLE_CONTENT_DIR:${Target_App}>/Resources)
	endif()
		
	############# Link Libraries, Set Startup Project #################
	target_link_libraries(${Target_App} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY XCODE_STARTUP_PROJECT ${Target_App})
	
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${Target_App}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:Target_App = $<TARGET_FILE:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:Target_App = $<TARGET_FILE_DIR:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	
	# Copy the CEF framework into the app bundle
	if(EXISTS ${CEF_BINARY})
		dk_info("Adding Chromium Embedded Framework.framework to bundle . . .")
		add_custom_command(TARGET ${Target_App} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory "${CEF_BINARY}/$<CONFIG>/Chromium Embedded Framework.framework" "$<TARGET_FILE_DIR:${Target_App}>/../Frameworks/Chromium Embedded Framework.framework")
	endif()
	
	# Copy the DKCefChild.app into the app bundle as "DKAppName Helper.app"
	if(EXISTS "${DKCPP_PLUGINS_DIR}/DKCefChild/${Target_Tuple}/${Release_Dir}/DKCefChild.app")
		dk_info("Adding ${Target_App} Helper to bundle . . .")
		add_custom_command(TARGET ${Target_App} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory "${DKCPP_PLUGINS_DIR}/DKCefChild/${Target_Tuple}/$<CONFIG>/DKCefChild.app" "$<TARGET_FILE_DIR:${Target_App}>/../Frameworks/${Target_App} Helper.app")
		add_custom_command(TARGET ${Target_App} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${DKCPP_PLUGINS_DIR}/DKCefChild/${Target_Tuple}/$<CONFIG>/DKCefChild.app/Contents/MacOS/DKCefChild" "$<TARGET_FILE_DIR:${Target_App}>/../Frameworks/${Target_App} Helper.app/Contents/MacOS/${Target_App} Helper")
	endif()
	
	# Make bundle open with Terminal
	# https://github.com/pyinstaller/pyinstaller/issues/5154#issuecomment-690646012
	if(MAC_TERMINAL_WRAPPER)
		dk_info("Making bundle app run in terminal on double-click . . .")
		set(TERMINAL_SCRIPT
			"\#!/bin/bash \ndir=$(cd \"$( dirname \"\${0}\")\" && pwd ) \nOpen -a \"Terminal\" \"\${dir}/${Target_App}\""
			#"\#!/bin/bash \n"
			#"dir=$(cd \"$( dirname \"\${0}\")\" && pwd ) \n"
			#"Open -a \"Terminal\" \"\${dir}/${Target_App}\""
		)
		dk_fileWrite(${Target_App_Dir}/${Target_Tuple}/wrapper ${TERMINAL_SCRIPT})
		dk_exec(chmod +x ${Target_App_Dir}/${Target_Tuple}/wrapper WORKING_DIRECTORY ${Target_App_Dir}/${Target_Tuple})
		add_custom_command(TARGET ${Target_App} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${Target_App_Dir}/${Target_Tuple}/wrapper" "$<TARGET_FILE_DIR:${Target_App}>/wrapper")
	endif()
	
	#CPP_Execute("chmod +x "+app_path+OS+"/${Debug_Dir}/"+Target_App)
#			if(CPP_DKFile_Exists(app_path+"assets/DKCef/mac_x86_64_Debug/Chromium Embedded Framework.framework")){
#				CPP_DKFile_MkDir(app_path+"mac_x86_64/${Debug_Dir}/"+Target_App+".app/Contents/Frameworks")
#				CPP_DKFile_Copy(app_path+"assets/DKCef/mac_x86_64_Debug/Chromium Embedded Framework.framework", app_path+"mac_x86_64/${Debug_Dir}/"+Target_App+".app/Contents/Frameworks/Chromium Embedded Framework.framework", true)
#				if(CPP_DKFile_Exists(DKBRANCH_DIR+"/DKCpp/plugins/DKCefChild/mac_x86_64/${Debug_Dir}/DKCefChild.app")){
#					CPP_DKFile_Copy(DKBRANCH_DIR+"/DKCpp/plugins/DKCefChild/mac_x86_64/${Debug_Dir}/DKCefChild.app", app_path+"mac_x86_64/${Debug_Dir}/"+Target_App+".app/Contents/Frameworks/"+Target_App+" Helper.app", true)
#					CPP_DKFile_Rename(app_path+"mac_x86_64/${Debug_Dir}/"+Target_App+".app/Contents/Frameworks/"+Target_App+" Helper.app/Contents/MacOS/DKCefChild", app_path+"mac_x86_64/${Debug_Dir}/"+Target_App+".app/Contents/Frameworks/"+Target_App+" Helper.app/Contents/MacOS/"+Target_App+" Helper", true)
#				}
#			}
#			//update the info.plist to include the logo icon
#			if(CPP_DKFile_Exists(app_path+OS+"/${Debug_Dir}/"+Target_App+".app/Contents/info.plist")){
#				let info_plist = CPP_DKFile_FileToString(app_path+OS+"/${Debug_Dir}/"+Target_App+".app/Contents/info.plist")
#				info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>")
#				CPP_DKFile_StringToFile(info_plist, app_path+OS+"/${Debug_Dir}/"+Target_App+".app/Contents/info.plist")
#			}
#			//update install_name_tool if cef present
#			if(CPP_DKFile_Exists(app_path+OS+"/${Debug_Dir}/"+Target_App+".app/Contents/Frameworks/Chromium Embedded Framework.framework")){
#				console.log("USING CHROMIUM EMBEDDED FRAMEWORK")
#				let command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+app_path+OS+"/${Debug_Dir}/"+Target_App+".app/Contents/Frameworks/"+Target_App+" Helper.app/Contents/MacOS/"+Target_App+" Helper\""
#				console.log(command)
#				CPP_Execute(command)
#				command = "install_name_tool -add_rpath \"@executable_path/../../../../\" \""+app_path+OS+"/${Debug_Dir}/"+Target_App+".app/Contents/Frameworks/"+Target_App+" Helper.app/Contents/MacOS/"+Target_App+" Helper\""
#				console.log(command)
#				CPP_Execute(command)
#				command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+app_path+OS+"/${Debug_Dir}/"+Target_App+".app/Contents/Frameworks/"+Target_App+" Helper.app/Contents/MacOS/"+Target_App+"\""
#				console.log(command)
#				CPP_Execute(command)
#				command = "install_name_tool -add_rpath \"@executable_path/../\" \""+app_path+OS+"/${Debug_Dir}/"+Target_App+".app/Contents/MacOS/"+Target_App+"\""
#				console.log(command)
#				CPP_Execute(command)
#			}
#			*/
#endif(Mac)


#################
elseif(Raspberry)
	########################## CREATE ICONS ###############################
	if(EXISTS "${Target_App_Dir}/icons/icon.png")
		dk_createIcons("${Target_App_Dir}/icons/icon.png")
	endif()

	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
		dk_copy(${Target_App_Dir}/assets/USER ${Target_App_Dir}/Backup/USER OVERWRITE)
		# Remove excluded files and folders before packaging
		dk_delete(${Target_App_Dir}/assets/USER)
		dk_info("Creating assets.zip . . .")
		dk_compressAssets(${Target_App_Dir}/assets)
		#dk_info("Creating assets.h . . .")
		dk_bin2h(SOURCE_FILE ${Target_App_Dir}/assets.zip HEADER_FILE ${Target_App_Dir}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		dk_copy(${Target_App_Dir}/Backup/ ${Target_App_Dir}/assets/)
		dk_delete(${Target_App_Dir}/Backup)
	endif()
	
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(Debug)
			dk_rename(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App} ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.backup OVERWRITE NO_HALT)
		elseif(Release)
			dk_rename(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App} ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.backup OVERWRITE NO_HALT)
		endif()
	endif()
	
	####################### Create Executable Target ###################
	add_executable(${Target_App} ${App_SRC})
	if(Debug)
		target_link_libraries(${Target_App} ${DEBUG_LIBS} ${LIBS})
	elseif(Release)
		target_link_libraries(${Target_App} ${RELEASE_LIBS} ${LIBS})
	endif()

	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
			add_dependencies(${Target_App} ${plugin})
		endif()	
	endforeach()
		
	############# Create .desktop Icon Files and Install ##############
	## https://specifications.freedesktop.org
	if(Debug)
	# Create .desktop file for Debug
	dk_set(DESKTOP_FILE
		"[Desktop Entry]\n"
		"Encoding=UTF-8\n"
		"Version=1.0\n"
		"Type=Application\n"
		"Terminal=true\n"
		"Name=${Target_App}\n"
		"Exec=${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}\n"
		"Icon=${Target_App_Dir}/icons/icon.png\n")
	list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
	dk_fileWrite(${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.desktop ${DESKTOP_FILE})
	endif()
	if(Release)
	# Create .desktop file for Release
	dk_set(DESKTOP_FILE
		"[Desktop Entry]\n"
		"Encoding=UTF-8\n"
		"Version=1.0\n"
		"Type=Application\n"
		"Terminal=true\n"
		"Name=${Target_App}\n"
		"Exec=${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}\n"
		"Icon=${Target_App_Dir}/icons/icon.png\n")
	list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
	dk_fileWrite(${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.desktop ${DESKTOP_FILE})
	endif()
	
	# Install shortcut of Release build to the apps menu
	if(Release)
		dk_exec(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${Target_App_Dir}/${Target_Tuple}/${Release_Dir}/${Target_App}.desktop WORKING_DIRECTORY ${Target_App_Dir}/${Target_Tuple}/Release)
	endif()
		
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${Target_App}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:Target_App = $<TARGET_FILE:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:Target_App = $<TARGET_FILE_DIR:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	#CPP_Execute("chmod +x "+app_path+OS+"/${Debug_Dir}/"+Target_App)
#endif(Raspberry)


###############
elseif(Windows_X86)
	########################## CREATE ICONS ###############################
	if(EXISTS "${Target_App_Dir}/icons/icon.png")
		dk_createIcons("${Target_App_Dir}/icons/icon.png")
	endif()
	
	################# BACKUP USERDATA / INJECT ASSETS #####################	
	if(HAVE_DK)
		dk_copy(${Target_App_Dir}/assets/USER ${Target_App_Dir}/Backup/USER OVERWRITE NO_HALT)
		dk_delete(${Target_App_Dir}/assets/USER)
		# Compress the assets, they will be included by resource.rc
		dk_info("Creating assets.zip . . .")
		dk_compressAssets(${Target_App_Dir}/assets)
		# Restore the backed up files, excluded from assets
		dk_copy(${Target_App_Dir}/Backup ${Target_App_Dir}/assets OVERWRITE NO_HALT)
		dk_delete(${Target_App_Dir}/Backup)
		dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/assets.h ${Target_App_Dir}/assets.h OVERWRITE) #required
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
		#target_link_libraries(${Target_App} -static -static-libgcc -static-libstdc++ winpthread)# -dynamic)
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
		
		set_target_properties(${Target_App} PROPERTIES LINK_FLAGS_DEBUG ${DEBUG_FLAGS} LINK_FLAGS_RELEASE ${RELEASE_FLAGS})
		
		# remove -bin from Target_App. Was added to avoid app/library same name conflicts
		#set_target_properties(${Target_App} PROPERTIES OUTPUT_NAME ${Target_App})
		#set_target_properties(${Target_App} PROPERTIES RUNTIME_OUTPUT_NAME ${Target_App})
		set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${Target_App})
	endif()
	
	
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${Target_App}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:Target_App = $<TARGET_FILE:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:Target_App = $<TARGET_FILE_DIR:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#	#COMMAND cmd /c ${CMAKE_COMMAND} --build ${Target_App_Dir}/${Target_Tuple} --target ${Target_App}
	#)
	
	#add_custom_command(
    #TARGET ${Target_App}
    #POST_BUILD
    #COMMAND "mt.exe" -nologo
    #        -manifest \"${Target_App_Dir}/compatibility.manifest\"
    #        -outputresource:"${Target_App_Dir}/Windows_X86/${Debug_Dir}/${Target_App}.exe"\;\#1
    #COMMENT "Adding manifest..."
    #)
	
	#CPP_DKFile_Copy(app_path+OS+"/${Release_Dir}/"+Target_App+".pdb", app_path+"assets/"+Target_App+".pdb", true)
	#CPP_Execute(DIGITALKNOB_DIR+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/${Release_Dir}/"+Target_App+".exe")
#endif(Windows_X86)
	

		
##################
elseif(Windows_X86_64)
	########################## CREATE ICONS ###############################
	if(EXISTS "${Target_App_Dir}/icons/icon.png")
		dk_createIcons("${Target_App_Dir}/icons/icon.png")
	endif()
			
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
		
	####################### Do Post Build Stuff #######################
	# "https://gist.github.com/baiwfg2/39881ba703e9c74e95366ed422641609"
	# TEST
	#add_custom_command(
	#	TARGET ${Target_App}
	#	POST_BUILD
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE:Target_App = $<TARGET_FILE:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! TARGET_FILE_DIR:Target_App = $<TARGET_FILE_DIR:${Target_App}>"
	#	COMMAND ${CMAKE_COMMAND} -E echo "!!!!!! CONFIG = $<CONFIG>"
	#)
	#CPP_DKFile_Copy(app_path+OS+"/${Release_Dir}/"+Target_App+".pdb", app_path+"assets/"+Target_App+".pdb", true)
	#CPP_Execute(DIGITALKNOB_DIR+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/${Release_Dir}/"+Target_App+".exe")
#endif(Windows_X86_64)

else()
	dk_error("DKGenerate.cmake:  No Generate Proceedure for Target_Tuple:'${Target_Tuple}'")
endif()


dk_buildLog("\n\n")
dk_buildLog("########### ${Target_App} Post-Generated Compiler Settings ###########")
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
dk_buildLog("###################  ${Target_App} Source Files  ##################")
foreach(src ${App_SRC})
	dk_buildLog(${src})
endforeach()

dk_buildLog("\n\n")
dk_buildLog("###############  ${Target_App} Include Diretories  ##############")
foreach(dir ${DKINCLUDES_LIST})
	dk_buildLog(${dir})
endforeach()

dk_buildLog("\n\n")
dk_buildLog("###############  ${Target_App} Include Libraries  ##############")
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
#if(Linux OR Raspberry OR Android)
#	dk_command(ldd >> ${Target_App_Dir}/${Target_Tuple}/DKBUILD.log)
#elseif(Mac OR IOS)
	# TODO
	#dk_command(otool -L ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.app)
#elseif(Windows)	
	# TODO
	#"C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.30.30705/bin/Hostx86/x86/dumpbin.exe" /dependents ${Target_App_Dir}/${Target_Tuple}/${Debug_Dir}/${Target_App}.exe
#endif()

dk_info("\n\n")
dk_info("******************************************************")
dk_info("****** Generated ${Target_App} - ${Target_Tuple}  ************")
dk_info("******************************************************\n")

