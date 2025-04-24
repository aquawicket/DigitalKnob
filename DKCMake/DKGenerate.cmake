#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(TO_CMAKE_PATH "$ENV{USERPROFILE}$ENV{HOME}/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "$ENV{DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

# This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
#
# For the latest information, see https://github.com/aquawicket/DigitalKnob
#
<<<<<<< HEAD
# Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
=======
# Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
>>>>>>> Development
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
<<<<<<< HEAD

dk_load(${DKCMAKE_DIR}/DKDisabled.cmake)
=======
dk_assertPath("$ENV{DKCMAKE_DIR}/DKDisabled.cmake")
dk_load("$ENV{DKCMAKE_DIR}/DKDisabled.cmake")
>>>>>>> Development

dk_info("\n")
dk_info("############################################################")
dk_info("######################  DigitalKnob  #######################")
dk_info("############################################################")
dk_info("\n")

<<<<<<< HEAD
dk_validate(DK_PROJECT_DIR "dk_TARGET_TRIPLE()")
dk_assertPath(${DK_PROJECT_DIR})
#dk_printVar(DK_PROJECT_DIR)
dk_basename(${DK_PROJECT_DIR} APP_NAME)
=======
dk_validate(DK_Project_Dir "dk_target_triple()")
dk_assertPath(${DK_Project_Dir})

dk_basename(${DK_Project_Dir} APP_NAME)
>>>>>>> Development
dk_replaceAll(${APP_NAME} " " "_" APP_NAME)
set(APP_NAME ${APP_NAME}_APP)

############################################################################################
############################   ADD EXECUTABLE  #############################################
############################################################################################
if(NOT TARGET)
	PROJECT(${APP_NAME})
	dk_set(DKAPP ON)
endif()

<<<<<<< HEAD
##################################################
##### Scan the DKPlugins and build the lists #####
##################################################


dk_load(${DK_PROJECT_DIR}/DKMAKE.cmake)

dk_assertVar(triple)
dk_delete(${DK_PROJECT_DIR}/${triple}/DKBUILD.log NO_HALT)
dk_printSettings()


=======
######################################################
##### Scan the DKCpp/plugins and build the lists #####
######################################################
dk_load(${DK_Project_Dir}/DKINSTALL.cmake)
dk_assertVar(target_triple)
dk_delete(${DK_Project_Dir}/${target_triple}/DKBUILD.log NO_HALT)
dk_printSettings()

>>>>>>> Development
dk_buildLog("##############################################")
dk_buildLog("######  Enabled Dependencies (sorted)  #######")
dk_buildLog("##############################################")
#dk_printVar(dkdepend_list)
list(REMOVE_DUPLICATES dkdepend_list)
foreach(plugin ${dkdepend_list})
	if(NOT plugin IN_LIST dk_disabled_list)
<<<<<<< HEAD
		#dk_verbose("if(NOT ${plugin} IN_LIST dk_disabled_list) = true")
=======
>>>>>>> Development
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

<<<<<<< HEAD
	# This executes the 3rdParty library builds, and creates CMakeLists.txt files for DKPlugins
	dk_info("dk_load(${plugin_path}/DKMAKE.cmake)")
	dk_load(${plugin_path}/DKMAKE.cmake)
=======
	# This executes the 3rdParty library builds, and creates CMakeLists.txt files for DKCpp/plugins
	dk_info("dk_depend(${plugin})")
	dk_depend(${plugin})
>>>>>>> Development
	
	#check that each library is using the proper variables. Should be UPPERCASE plugin name.   I.E. boost = ${BOOST}
	if(NOT ${plugin})
		if(plugin IN_LIST dk_disabled_list)
<<<<<<< HEAD
			#dk_verbose("if(NOT ${plugin} IN_LIST dk_disabled_list) = true")
			#dk_buildLog("${plugin}")
=======
>>>>>>> Development
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
<<<<<<< HEAD
			#	add_subdirectory(${${PLUGIN_NAME}} ${${PLUGIN_NAME}}/${triple})
			#else()
			#	if(DEBUG)
			#		add_subdirectory(${plugin_path} ${plugin_path}/${triple}/Debug)
			#	elseif(RELEASE)
			#		add_subdirectory(${plugin_path} ${plugin_path}/${triple}/Release)
			#	endif()
			#endif()
=======
			#	add_subdirectory(${${PLUGIN_NAME}} ${${PLUGIN_NAME}}/${target_triple})
			#else()
			#	if(DEBUG)
			#		add_subdirectory(${plugin_path} ${plugin_path}/${target_triple}/Debug)
			#	elseif(RELEASE)
			#		add_subdirectory(${plugin_path} ${plugin_path}/${target_triple}/Release)
			#	endif()
			#endif()
			dk_debug("adding ${${PLUGIN_NAME}}")
>>>>>>> Development
			add_subdirectory(${${PLUGIN_NAME}} ${${PLUGIN_NAME}}/${CONFIG_PATH})
		endif()
	endif(PROJECT_INCLUDE_3RDPARTY)
	
<<<<<<< HEAD
	#install(TARGETS <target_name> DESTINATION ${DIGITALKNOB_DIR}/DKInstall/lib/${triple})
	#install(FILES file.h DESTINATION ${DIGITALKNOB_DIR}/DKInstall/lib/${triple})
	
	####################### DKPlugins #######################
	# Libraries in the /DKPlugins folder
=======
	#install(TARGETS <target_name> DESTINATION $ENV{DIGITALKNOB_DIR}/DKInstall/lib/${target_triple})
	#install(FILES file.h DESTINATION $ENV{DIGITALKNOB_DIR}/DKInstall/lib/${target_triple})
	
	####################### DKCpp/plugins #######################
	# Libraries in the /DKCpp/plugins folder
>>>>>>> Development
	dk_toLower("${DKPLUGIN_LIST}" DKPLUGIN_LIST_lower)
	dk_toLower("${plugin}" plugin_lower)
	string(FIND "${DKPLUGIN_LIST_lower}" "${plugin_lower}" isDKPlugin)
	
<<<<<<< HEAD
	
=======
>>>>>>> Development
	# Install 3rd Party Libs
	if(INSTALL_DKLIBS)
		if(${isDKPlugin} EQUAL -1)
			if(EXISTS ${plugin_path}/${CONFIG_PATH}/cmake_install.cmake)
				dk_queueCommand(${CMAKE_COMMAND} --install ${plugin_path}/${CONFIG_PATH})
			endif()
		endif()
	endif(INSTALL_DKLIBS)
	
<<<<<<< HEAD
	
=======
>>>>>>> Development
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
<<<<<<< HEAD
				#	add_subdirectory(${plugin_path} ${plugin_path}/${triple})
				#else()
				#	if(DEBUG)
				#		add_subdirectory(${plugin_path} ${plugin_path}/${triple}/Debug)
				#	elseif(RELEASE)
				#		add_subdirectory(${plugin_path} ${plugin_path}/${triple}/Release)
=======
				#	add_subdirectory(${plugin_path} ${plugin_path}/${target_triple})
				#else()
				#	if(DEBUG)
				#		add_subdirectory(${plugin_path} ${plugin_path}/${target_triple}/Debug)
				#	elseif(RELEASE)
				#		add_subdirectory(${plugin_path} ${plugin_path}/${target_triple}/Release)
>>>>>>> Development
				#	endif()
				#endif()
				add_subdirectory(${plugin_path} ${plugin_path}/${CONFIG_PATH})
			endif()
		endif()
		
<<<<<<< HEAD
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
					ANDROID_ARM32_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM32=ON ${plugin_path})
					ANDROID_ARM64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM64=ON ${plugin_path})
					ANDROID_X86_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_X86=ON ${plugin_path})
					ANDROID_X86_64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_X86_64=ON ${plugin_path})
					EMSCRIPTEN_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DEMSCRIPTEN=ON ${plugin_path})
					IOS_ARM32_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOS_ARM32=ON ${plugin_path})
					IOS_ARM64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOS_ARM64=ON ${plugin_path})
					IOSSIM_X86_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86=ON ${plugin_path})
					IOSSIM_X86_64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86_64=ON ${plugin_path})
					LINUX_X86_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DLINUX_X86=ON ${plugin_path})
					LINUX_X86_64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DLINUX_X86_64=ON ${plugin_path})
					MAC_X86_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DMAC_X86=ON ${plugin_path})
					MAC_X86_64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DMAC_X86_64=ON ${plugin_path})
					RASPBERRY_ARM32_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM32=ON ${plugin_path})
					RASPBERRY_ARM64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM64=ON ${plugin_path})
					WIN_X86_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DWIN_X86=ON ${plugin_path})
					WIN_X86_64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DWIN_X86_64=ON ${plugin_path})
					DEBUG_dk_queueCommand			(${CMAKE_COMMAND} --build . --config Debug)
					RELEASE_dk_queueCommand			(${CMAKE_COMMAND} --build . --config Release)
				else()
					if(DEBUG)
						ANDROID_ARM32_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_ARM32=ON ${plugin_path})
						ANDROID_ARM64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_ARM64=ON ${plugin_path})
						ANDROID_X86_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_X86=ON ${plugin_path})
						ANDROID_X86_64_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_X86_64=ON ${plugin_path})
						EMSCRIPTEN_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DEMSCRIPTEN=ON ${plugin_path})
						IOS_ARM32_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOS_ARM32=ON ${plugin_path})
						IOS_ARM64_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOS_ARM64=ON ${plugin_path})
						IOSSIM_X86_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOSSIM_X86=ON ${plugin_path})
						IOSSIM_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOSSIM_X86_64=ON ${plugin_path})
						LINUX_X86_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DLINUX_X86=ON ${plugin_path})
						LINUX_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DLINUX_X86_64=ON ${plugin_path})
						MAC_X86_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DMAC_X86=ON ${plugin_path})
						MAC_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DMAC_X86_64=ON ${plugin_path})
						RASPBERRY_ARM32_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DRASPBERRY_ARM32=ON ${plugin_path})
						RASPBERRY_ARM64_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DRASPBERRY_ARM64=ON ${plugin_path})
						WIN_X86_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DWIN_X86=ON ${plugin_path})
						WIN_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DWIN_X86_64=ON ${plugin_path})
						DEBUG_dk_queueCommand					(${CMAKE_COMMAND} --build . --config Debug)
					elseif(RELEASE)
						ANDROID_ARM32_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM32=ON ${plugin_path})
						ANDROID_ARM64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM64=ON ${plugin_path})
						ANDROID_X86_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_X86=ON ${plugin_path})
						ANDROID_X86_64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_X86_64=ON ${plugin_path})
						EMSCRIPTEN_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DEMSCRIPTEN=ON ${plugin_path})
						IOS_ARM32_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOS_ARM32=ON ${plugin_path})
						IOS_ARM64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOS_ARM64=ON ${plugin_path})
						IOSSIM_X86_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86=ON ${plugin_path})
						IOSSIM_X86_64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86_64=ON ${plugin_path})
						LINUX_X86_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DLINUX_X86=ON ${plugin_path})
						LINUX_X86_64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DLINUX_X86_64=ON ${plugin_path})
						MAC_X86_RELEASE_dk_queueCommand			(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DMAC_X86=ON ${plugin_path})
						MAC_X86_64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DMAC_X86_64=ON ${plugin_path})
						RASPBERRY_ARM32_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM32=ON ${plugin_path})
						RASPBERRY_ARM64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM64=ON ${plugin_path})
						WIN_X86_RELEASE_dk_queueCommand			(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DWIN_X86=ON ${plugin_path})
						WIN_X86_64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DWIN_X86_64=ON ${plugin_path})
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
	
=======
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
#				dk_chdir(${plugin_path}/${CONFIG_PATH})
#				
#				if(MULTI_CONFIG)
#					dk_fatal("This is still being used")
#					###### Configure ######
#					ANDROID_ARM32_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM32=ON 	${plugin_path})
#					ANDROID_ARM64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM64=ON 	${plugin_path})
#					ANDROID_X86_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_X86=ON 	${plugin_path})
#					ANDROID_X86_64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DANDROID_X86_64=ON 	${plugin_path})
#					EMSCRIPTEN_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DEMSCRIPTEN=ON 		${plugin_path})
#					IOS_ARM32_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOS_ARM32=ON 		${plugin_path})
#					IOS_ARM64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOS_ARM64=ON 		${plugin_path})
#					IOSSIM_X86_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86=ON 		${plugin_path})
#					IOSSIM_X86_64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86_64=ON 	${plugin_path})
#					LINUX_X86_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DLINUX_X86=ON 		${plugin_path})
#					LINUX_X86_64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DLINUX_X86_64=ON 	${plugin_path})
#					MAC_X86_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DMAC_X86=ON 		${plugin_path})
#					MAC_X86_64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DMAC_X86_64=ON 		${plugin_path})
#					RASPBERRY_ARM32_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM32=ON ${plugin_path})
#					RASPBERRY_ARM64_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM64=ON ${plugin_path})
#					WIN_X86_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DWIN_X86=ON 		${plugin_path})
#					WIN_X86_64_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DWIN_X86_64=ON 		${plugin_path})
#					
#					###### Build ######
#					DEBUG_dk_queueCommand			(${CMAKE_COMMAND} --build . --config Debug)
#					RELEASE_dk_queueCommand			(${CMAKE_COMMAND} --build . --config Release)
#				else()
#					dk_fatal("This is still being used")
#					if(DEBUG)
#						dk_fatal("This is still being used")
#						###### Configure ######
#						ANDROID_ARM32_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_ARM32=ON 	${plugin_path})
#						ANDROID_ARM64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_ARM64=ON 	${plugin_path})
#						ANDROID_X86_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_X86=ON 		${plugin_path})
#						ANDROID_X86_64_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DANDROID_X86_64=ON 	${plugin_path})
#						EMSCRIPTEN_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DEMSCRIPTEN=ON 		${plugin_path})
#						IOS_ARM32_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOS_ARM32=ON 		${plugin_path})
#						IOS_ARM64_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOS_ARM64=ON 		${plugin_path})
#						IOSSIM_X86_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOSSIM_X86=ON 		${plugin_path})
#						IOSSIM_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DIOSSIM_X86_64=ON 	${plugin_path})
#						LINUX_X86_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DLINUX_X86=ON 		${plugin_path})
#						LINUX_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DLINUX_X86_64=ON 	${plugin_path})
#						MAC_X86_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DMAC_X86=ON 			${plugin_path})
#						MAC_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DMAC_X86_64=ON 		${plugin_path})
#						RASPBERRY_ARM32_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DRASPBERRY_ARM32=ON 	${plugin_path})
#						RASPBERRY_ARM64_DEBUG_dk_queueCommand	(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DRASPBERRY_ARM64=ON 	${plugin_path})
#						WIN_X86_DEBUG_dk_queueCommand			(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DWIN_X86=ON 			${plugin_path})
#						WIN_X86_64_DEBUG_dk_queueCommand		(${DKCMAKE_BUILD} -DDEBUG=ON -DREBUILD=ON -DWIN_X86_64=ON 		${plugin_path})
#						
#						###### Build ######
#						DEBUG_dk_queueCommand					(${CMAKE_COMMAND} --build . --config Debug)
#						
#					elseif(RELEASE)
#						dk_fatal("This is still being used")
#						###### Configure ######
#						ANDROID_ARM32_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM32=ON 		${plugin_path})
#						ANDROID_ARM64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_ARM64=ON 		${plugin_path})
#						ANDROID_X86_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_X86=ON 		${plugin_path})
#						ANDROID_X86_64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DANDROID_X86_64=ON 	${plugin_path})
#						EMSCRIPTEN_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DEMSCRIPTEN=ON 		${plugin_path})
#						IOS_ARM32_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOS_ARM32=ON 			${plugin_path})
#						IOS_ARM64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOS_ARM64=ON 			${plugin_path})
#						IOSSIM_X86_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86=ON 		${plugin_path})
#						IOSSIM_X86_64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DIOSSIM_X86_64=ON 		${plugin_path})
#						LINUX_X86_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DLINUX_X86=ON 			${plugin_path})
#						LINUX_X86_64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DLINUX_X86_64=ON 		${plugin_path})
#						MAC_X86_RELEASE_dk_queueCommand			(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DMAC_X86=ON 			${plugin_path})
#						MAC_X86_64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DMAC_X86_64=ON 		${plugin_path})
#						RASPBERRY_ARM32_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM32=ON 	${plugin_path})
#						RASPBERRY_ARM64_RELEASE_dk_queueCommand	(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DRASPBERRY_ARM64=ON 	${plugin_path})
#						WIN_X86_RELEASE_dk_queueCommand			(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DWIN_X86=ON 			${plugin_path})
#						WIN_X86_64_RELEASE_dk_queueCommand		(${DKCMAKE_BUILD} -DRELEASE=ON -DREBUILD=ON -DWIN_X86_64=ON 		${plugin_path})
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
#							if(EXISTS ${plugin_path}/${CONFIG_PATH}/cmake_install.cmake)
#								dk_queueCommand(${CMAKE_COMMAND} --install ${plugin_path}/${CONFIG_PATH})
#							endif()
#						endif()
#					endif()
#				endforeach()
#
#			endif(PREBUILD)
#		endif(NOT PROJECT_INCLUDE_DKPLUGINS)
	else()
>>>>>>> Development
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
<<<<<<< HEAD
	endif(${isDKPlugin} GREATER -1) # isDKPlugin
	
=======
	endif(${isDKPlugin} GREATER -1)
>>>>>>> Development
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
<<<<<<< HEAD
	dk_fileWrite("${DK_PROJECT_DIR}/DKPlugins.h" "${PLUGINS_FILE}")
=======
	dk_fileWrite("${DK_Project_Dir}/DKPlugins.h" "${PLUGINS_FILE}")
>>>>>>> Development
endif()

if(HAVE_DK)
	## copy app default files without overwrite
<<<<<<< HEAD
	dk_info("Copying DKPlugins/_DKIMPORT/ to App...")
	dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/icons ${DK_PROJECT_DIR}/icons) 
	dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/assets.h ${DK_PROJECT_DIR}/assets.h)
	dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/main.cpp ${DK_PROJECT_DIR}/main.cpp)
endif()

# Copy VSCode project files to app
dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/DKApp.code-workspace ${DK_PROJECT_DIR}/DKApp.code-workspace)
dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/.vscode ${DK_PROJECT_DIR}/.vscode)
=======
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

<<<<<<< HEAD
	
add_definitions(-DDKAPP)
include_directories(${DK_PROJECT_DIR})
include_directories(${DKPLUGINS_DIR})
=======
add_definitions(-DDKAPP)
include_directories(${DK_Project_Dir})
include_directories(${DKCPP_PLUGINS_DIR})
>>>>>>> Development


###########
if(ANDROID)
	################################ CMAKE_ANDROID_GUI ########################################
<<<<<<< HEAD
	#set(CMAKE_ANDROID_GUI 1)
	# CMAKE_ANDROID_GUI is set to 1 by DKSDLWindow/DKCMake.cmake
	
	if(CMAKE_ANDROID_GUI)
		########################## CREATE ICONS ###############################
		dk_createIcons(${DK_PROJECT_DIR}/icons/icon.png)
		#if(EXISTS ${DK_PROJECT_DIR}/icons/icon.png)
		#	dk_info("Creating android icons for ${APP_NAME} . . .")
		#	if(DEBUG)
		#		dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 36 36 ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/app/src/main/res/mipmap-ldpi/ic_launcher.png)
		#		dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 48 48 ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/app/src/main/res/mipmap-mdpi/ic_launcher.png)
		#		dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 72 72 ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/app/src/main/res/mipmap-hdpi/ic_launcher.png)
		#		dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 96 96 ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/app/src/main/res/mipmap-xhdpi/ic_launcher.png)
		#		dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 144 144 ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/app/src/main/res/mipmap-xxhdpi/ic_launcher.png)
		#		dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 192 192 ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png)
		#	endif()
		#	if(RELEASE)
		#		dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 36 36 ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/app/src/main/res/mipmap-ldpi/ic_launcher.png)
		#		dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 48 48 ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/app/src/main/res/mipmap-mdpi/ic_launcher.png)
		#		dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 72 72 ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/app/src/main/res/mipmap-hdpi/ic_launcher.png)
		#		dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 96 96 ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/app/src/main/res/mipmap-xhdpi/ic_launcher.png)
		#		dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 144 144 ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/app/src/main/res/mipmap-xxhdpi/ic_launcher.png)
		#		dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 192 192 ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png)
		#	endif()
		#
		#	dk_copy(${DK_PROJECT_DIR}/icons/icon.png ${DK_PROJECT_DIR}/assets/icon.png OVERWRITE)
=======
	if(CMAKE_ANDROID_GUI) # CMAKE_ANDROID_GUI is set to 1 by DKSDLWindow/DKCMake.cmake
		########################## CREATE ICONS ###############################
		if(EXISTS "${DK_Project_Dir}/icons/icon.png")
			dk_createIcons("${DK_Project_Dir}/icons/icon.png")
		endif()
		#if(EXISTS ${DK_Project_Dir}/icons/icon.png)
		#	dk_copy(${DK_Project_Dir}/icons/icon.png ${DK_Project_Dir}/assets/icon.png OVERWRITE)
>>>>>>> Development
		#endif()
	
		###################### Backup Executable ###########################
		if(BACKUP_APP_EXECUTABLES)
			if(MULTI_CONFIG)
<<<<<<< HEAD
				DEBUG_dk_rename(${DK_PROJECT_DIR}/${triple}/app/build/outputs/apk/debug/app-debug.apk ${DK_PROJECT_DIR}/${triple}/app/build/outputs/apk/app-debug.apk.backup OVERWRITE NO_HALT)
				RELEASE_dk_rename(${DK_PROJECT_DIR}/${triple}/app/build/outputs/apk/release/app-release-unsigned.apk ${DK_PROJECT_DIR}/${triple}/app/build/outputs/apk/release/app-release-unsigned.apk.backup OVERWRITE NO_HALT)
			else()
				DEBUG_dk_rename(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/app/build/outputs/apk/debug/app-debug.apk ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/app/build/outputs/apk/app-debug.apk.backup OVERWRITE NO_HALT)
				RELEASE_dk_rename(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/app/build/outputs/apk/release/app-release-unsigned.apk ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/app/build/outputs/apk/release/app-release-unsigned.apk.backup OVERWRITE NO_HALT)
=======
				if(DEBUG)
					dk_rename(${DK_Project_Dir}/${target_triple}/app/build/outputs/apk/debug/app-debug.apk ${DK_Project_Dir}/${target_triple}/app/build/outputs/apk/app-debug.apk.backup OVERWRITE NO_HALT)
				endif()
				if(RELEASE)
					dk_rename(${DK_Project_Dir}/${target_triple}/app/build/outputs/apk/release/app-release-unsigned.apk ${DK_Project_Dir}/${target_triple}/app/build/outputs/apk/release/app-release-unsigned.apk.backup OVERWRITE NO_HALT)
				endif()
			else()
				if(DEBUG)
					dk_rename(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/app/build/outputs/apk/debug/app-debug.apk ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/app/build/outputs/apk/app-debug.apk.backup OVERWRITE NO_HALT)
				endif()
				if(RELEASE)
					dk_rename(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/app/build/outputs/apk/release/app-release-unsigned.apk ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/app/build/outputs/apk/release/app-release-unsigned.apk.backup OVERWRITE NO_HALT)
				endif()
>>>>>>> Development
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
<<<<<<< HEAD
			dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/android/ ${DK_PROJECT_DIR}/${triple}/Debug)
			dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/${triple}/ ${DK_PROJECT_DIR}/${triple}/Debug)
			dk_copy(${DK_PROJECT_DIR}/assets ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/app/src/main/assets OVERWRITE)
			dk_fileWrite(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/local.properties ${localProperties})
			dk_fileReplace(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/app/src/main/res/values/strings.xml "_DKIMPORT" "${APP_NAME}" NO_HALT)
			UNIX_HOST_dk_executeProcess(chmod 777 ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/gradlew)
			UNIX_HOST_dk_executeProcess(sed -i -e "s/\r$//" "${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/gradlew")
			#TODO: set GRADLE_USER_HOME environment variable. Location of .gradle cache
		endif()
		if(RELEASE)
			dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/android/ ${DK_PROJECT_DIR}/${triple}/Release)
			dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/${triple}/ ${DK_PROJECT_DIR}/${triple}/Release)
			dk_copy(${DK_PROJECT_DIR}/assets ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/app/src/main/assets OVERWRITE)
			dk_fileWrite(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/local.properties ${localProperties})
			dk_fileReplace(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/app/src/main/res/values/strings.xml "_DKIMPORT" "${APP_NAME}" NO_HALT)
			UNIX_HOST_dk_executeProcess(chmod 777 ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/gradlew)
			UNIX_HOST_dk_executeProcess(sed -i -e "s/\r$//" "${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/gradlew")
=======
			dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/android/ ${DK_Project_Dir}/${target_triple}/Debug)
			if(EXISTS ${DKCPP_PLUGINS_DIR}/_DKIMPORT/${target_triple})
				dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/${target_triple}/ ${DK_Project_Dir}/${target_triple}/Debug)
			endif()
			dk_copy(${DK_Project_Dir}/assets ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/app/src/main/assets OVERWRITE)
			dk_fileWrite(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/local.properties ${localProperties})
			dk_fileReplace(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/app/src/main/res/values/strings.xml "_DKIMPORT" "${APP_NAME}" NO_HALT)
			if(UNIX_HOST)
				dk_exec(chmod 777 ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/gradlew)
				dk_exec(sed -i -e "s/\r$//" "${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/gradlew")
			endif()
			#TODO: set GRADLE_USER_HOME environment variable. Location of .gradle cache
		endif()
		if(RELEASE)
			dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/android/ ${DK_Project_Dir}/${target_triple}/Release)
			dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/${target_triple}/ ${DK_Project_Dir}/${target_triple}/Release)
			dk_copy(${DK_Project_Dir}/assets ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/app/src/main/assets OVERWRITE)
			dk_fileWrite(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/local.properties ${localProperties})
			dk_fileReplace(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/app/src/main/res/values/strings.xml "_DKIMPORT" "${APP_NAME}" NO_HALT)
			if(UNIX_HOST)
				dk_exec(chmod 777 ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/gradlew)
				dk_exec(sed -i -e "s/\r$//" "${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/gradlew")
			endif()
>>>>>>> Development
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
<<<<<<< HEAD
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
=======
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
>>>>>>> Development
			add_dependencies(main ${plugin})
		endif()	
	endforeach()
	
	######################### Link Libraries ###########################
<<<<<<< HEAD
	#target_link_libraries(${APP_NAME} ${DEBUG_LIBS} ${RELEASE_LIBS} ${LIBS})
	#target_include_directories(${APP_NAME} PUBLIC ${SDL2}/include)
	
=======
>>>>>>> Development
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
<<<<<<< HEAD
		if(WIN_HOST)
			dk_command(${OPENJDK}/registerJDK.cmd)
		endif()
		dk_load(${DKIMPORTS_DIR}/gradle/DKMAKE.cmake)
=======
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
	
>>>>>>> Development
		if(DEBUG)
			add_custom_command(
				TARGET main
				POST_BUILD
				COMMAND ${CMAKE_COMMAND} -E echo "Building with Gradle"
<<<<<<< HEAD
				COMMAND ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/gradlew --gradle-user-home ${GRADLE_USER_HOME} --project-dir ${DK_PROJECT_DIR}/${triple}/Debug --info clean build #--offline
=======
				COMMAND ${setVar} JAVA_HOME=$ENV{JAVA_HOME} && ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/gradlew${bat} --gradle-user-home ${GRADLE_USER_HOME} --project-dir ${DK_Project_Dir}/${target_triple}/Debug --info clean build #--offline
>>>>>>> Development
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished building with Gradle"
				WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
				VERBATIM)
		endif()
		if(RELEASE)
			add_custom_command(
				TARGET main
				POST_BUILD
				COMMAND ${CMAKE_COMMAND} -E echo "Building with Gradle"
<<<<<<< HEAD
				COMMAND ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/gradlew --gradle-user-home ${GRADLE_USER_HOME} --project-dir ${DK_PROJECT_DIR}/${triple}/Release --info clean build #--offline
=======
				COMMAND ${setVar} "JAVA_HOME=$ENV{JAVA_HOME}" & ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/gradlew${bat} --gradle-user-home ${GRADLE_USER_HOME} --project-dir ${DK_Project_Dir}/${target_triple}/Release --info clean build #--offline
>>>>>>> Development
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
<<<<<<< HEAD
		if(WIN_HOST)
			set(CMD "cmd /c")
		endif()
		
		if(DEBUG)		
=======
		dk_depend(cmd)	
		if(DEBUG)
			dk_validate(CMD_EXE "dk_CMD_EXE()")
>>>>>>> Development
			add_custom_command(
				POST_BUILD
				TARGET main
				COMMAND ${CMAKE_COMMAND} -E echo "Installing <app-debug.apk> to device"
<<<<<<< HEAD
				COMMAND ${CMD} ${ANDROID_SDK}/platform-tools/adb install -r ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/app/build/outputs/apk/debug/app-debug.apk
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished installing <app-debug.apk> to device")
		if(RELEASE)
		endif()
=======
				COMMAND ${CMD_EXE} ${ANDROID_SDK}/platform-tools/adb install -r ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/app/build/outputs/apk/debug/app-debug.apk
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished installing <app-debug.apk> to device")
		if(RELEASE)
		endif()
			dk_validate(CMD_EXE "dk_CMD_EXE()")
>>>>>>> Development
			add_custom_command(
				POST_BUILD
				TARGET main
				COMMAND ${CMAKE_COMMAND} -E echo "Installing <app-release-unsigned.apk> to device"
<<<<<<< HEAD
				COMMAND ${CMD} ${ANDROID_SDK}/platform-tools/adb install -r ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/app/build/outputs/apk/release/app-release-unsigned.apk
=======
				COMMAND ${CMD_EXE} ${ANDROID_SDK}/platform-tools/adb install -r ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/app/build/outputs/apk/release/app-release-unsigned.apk
>>>>>>> Development
				COMMAND ${CMAKE_COMMAND} -E echo "Finnished installing <app-release-unsigned.apk> to device")
		endif()
	endif()
endif(ANDROID)


<<<<<<< HEAD
=======
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
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()
endif(COSMOPOLITAN)


>>>>>>> Development
##############
if(EMSCRIPTEN)
	# TODO: https://schellcode.github.io/webassembly-without-emscripten
	
	########################## CREATE ICONS ###############################
<<<<<<< HEAD
	dk_createIcons(${DK_PROJECT_DIR}/icons/icon.png)
	#if(EXISTS ${DK_PROJECT_DIR}/icons/icon.png)
	#	dk_copy(${DK_PROJECT_DIR}/icons/icon.png ${DK_PROJECT_DIR}/assets/icon.png OVERWRITE)
	#endif()

	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
		dk_copy(${DK_PROJECT_DIR}/assets/USER ${DK_PROJECT_DIR}/Backup/USER OVERWRITE NO_HALT)
		# Remove excluded files and folders before packaging
		dk_delete(${DK_PROJECT_DIR}/assets/USER)
		dk_info("Creating assets.zip . . .")
		dk_compressAssets(${DK_PROJECT_DIR}/assets)
		#dk_info("Creating assets.h . . .")
		dk_bin2h(SOURCE_FILE ${DK_PROJECT_DIR}/assets.zip HEADER_FILE ${DK_PROJECT_DIR}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		dk_copy(${DK_PROJECT_DIR}/Backup/ ${DK_PROJECT_DIR}/assets/)
		dk_delete(${DK_PROJECT_DIR}/Backup)
=======
	if(EXISTS "${DK_Project_Dir}/icons/icon.png")
		dk_createIcons("${DK_Project_Dir}/icons/icon.png")
	endif()

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
>>>>>>> Development
	endif()
	
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
<<<<<<< HEAD
			dk_rename(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.data ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.data.backup OVERWRITE NO_HALT)
			dk_rename(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.html ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.html.backup OVERWRITE NO_HALT)
			dk_rename(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.js ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.js.backup OVERWRITE NO_HALT)
			dk_rename(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.wasm ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.wasm.backup OVERWRITE NO_HALT)
		elseif(RELEASE)
			dk_rename(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.data ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.data.backup OVERWRITE NO_HALT)
			dk_rename(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.html ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.html.backup OVERWRITE NO_HALT)
			dk_rename(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.js ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.js.backup OVERWRITE NO_HALT)
			dk_rename(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.wasm ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.wasm.backup OVERWRITE NO_HALT)
=======
			dk_rename(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.data ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.data.backup OVERWRITE NO_HALT)
			dk_rename(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.html ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.html.backup OVERWRITE NO_HALT)
			dk_rename(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.js ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.js.backup OVERWRITE NO_HALT)
			dk_rename(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.wasm ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.wasm.backup OVERWRITE NO_HALT)
		elseif(RELEASE)
			dk_rename(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.data ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.data.backup OVERWRITE NO_HALT)
			dk_rename(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.html ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.html.backup OVERWRITE NO_HALT)
			dk_rename(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.js ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.js.backup OVERWRITE NO_HALT)
			dk_rename(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.wasm ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.wasm.backup OVERWRITE NO_HALT)
>>>>>>> Development
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
<<<<<<< HEAD
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
=======
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
>>>>>>> Development
			add_dependencies(${APP_NAME} ${plugin})
		endif()	
	endforeach()

	########## Remove previous built files from assets #################
<<<<<<< HEAD
	dk_delete(${DK_PROJECT_DIR}/assets/${APP_NAME}.data NO_HALT)
	dk_delete(${DK_PROJECT_DIR}/assets/${APP_NAME}.html NO_HALT)
	dk_delete(${DK_PROJECT_DIR}/assets/${APP_NAME}.js NO_HALT)
	dk_delete(${DK_PROJECT_DIR}/assets/${APP_NAME}.wasm NO_HALT)

	########################## PACKAGE ASSETS ##########################
	if(EXISTS ${DK_PROJECT_DIR}/assets)
		set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS "-sASSERTIONS -sALLOW_MEMORY_GROWTH --preload-file ${DK_PROJECT_DIR}/assets@/")
=======
	dk_delete(${DK_Project_Dir}/assets/${APP_NAME}.data NO_HALT)
	dk_delete(${DK_Project_Dir}/assets/${APP_NAME}.html NO_HALT)
	dk_delete(${DK_Project_Dir}/assets/${APP_NAME}.js NO_HALT)
	dk_delete(${DK_Project_Dir}/assets/${APP_NAME}.wasm NO_HALT)

	########################## PACKAGE ASSETS ##########################
	if(EXISTS ${DK_Project_Dir}/assets)
		set_target_properties(${APP_NAME} PROPERTIES LINK_FLAGS "-sASSERTIONS -sALLOW_MEMORY_GROWTH --preload-file ${DK_Project_Dir}/assets@/")
>>>>>>> Development
	endif()
	
	################### Create Run.sh #################################
	dk_info("Creating Run scripts . . .")
	if(DEBUG)
		if(WIN_HOST)
			set(RUN_SCRIPT_DEBUG
<<<<<<< HEAD
				"${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun.bat ${DK_PROJECT_DIR}/emscripten/${DEBUG_DIR}/${APP_NAME}.html"
			)
			dk_fileWrite(${DK_PROJECT_DIR}/emscripten/${DEBUG_DIR}/Run.bat ${RUN_SCRIPT_DEBUG})
		else()
			set(RUN_SCRIPT_DEBUG
				"\#!/bin/bash\n${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun ${DK_PROJECT_DIR}/emscripten/${DEBUG_DIR}/${APP_NAME}.html"
			)
			dk_fileWrite(${DK_PROJECT_DIR}/emscripten/${DEBUG_DIR}/Run.sh "${RUN_SCRIPT_DEBUG}")
			dk_executeProcess(chmod 777 ${DK_PROJECT_DIR}/emscripten/${DEBUG_DIR}/Run.sh)
=======
				"${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun.bat ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.html"
			)
			dk_fileWrite(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/Run.bat ${RUN_SCRIPT_DEBUG})
		else()
			set(RUN_SCRIPT_DEBUG
				"\#!/bin/bash\n${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.html"
			)
			dk_fileWrite(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/Run.sh "${RUN_SCRIPT_DEBUG}")
			dk_exec(chmod 777 ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/Run.sh)
>>>>>>> Development
		endif()
	endif()
	if(RELEASE)
		if(WIN_HOST)
			set(RUN_SCRIPT_RELEASE
<<<<<<< HEAD
				"${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun.bat ${DK_PROJECT_DIR}/emscripten/${RELEASE_DIR}/${APP_NAME}.html"
			)
			dk_fileWrite(${DK_PROJECT_DIR}/emscripten/${RELEASE_DIR}/Run.bat ${RUN_SCRIPT_RELEASE})
		else()
			set(RUN_SCRIPT_RELEASE
				"\#!/bin/bash\n"
				"${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun ${DK_PROJECT_DIR}/emscripten/${RELEASE_DIR}/${APP_NAME}.html"
			)
			dk_fileWrite(${DK_PROJECT_DIR}/emscripten/${RELEASE_DIR}/Run.sh ${RUN_SCRIPT_RELEASE})
			dk_executeProcess(chmod 777 ${DK_PROJECT_DIR}/emscripten/${RELEASE_DIR}/Run.sh)
		endif()
	endif()

	
=======
				"${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun.bat ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.html"
			)
			dk_fileWrite(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/Run.bat ${RUN_SCRIPT_RELEASE})
		else()
			set(RUN_SCRIPT_RELEASE
				"\#!/bin/bash\n"
				"${EMSDK_ENV} & ${EMSDK}/upstream/emscripten/emrun ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.html"
			)
			dk_fileWrite(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/Run.sh ${RUN_SCRIPT_RELEASE})
			dk_exec(chmod 777 ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/Run.sh)
		endif()
	endif()

>>>>>>> Development
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
<<<<<<< HEAD
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_PROJECT_DIR}/emscripten/${DEBUG_DIR}/${APP_NAME}.data" "${DK_PROJECT_DIR}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_PROJECT_DIR}/emscripten/${DEBUG_DIR}/${APP_NAME}.html" "${DK_PROJECT_DIR}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_PROJECT_DIR}/emscripten/${DEBUG_DIR}/${APP_NAME}.js" "${DK_PROJECT_DIR}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_PROJECT_DIR}/emscripten/${DEBUG_DIR}/${APP_NAME}.wasm" "${DK_PROJECT_DIR}/assets/")
=======
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.data" "${DK_Project_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.html" "${DK_Project_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.js" "${DK_Project_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.wasm" "${DK_Project_Dir}/assets/")
>>>>>>> Development
	#else()
	#	add_custom_command(
	#		TARGET ${APP_NAME} 
	#		POST_BUILD
	#		COMMAND ${CMAKE_COMMAND} -E echo "Copying ${APP_NAME} Release wasm files to /assets"
<<<<<<< HEAD
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_PROJECT_DIR}/emscripten/${RELEASE_DIR}/${APP_NAME}.data" "${DK_PROJECT_DIR}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_PROJECT_DIR}/emscripten/${RELEASE_DIR}/${APP_NAME}.html" "${DK_PROJECT_DIR}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_PROJECT_DIR}/emscripten/${RELEASE_DIR}/${APP_NAME}.js" "${DK_PROJECT_DIR}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_PROJECT_DIR}/emscripten/${RELEASE_DIR}/${APP_NAME}.wasm" "${DK_PROJECT_DIR}/assets/")
=======
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.data" "${DK_Project_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.html" "${DK_Project_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.js" "${DK_Project_Dir}/assets/"
	#		COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.wasm" "${DK_Project_Dir}/assets/")
>>>>>>> Development
	#endif()
endif(EMSCRIPTEN)


#################
if(IOS OR IOSSIM)
	# https://github.com/forexample/testapp/blob/master/CMakeLists.txt
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
<<<<<<< HEAD
			if(EXISTS ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.app)
				dk_delete(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.app.backup)
				dk_rename(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.app ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.app.backup OVERWRITE)
			endif()
		endif()
		if(RELEASE)
			if(EXISTS ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.app)
				dk_delete(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.app.backup)
				dk_rename(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.app ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.app.backup OVERWRITE)
=======
			if(EXISTS ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.app)
				dk_delete(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.app.backup)
				dk_rename(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.app ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.app.backup OVERWRITE)
			endif()
		endif()
		if(RELEASE)
			if(EXISTS ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.app)
				dk_delete(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.app.backup)
				dk_rename(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.app ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.app.backup OVERWRITE)
>>>>>>> Development
			endif()
		endif()
	endif()
	
	###################### BACKUP USERDATA ###############################
	# Backup files and folders excluded from the package
<<<<<<< HEAD
	#	dk_copy(${DK_PROJECT_DIR}/assets/USER ${DK_PROJECT_DIR}/Backup/USER OVERWRITE)
	# Remove excluded files and folders before packaging
	#	dk_delete(${DK_PROJECT_DIR}/assets/USER)
	# Restore the backed up files, excluded from assets
	#	dk_copy(${DK_PROJECT_DIR}/Backup/ ${DK_PROJECT_DIR}/assets/)
	#	dk_delete(${DK_PROJECT_DIR}/Backup)
	
	########################## ICONS ###############################
	dk_createIcons(${DK_PROJECT_DIR}/icons/icon.png)
	#if(EXISTS ${DK_PROJECT_DIR}/icons/icon.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 16 16 ${DK_PROJECT_DIR}/icons/ios/icons.iconset/icon_16x16.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 32 32 ${DK_PROJECT_DIR}/icons/ios/icons.iconset/icon_16x16@2x.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 32 32 ${DK_PROJECT_DIR}/icons/ios/icons.iconset/icon_32x32.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 64 64 ${DK_PROJECT_DIR}/icons/ios/icons.iconset/icon_32x32@2x.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 128 128 ${DK_PROJECT_DIR}/icons/ios/icons.iconset/icon_128x128.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 256 256 ${DK_PROJECT_DIR}/icons/ios/icons.iconset/icon_128x128@2x.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 256 256 ${DK_PROJECT_DIR}/icons/ios/icons.iconset/icon_256x256.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 512 512 ${DK_PROJECT_DIR}/icons/ios/icons.iconset/icon_256x256@2x.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 512 512 ${DK_PROJECT_DIR}/icons/ios/icons.iconset/icon_512x512.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 1024 1024 ${DK_PROJECT_DIR}/icons/ios/icons.iconset/icon_512x512@2x.png)
	#	dk_executeProcess(iconutil -c icns -o ${DK_PROJECT_DIR}/icons/ios/icons.icns ${DK_PROJECT_DIR}/icons/ios/icons.iconset)
	#	set(MACOSX_BUNDLE_ICON_FILE icons.icns)
	#	set(app_ICONS ${DK_PROJECT_DIR}/icons/ios/icons.icns)
	#	set_source_files_properties(${app_ICONS} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
	#endif()
=======
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
>>>>>>> Development
	
	####################### Storyboards ############################
	#TODO
		
	####################### Create Executable Target ###################
	file(GLOB_RECURSE m_SRC 
<<<<<<< HEAD
	${DK_PROJECT_DIR}/*.m
	${DK_PROJECT_DIR}/*.mm)
	list(APPEND App_SRC ${m_SRC})
	#if(HAVE_DK)
	#	list(APPEND App_SRC ${DKPLUGINS_DIR}/DK/DKAppDelegate.h)
	#	list(APPEND App_SRC ${DKPLUGINS_DIR}/DK/DKAppDelegate.m)
=======
	${DK_Project_Dir}/*.m
	${DK_Project_Dir}/*.mm)
	list(APPEND App_SRC ${m_SRC})
	#if(HAVE_DK)
	#	list(APPEND App_SRC ${DKCPP_PLUGINS_DIR}/DK/DKAppDelegate.h)
	#	list(APPEND App_SRC ${DKCPP_PLUGINS_DIR}/DK/DKAppDelegate.m)
>>>>>>> Development
	#endif()
	add_executable(${APP_NAME} MACOSX_BUNDLE ${app_ICONS} ${App_SRC} ${RES_FILES})
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
<<<<<<< HEAD
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
=======
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
>>>>>>> Development
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
<<<<<<< HEAD
	set_target_properties(${APP_NAME} PROPERTIES MACOSX_BUNDLE TRUE MACOSX_BUNDLE_INFO_PLIST ${DKPLUGINS_DIR}/_DKIMPORT/ios/Info.plist)
=======
	set_target_properties(${APP_NAME} PROPERTIES MACOSX_BUNDLE TRUE MACOSX_BUNDLE_INFO_PLIST ${DKCPP_PLUGINS_DIR}/_DKIMPORT/ios/Info.plist)
>>>>>>> Development
	
	###################### Disable bitcode ############################
	set_target_properties(${APP_NAME} PROPERTIES XCODE_ATTRIBUTE_ENABLE_BITCODE "NO")
	
	###################### Add Assets to Bundle #######################
<<<<<<< HEAD
	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${DK_PROJECT_DIR}/assets $<TARGET_FILE_DIR:${APP_NAME}>/assets)
	#if(EXISTS ${DK_PROJECT_DIR}/icons/mac/icons.icns)
	#	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${DK_PROJECT_DIR}/icons/ios/icons.icns $<TARGET_FILE_DIR:${APP_NAME}>/Resources/icons.icns)
=======
	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${DK_Project_Dir}/assets $<TARGET_FILE_DIR:${APP_NAME}>/assets)
	#if(EXISTS ${DK_Project_Dir}/icons/mac/icons.icns)
	#	add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${DK_Project_Dir}/icons/ios/icons.icns $<TARGET_FILE_DIR:${APP_NAME}>/Resources/icons.icns)
>>>>>>> Development
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
<<<<<<< HEAD
				"xcrun simctl install booted ${DK_PROJECT_DIR}/iossim_x86_64/Debug-iphonesimulator/${APP_NAME}.app\n"
				"xcrun simctl launch --console-pty booted com.digitalknob.${APP_NAME}"
			)
			dk_fileWrite(${DK_PROJECT_DIR}/iossim_x86_64/Debug-iphonesimulator/Run.sh ${RUN_SCRIPT_DEBUG})
			dk_executeProcess(chmod 777 ${DK_PROJECT_DIR}/iossim_x86_64/Debug-iphonesimulator/Run.sh)
=======
				"xcrun simctl install booted ${DK_Project_Dir}/iossim_x86_64/Debug-iphonesimulator/${APP_NAME}.app\n"
				"xcrun simctl launch --console-pty booted com.digitalknob.${APP_NAME}"
			)
			dk_fileWrite(${DK_Project_Dir}/iossim_x86_64/Debug-iphonesimulator/Run.sh ${RUN_SCRIPT_DEBUG})
			dk_exec(chmod 777 ${DK_Project_Dir}/iossim_x86_64/Debug-iphonesimulator/Run.sh)
>>>>>>> Development
		endif()
		if(RELEASE)
			set(RUN_SCRIPT_RELEASE
				"\#!/bin/bash\n"
				"open -a Simulator.app\n"
<<<<<<< HEAD
				"xcrun simctl install booted ${DK_PROJECT_DIR}/iossim_x86_64/Release-iphonesimulator/${APP_NAME}.app\n"
				"xcrun simctl launch --console-pty booted com.digitalknob.${APP_NAME}"
			)
			dk_fileWrite(${DK_PROJECT_DIR}/iossim_x86_64/Release-iphonesimulator/Run.sh ${RUN_SCRIPT_RELEASE})
			dk_executeProcess(chmod 777 ${DK_PROJECT_DIR}/iossim_x86_64/Release-iphonesimulator/Run.sh)
=======
				"xcrun simctl install booted ${DK_Project_Dir}/iossim_x86_64/Release-iphonesimulator/${APP_NAME}.app\n"
				"xcrun simctl launch --console-pty booted com.digitalknob.${APP_NAME}"
			)
			dk_fileWrite(${DK_Project_Dir}/iossim_x86_64/Release-iphonesimulator/Run.sh ${RUN_SCRIPT_RELEASE})
			dk_exec(chmod 777 ${DK_Project_Dir}/iossim_x86_64/Release-iphonesimulator/Run.sh)
>>>>>>> Development
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
<<<<<<< HEAD
			dk_copy(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME} ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.backup OVERWRITE NO_HALT)
		elseif(RELEASE)
			dk_copy(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME} ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.backup OVERWRITE NO_HALT)
=======
			dk_copy(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME} ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.backup OVERWRITE NO_HALT)
		elseif(RELEASE)
			dk_copy(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME} ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.backup OVERWRITE NO_HALT)
>>>>>>> Development
		endif()
	endif()
	
	########################## CREATE ICONS ###############################
<<<<<<< HEAD
	dk_createIcons(${DK_PROJECT_DIR}/icons/icon.png)
	#if(EXISTS ${DK_PROJECT_DIR}/icons/icon.png)
	#	dk_copy(${DK_PROJECT_DIR}/icons/icon.png ${DK_PROJECT_DIR}/assets/icon.png OVERWRITE)
=======
	if(EXISTS "${DK_Project_Dir}/icons/icon.png")
		dk_createIcons("${DK_Project_Dir}/icons/icon.png")
	endif()
	#if(EXISTS ${DK_Project_Dir}/icons/icon.png)
	#	dk_copy(${DK_Project_Dir}/icons/icon.png ${DK_Project_Dir}/assets/icon.png OVERWRITE)
>>>>>>> Development
	#endif()
	
	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
<<<<<<< HEAD
		dk_copy(${DK_PROJECT_DIR}/assets/USER ${DK_PROJECT_DIR}/Backup/USER OVERWRITE)
		dk_delete(${DK_PROJECT_DIR}/assets/USER)
		# Remove excluded files and folders before packaging
		dk_info("Creating assets.zip . . .")
		dk_compressAssets(${DK_PROJECT_DIR}/assets)
		#dk_info("Creating assets.h . . .")
		dk_bin2h(SOURCE_FILE ${DK_PROJECT_DIR}/assets.zip HEADER_FILE ${DK_PROJECT_DIR}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		dk_copy(${DK_PROJECT_DIR}/Backup/ ${DK_PROJECT_DIR}/assets/)
		dk_delete(${DK_PROJECT_DIR}/Backup)
=======
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
>>>>>>> Development
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
<<<<<<< HEAD
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
=======
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
>>>>>>> Development
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
<<<<<<< HEAD
			"Exec=${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}\n"
			"Icon=${DK_PROJECT_DIR}/icons/icon.png\n")
		list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
		dk_fileWrite("${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.desktop" "${DESKTOP_FILE}")
=======
			"Exec=${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}\n"
			"Icon=${DK_Project_Dir}/icons/icon.png\n")
		list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
		dk_fileWrite("${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.desktop" "${DESKTOP_FILE}")
>>>>>>> Development
	elseif(RELEASE)
		set(DESKTOP_FILE
			"[Desktop Entry]\n"
			"Encoding=UTF-8\n"
			"Version=1.0\n"
			"Type=Application\n"
			"Terminal=true\n"
			"Name=${APP_NAME}\n"
<<<<<<< HEAD
			"Exec=${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}\n"
			"Icon=${DK_PROJECT_DIR}/icons/icon.png\n")
		list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
		dk_fileWrite("${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.desktop" "${DESKTOP_FILE}")
=======
			"Exec=${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}\n"
			"Icon=${DK_Project_Dir}/icons/icon.png\n")
		list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
		dk_fileWrite("${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.desktop" "${DESKTOP_FILE}")
>>>>>>> Development
	endif()
	
	# Create windows shortcut for WSL
	if(DEFINED ENV{WSL_DISTRO_NAME})
		dk_info("creating WSL shortcut")
		dk_depend(wsl)
		if(DEBUG)
<<<<<<< HEAD
			execute_process(COMMAND ${WSLPATH_EXE} -m "${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.lnk" OUTPUT_VARIABLE SHORTCUT_PATH OUTPUT_STRIP_TRAILING_WHITESPACE)
			dk_debug("WSL SHORTCUT_PATH = ${SHORTCUT_PATH}")
			dk_createShortcut("${SHORTCUT_PATH}" "${WSL_EXE}" "${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}")
		elseif(RELEASE)
			execute_process(COMMAND ${WSLPATH_EXE} -m "${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.lnk" OUTPUT_VARIABLE SHORTCUT_PATH OUTPUT_STRIP_TRAILING_WHITESPACE)
			dk_createShortcut("${SHORTCUT_PATH}" "${WSL_EXE}" "${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}")
=======
			execute_process(COMMAND ${WSLPATH_EXE} -m "${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.lnk" OUTPUT_VARIABLE SHORTCUT_PATH OUTPUT_STRIP_TRAILING_WHITESPACE)
			dk_debug("WSL SHORTCUT_PATH = ${SHORTCUT_PATH}")
			dk_createShortcut("${SHORTCUT_PATH}" "${WSL_EXE}" "${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}")
		elseif(RELEASE)
			execute_process(COMMAND ${WSLPATH_EXE} -m "${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.lnk" OUTPUT_VARIABLE SHORTCUT_PATH OUTPUT_STRIP_TRAILING_WHITESPACE)
			dk_createShortcut("${SHORTCUT_PATH}" "${WSL_EXE}" "${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}")
>>>>>>> Development
		endif()
	endif()
	
	# Install shortcut of Release build to the apps menu
	if(NOT TINYCORE)
		if(DEBUG)
<<<<<<< HEAD
			#dk_executeProcess(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.desktop WORKING_DIRECTORY ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR})
		elseif(RELEASE)
			dk_executeProcess(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.desktop WORKING_DIRECTORY ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR})
=======
			#dk_exec(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.desktop WORKING_DIRECTORY ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR})
		elseif(RELEASE)
			dk_exec(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.desktop WORKING_DIRECTORY ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR})
>>>>>>> Development
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
<<<<<<< HEAD
	#CPP_Execute("chmod +x "+app_path+OS+"/${DEBUG_DIR}/"+APP)
=======
	#CPP_Execute("chmod +x "+app_path+OS+"/${DEBUG_DIR}/"+target_app)
>>>>>>> Development
endif()
endif(LINUX)


#######
if(MAC)
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
<<<<<<< HEAD
			dk_copy(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.app ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.app.backup OVERWRITE NO_HALT)
		endif()
		if(RELEASE)
			dk_copy(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.app ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.app.backup OVERWRITE NO_HALT)
=======
			dk_copy(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.app ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.app.backup OVERWRITE NO_HALT)
		endif()
		if(RELEASE)
			dk_copy(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.app ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.app.backup OVERWRITE NO_HALT)
>>>>>>> Development
		endif()
	endif()
		
	########################## CREATE ICONS ###############################
<<<<<<< HEAD
	dk_createIcons(${DK_PROJECT_DIR}/icons/icon.png)
	#if(EXISTS ${DK_PROJECT_DIR}/icons/icon.png)
	#	dk_makeDirectory(${DK_PROJECT_DIR}/icons/mac)
	#	dk_makeDirectory(${DK_PROJECT_DIR}/icons/mac/icons.iconset)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 16 16 ${DK_PROJECT_DIR}/icons/mac/icons.iconset/icon_16x16.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 32 32 ${DK_PROJECT_DIR}/icons/mac/icons.iconset/icon_16x16@2x.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 32 32 ${DK_PROJECT_DIR}/icons/mac/icons.iconset/icon_32x32.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 64 64 ${DK_PROJECT_DIR}/icons/mac/icons.iconset/icon_32x32@2x.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 128 128 ${DK_PROJECT_DIR}/icons/mac/icons.iconset/icon_128x128.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 256 256 ${DK_PROJECT_DIR}/icons/mac/icons.iconset/icon_128x128@2x.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 256 256 ${DK_PROJECT_DIR}/icons/mac/icons.iconset/icon_256x256.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 512 512 ${DK_PROJECT_DIR}/icons/mac/icons.iconset/icon_256x256@2x.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 512 512 ${DK_PROJECT_DIR}/icons/mac/icons.iconset/icon_512x512.png)
	#	dk_resizeImage(${DK_PROJECT_DIR}/icons/icon.png 1024 1024 ${DK_PROJECT_DIR}/icons/mac/icons.iconset/icon_512x512@2x.png)
	#	dk_executeProcess(iconutil -c icns -o ${DK_PROJECT_DIR}/icons/mac/icons.icns ${DK_PROJECT_DIR}/icons/mac/icons.iconset WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	#	set(MACOSX_BUNDLE_ICON_FILE icons.icns)
	#	set(app_ICONS ${DK_PROJECT_DIR}/icons/mac/icons.icns)
=======
	if(EXISTS "${DK_Project_Dir}/icons/icon.png")
		dk_createIcons("${DK_Project_Dir}/icons/icon.png")
	endif()
	#if(EXISTS ${DK_Project_Dir}/icons/icon.png)
	#	dk_mkdir(${DK_Project_Dir}/icons/mac)
	#	dk_mkdir(${DK_Project_Dir}/icons/mac/icons.iconset)
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
	#	dk_exec(iconutil -c icns -o ${DK_Project_Dir}/icons/mac/icons.icns ${DK_Project_Dir}/icons/mac/icons.iconset WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})
	#	set(MACOSX_BUNDLE_ICON_FILE icons.icns)
	#	set(app_ICONS ${DK_Project_Dir}/icons/mac/icons.icns)
>>>>>>> Development
	#	set_source_files_properties(${app_ICONS} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
	#endif()
		
	################# BACKUP USERDATA / INJECT ASSETS #####################	
<<<<<<< HEAD
	dk_copy(${DK_PROJECT_DIR}/assets/USER ${DK_PROJECT_DIR}/Backup/USER OVERWRITE NO_HALT)
	dk_delete(${DK_PROJECT_DIR}/assets/USER NO_HALT)
	dk_copy(${DK_PROJECT_DIR}/Backup/ ${DK_PROJECT_DIR}/assets/ OVERWRITE NO_HALT)
	dk_delete(${DK_PROJECT_DIR}/Backup NO_HALT)
	
	####################### Create Executable Target ###################
	file(GLOB_RECURSE m_SRC 
		${DK_PROJECT_DIR}/*.m
		${DK_PROJECT_DIR}/*.mm)
=======
	dk_copy(${DK_Project_Dir}/assets/USER ${DK_Project_Dir}/Backup/USER OVERWRITE NO_HALT)
	dk_delete(${DK_Project_Dir}/assets/USER NO_HALT)
	dk_copy(${DK_Project_Dir}/Backup/ ${DK_Project_Dir}/assets/ OVERWRITE NO_HALT)
	dk_delete(${DK_Project_Dir}/Backup NO_HALT)
	
	####################### Create Executable Target ###################
	file(GLOB_RECURSE m_SRC 
		${DK_Project_Dir}/*.m
		${DK_Project_Dir}/*.mm)
>>>>>>> Development
	list(APPEND App_SRC ${m_SRC})
	add_executable(${APP_NAME} MACOSX_BUNDLE ${app_ICONS} ${App_SRC})
		
	########################## Add Dependencies ########################
	foreach(plugin ${dkdepend_list})
<<<<<<< HEAD
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
=======
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
>>>>>>> Development
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
<<<<<<< HEAD
		MACOSX_BUNDLE_INFO_PLIST ${DKPLUGINS_DIR}/_DKIMPORT/mac/Info.plist)
		
	############## Delete Exlusions and Copy Assets to Bundle #######################
	if(EXISTS ${DK_PROJECT_DIR}/assets)
		dk_delete(${DK_PROJECT_DIR}/assets/log.txt)
		dk_delete(${DK_PROJECT_DIR}/assets/cef.txt)
		add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${DK_PROJECT_DIR}/assets $<TARGET_BUNDLE_CONTENT_DIR:${APP_NAME}>/Resources)
=======
		MACOSX_BUNDLE_INFO_PLIST ${DKCPP_PLUGINS_DIR}/_DKIMPORT/mac/Info.plist)
		
	############## Delete Exlusions and Copy Assets to Bundle #######################
	if(EXISTS ${DK_Project_Dir}/assets)
		dk_delete(${DK_Project_Dir}/assets/log.txt)
		dk_delete(${DK_Project_Dir}/assets/cef.txt)
		add_custom_command(TARGET ${APP_NAME} PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory ${DK_Project_Dir}/assets $<TARGET_BUNDLE_CONTENT_DIR:${APP_NAME}>/Resources)
>>>>>>> Development
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
<<<<<<< HEAD
	if(EXISTS "${DKPLUGINS_DIR}/DKCefChild/${triple}/${RELEASE_DIR}/DKCefChild.app")
		dk_info("Adding ${APP_NAME} Helper to bundle . . .")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory "${DKPLUGINS_DIR}/DKCefChild/${triple}/$<CONFIG>/DKCefChild.app" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/${APP_NAME} Helper.app")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${DKPLUGINS_DIR}/DKCefChild/${triple}/$<CONFIG>/DKCefChild.app/Contents/MacOS/DKCefChild" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/${APP_NAME} Helper.app/Contents/MacOS/${APP_NAME} Helper")
=======
	if(EXISTS "${DKCPP_PLUGINS_DIR}/DKCefChild/${target_triple}/${RELEASE_DIR}/DKCefChild.app")
		dk_info("Adding ${APP_NAME} Helper to bundle . . .")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_directory "${DKCPP_PLUGINS_DIR}/DKCefChild/${target_triple}/$<CONFIG>/DKCefChild.app" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/${APP_NAME} Helper.app")
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${DKCPP_PLUGINS_DIR}/DKCefChild/${target_triple}/$<CONFIG>/DKCefChild.app/Contents/MacOS/DKCefChild" "$<TARGET_FILE_DIR:${APP_NAME}>/../Frameworks/${APP_NAME} Helper.app/Contents/MacOS/${APP_NAME} Helper")
>>>>>>> Development
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
<<<<<<< HEAD
		dk_fileWrite(${DK_PROJECT_DIR}/${triple}/wrapper ${TERMINAL_SCRIPT})
		dk_executeProcess(chmod +x ${DK_PROJECT_DIR}/${triple}/wrapper WORKING_DIRECTORY ${DK_PROJECT_DIR}/${triple})
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${DK_PROJECT_DIR}/${triple}/wrapper" "$<TARGET_FILE_DIR:${APP_NAME}>/wrapper")
	endif()
	
	#CPP_Execute("chmod +x "+app_path+OS+"/${DEBUG_DIR}/"+APP)
#			if(CPP_DKFile_Exists(app_path+"assets/DKCef/mac_x86_64_Debug/Chromium Embedded Framework.framework")){
#				CPP_DKFile_MkDir(app_path+"mac_x86_64/${DEBUG_DIR}/"+APP+".app/Contents/Frameworks")
#				CPP_DKFile_Copy(app_path+"assets/DKCef/mac_x86_64_Debug/Chromium Embedded Framework.framework", app_path+"mac_x86_64/${DEBUG_DIR}/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework", true)
#				if(CPP_DKFile_Exists(DIGITALKNOB_DIR+"DK/DKPlugins/DKCefChild/mac_x86_64/${DEBUG_DIR}/DKCefChild.app")){
#					CPP_DKFile_Copy(DIGITALKNOB_DIR+"DK/DKPlugins/DKCefChild/mac_x86_64/${DEBUG_DIR}/DKCefChild.app", app_path+"mac_x86_64/${DEBUG_DIR}/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app", true)
#					CPP_DKFile_Rename(app_path+"mac_x86_64/${DEBUG_DIR}/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/DKCefChild", app_path+"mac_x86_64/${DEBUG_DIR}/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper", true)
#				}
#			}
#			//update the info.plist to include the logo icon
#			if(CPP_DKFile_Exists(app_path+OS+"/${DEBUG_DIR}/"+APP+".app/Contents/info.plist")){
#				let info_plist = CPP_DKFile_FileToString(app_path+OS+"/${DEBUG_DIR}/"+APP+".app/Contents/info.plist")
#				info_plist = info_plist.replace("<dict>", "<dict><key>CFBundleIconFile</key><string>logo</string>")
#				CPP_DKFile_StringToFile(info_plist, app_path+OS+"/${DEBUG_DIR}/"+APP+".app/Contents/info.plist")
#			}
#			//update install_name_tool if cef present
#			if(CPP_DKFile_Exists(app_path+OS+"/${DEBUG_DIR}/"+APP+".app/Contents/Frameworks/Chromium Embedded Framework.framework")){
#				console.log("USING CHROMIUM EMBEDDED FRAMEWORK")
#				let command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+app_path+OS+"/${DEBUG_DIR}/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\""
#				console.log(command)
#				CPP_Execute(command)
#				command = "install_name_tool -add_rpath \"@executable_path/../../../../\" \""+app_path+OS+"/${DEBUG_DIR}/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+" Helper\""
#				console.log(command)
#				CPP_Execute(command)
#				command = "install_name_tool -change \"@executable_path/Chromium Embedded Framework\" \"@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework\" \""+app_path+OS+"/${DEBUG_DIR}/"+APP+".app/Contents/Frameworks/"+APP+" Helper.app/Contents/MacOS/"+APP+"\""
#				console.log(command)
#				CPP_Execute(command)
#				command = "install_name_tool -add_rpath \"@executable_path/../\" \""+app_path+OS+"/${DEBUG_DIR}/"+APP+".app/Contents/MacOS/"+APP+"\""
=======
		dk_fileWrite(${DK_Project_Dir}/${target_triple}/wrapper ${TERMINAL_SCRIPT})
		dk_exec(chmod +x ${DK_Project_Dir}/${target_triple}/wrapper WORKING_DIRECTORY ${DK_Project_Dir}/${target_triple})
		add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy "${DK_Project_Dir}/${target_triple}/wrapper" "$<TARGET_FILE_DIR:${APP_NAME}>/wrapper")
	endif()
	
	#CPP_Execute("chmod +x "+app_path+OS+"/${DEBUG_DIR}/"+target_app)
#			if(CPP_DKFile_Exists(app_path+"assets/DKCef/mac_x86_64_Debug/Chromium Embedded Framework.framework")){
#				CPP_DKFile_MkDir(app_path+"mac_x86_64/${DEBUG_DIR}/"+target_app+".app/Contents/Frameworks")
#				CPP_DKFile_Copy(app_path+"assets/DKCef/mac_x86_64_Debug/Chromium Embedded Framework.framework", app_path+"mac_x86_64/${DEBUG_DIR}/"+target_app+".app/Contents/Frameworks/Chromium Embedded Framework.framework", true)
#				if(CPP_DKFile_Exists(DKBRANCH_DIR+"/DKCpp/plugins/DKCefChild/mac_x86_64/${DEBUG_DIR}/DKCefChild.app")){
#					CPP_DKFile_Copy(DKBRANCH_DIR+"/DKCpp/plugins/DKCefChild/mac_x86_64/${DEBUG_DIR}/DKCefChild.app", app_path+"mac_x86_64/${DEBUG_DIR}/"+target_app+".app/Contents/Frameworks/"+target_app+" Helper.app", true)
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
>>>>>>> Development
#				console.log(command)
#				CPP_Execute(command)
#			}
#			*/
endif(MAC)


#############
if(RASPBERRY)
	########################## CREATE ICONS ###############################
<<<<<<< HEAD
	dk_createIcons(${DK_PROJECT_DIR}/icons/icon.png)
	#if(EXISTS ${DK_PROJECT_DIR}/icons/icon.png)
	#	dk_copy(${DK_PROJECT_DIR}/icons/icon.png ${DK_PROJECT_DIR}/assets/icon.png OVERWRITE)
	#endif()
=======
	if(EXISTS "${DK_Project_Dir}/icons/icon.png")
		dk_createIcons("${DK_Project_Dir}/icons/icon.png")
	endif()
>>>>>>> Development

	############### BACKUP USERDATA / inject assets #######################
	if(false)
		# backup files not going in the package
<<<<<<< HEAD
		dk_copy(${DK_PROJECT_DIR}/assets/USER ${DK_PROJECT_DIR}/Backup/USER OVERWRITE)
		# Remove excluded files and folders before packaging
		dk_delete(${DK_PROJECT_DIR}/assets/USER)
		dk_info("Creating assets.zip . . .")
		dk_compressAssets(${DK_PROJECT_DIR}/assets)
		#dk_info("Creating assets.h . . .")
		dk_bin2h(SOURCE_FILE ${DK_PROJECT_DIR}/assets.zip HEADER_FILE ${DK_PROJECT_DIR}/assets.h VARIABLE_NAME "ASSETS_H")
		# Restore the backed up assets
		dk_copy(${DK_PROJECT_DIR}/Backup/ ${DK_PROJECT_DIR}/assets/)
		dk_delete(${DK_PROJECT_DIR}/Backup)
=======
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
>>>>>>> Development
	endif()
	
	###################### Backup Executable ###########################
	if(BACKUP_APP_EXECUTABLES)
		if(DEBUG)
<<<<<<< HEAD
			dk_rename(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME} ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.backup OVERWRITE NO_HALT)
		elseif(RELEASE)
			dk_rename(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME} ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.backup OVERWRITE NO_HALT)
=======
			dk_rename(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME} ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.backup OVERWRITE NO_HALT)
		elseif(RELEASE)
			dk_rename(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME} ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.backup OVERWRITE NO_HALT)
>>>>>>> Development
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
<<<<<<< HEAD
		if(EXISTS "${DKPLUGINS_DIR}/${plugin}/CMakeLists.txt")
=======
		if(EXISTS "${DKCPP_PLUGINS_DIR}/${plugin}/CMakeLists.txt")
>>>>>>> Development
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
<<<<<<< HEAD
		"Exec=${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}\n"
		"Icon=${DK_PROJECT_DIR}/icons/icon.png\n")
	list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
	dk_fileWrite(${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.desktop ${DESKTOP_FILE})
=======
		"Exec=${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}\n"
		"Icon=${DK_Project_Dir}/icons/icon.png\n")
	list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
	dk_fileWrite(${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.desktop ${DESKTOP_FILE})
>>>>>>> Development
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
<<<<<<< HEAD
		"Exec=${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}\n"
		"Icon=${DK_PROJECT_DIR}/icons/icon.png\n")
	list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
	dk_fileWrite(${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.desktop ${DESKTOP_FILE})
=======
		"Exec=${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}\n"
		"Icon=${DK_Project_Dir}/icons/icon.png\n")
	list(JOIN DESKTOP_FILE "" DESKTOP_FILE)
	dk_fileWrite(${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.desktop ${DESKTOP_FILE})
>>>>>>> Development
	endif()
	
	# Install shortcut of Release build to the apps menu
	if(RELEASE)
<<<<<<< HEAD
		dk_executeProcess(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DK_PROJECT_DIR}/${triple}/${RELEASE_DIR}/${APP_NAME}.desktop WORKING_DIRECTORY ${DK_PROJECT_DIR}/${triple}/Release)
=======
		dk_exec(desktop-file-install --dir=/home/$ENV{USER}/.local/share/applications ${DK_Project_Dir}/${target_triple}/${RELEASE_DIR}/${APP_NAME}.desktop WORKING_DIRECTORY ${DK_Project_Dir}/${target_triple}/Release)
>>>>>>> Development
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
<<<<<<< HEAD
	#CPP_Execute("chmod +x "+app_path+OS+"/${DEBUG_DIR}/"+APP)
=======
	#CPP_Execute("chmod +x "+app_path+OS+"/${DEBUG_DIR}/"+target_app)
>>>>>>> Development
endif(RASPBERRY)


##########
if(WIN_X86)
	########################## CREATE ICONS ###############################
<<<<<<< HEAD
	dk_createIcons(${DK_PROJECT_DIR}/icons/icon.png)
	
	################# BACKUP USERDATA / INJECT ASSETS #####################	
	if(HAVE_DK)
		dk_copy(${DK_PROJECT_DIR}/assets/USER ${DK_PROJECT_DIR}/Backup/USER OVERWRITE NO_HALT)
		dk_delete(${DK_PROJECT_DIR}/assets/USER)
		# Compress the assets, they will be included by resource.rc
		dk_info("Creating assets.zip . . .")
		dk_compressAssets(${DK_PROJECT_DIR}/assets)
		# Restore the backed up files, excluded from assets
		dk_copy(${DK_PROJECT_DIR}/Backup ${DK_PROJECT_DIR}/assets OVERWRITE NO_HALT)
		dk_delete(${DK_PROJECT_DIR}/Backup)
		dk_copy(${DKPLUGINS_DIR}/_DKIMPORT/assets.h ${DK_PROJECT_DIR}/assets.h OVERWRITE) #required
=======
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
		dk_copy(${DKCPP_PLUGINS_DIR}/_DKIMPORT/assets.h ${DK_Project_Dir}/assets.h OVERWRITE) #required
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
<<<<<<< HEAD
	#	#COMMAND cmd /c ${CMAKE_COMMAND} --build ${DK_PROJECT_DIR}/${triple} --target ${APP_NAME}
=======
	#	#COMMAND cmd /c ${CMAKE_COMMAND} --build ${DK_Project_Dir}/${target_triple} --target ${APP_NAME}
>>>>>>> Development
	#)
	
	#add_custom_command(
    #TARGET ${APP_NAME}
    #POST_BUILD
    #COMMAND "mt.exe" -nologo
<<<<<<< HEAD
    #        -manifest \"${DK_PROJECT_DIR}/compatibility.manifest\"
    #        -outputresource:"${DK_PROJECT_DIR}/win_x86/${DEBUG_DIR}/${APP_NAME}.exe"\;\#1
    #COMMENT "Adding manifest..."
    #)
	
	#CPP_DKFile_Copy(app_path+OS+"/${RELEASE_DIR}/"+APP+".pdb", app_path+"assets/"+APP+".pdb", true)
	#CPP_Execute(DIGITALKNOB_DIR+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/${RELEASE_DIR}/"+APP+".exe")
=======
    #        -manifest \"${DK_Project_Dir}/compatibility.manifest\"
    #        -outputresource:"${DK_Project_Dir}/win_x86/${DEBUG_DIR}/${APP_NAME}.exe"\;\#1
    #COMMENT "Adding manifest..."
    #)
	
	#CPP_DKFile_Copy(app_path+OS+"/${RELEASE_DIR}/"+target_app+".pdb", app_path+"assets/"+target_app+".pdb", true)
	#CPP_Execute(DIGITALKNOB_DIR+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/${RELEASE_DIR}/"+target_app+".exe")
>>>>>>> Development
endif(WIN_X86)
	
	
##########
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
<<<<<<< HEAD
	#CPP_DKFile_Copy(app_path+OS+"/${RELEASE_DIR}/"+APP+".pdb", app_path+"assets/"+APP+".pdb", true)
	#CPP_Execute(DIGITALKNOB_DIR+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/${RELEASE_DIR}/"+APP+".exe")
=======
	#CPP_DKFile_Copy(app_path+OS+"/${RELEASE_DIR}/"+target_app+".pdb", app_path+"assets/"+target_app+".pdb", true)
	#CPP_Execute(DIGITALKNOB_DIR+"DK/3rdParty/upx-3.95-win64/upx.exe -9 -v "+app_path+OS+"/${RELEASE_DIR}/"+target_app+".exe")
>>>>>>> Development
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
<<<<<<< HEAD
#	dk_command(ldd >> ${DK_PROJECT_DIR}/${triple}/DKBUILD.log)
#elseif(MAC OR IOS)
	# TODO
	#dk_command(otool -L ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.app)
#elseif(WIN)	
	# TODO
	#"C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.30.30705/bin/Hostx86/x86/dumpbin.exe" /dependents ${DK_PROJECT_DIR}/${triple}/${DEBUG_DIR}/${APP_NAME}.exe
=======
#	dk_command(ldd >> ${DK_Project_Dir}/${target_triple}/DKBUILD.log)
#elseif(MAC OR IOS)
	# TODO
	#dk_command(otool -L ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.app)
#elseif(WIN)	
	# TODO
	#"C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.30.30705/bin/Hostx86/x86/dumpbin.exe" /dependents ${DK_Project_Dir}/${target_triple}/${DEBUG_DIR}/${APP_NAME}.exe
>>>>>>> Development
#endif()

dk_info("\n\n")
dk_info("******************************************************")
<<<<<<< HEAD
dk_info("****** Generated ${APP_NAME} - ${triple}  ************")
dk_info("******************************************************\n")
=======
dk_info("****** Generated ${APP_NAME} - ${target_triple}  ************")
dk_info("******************************************************\n")

>>>>>>> Development
