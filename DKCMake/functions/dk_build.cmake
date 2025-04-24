#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_build(path, target) NO_HALT
#
#	TODO
#
#	path 				- path to the library root 	 I.E. ${MyLibrary_Dir} 
#	target (optional)	- The target of the project to build
#
function(dk_build path) #target NO_HALT
	dk_debugFunc()
<<<<<<< HEAD
	dk_debug("dk_build(${ARGV})")
	dk_debug("dk_build(${path})")
	dk_debug("CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
	dk_debug("PWD = ${PWD}")
	
	#dk_assertPath(${path})
=======
>>>>>>> Development
	
	if(NOT QUEUE_BUILD)
		dk_return()
	endif()
<<<<<<< HEAD
	dk_getOption(NO_HALT ${ARGV})

	#dk_assertPath(${path})	
	set(target ${ARGV1})
=======
	
	dk_getOption(NO_HALT)

	#dk_assertPath(${path})	
	set(target ${ARGN})
>>>>>>> Development
	
	# If we are in MULTI_CONFIG mode, we need to do a second pass to check for build files in SINGLE_CONFIG mode. Some libraries are
	# still built in SINGLE_CONFIG mode event though the main project isn't 
	#if(MULTI_CONFIG)
	#	list(APPEND BUILD_MODE multi_config)
	#endif()
	#list(APPEND BUILD_MODE single_config)
		#dk_assertVar(CONFIG_PATH)
<<<<<<< HEAD
		dk_cd(${path}/${CONFIG_PATH})

		# Build with CMake		(multi_config / single_config)
		if(EXISTS ${path}/${CONFIG_PATH}/cmake_install.cmake)
			dk_info("Building with CMake")
			if(${ARGC} GREATER 1)
				#dk_fileAppend(${PWD}/DKBUILD.log "${CMAKE_EXE} --build . --config Debug --target ${target} \n\n")
				dk_if(DEBUG  "dk_command(${CMAKE_EXE} --build . --config Debug --target ${target})")# ${NO_HALT} OUTPUT_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
				#dk_fileAppend(${PWD}/DKBUILD.log "${echo_output}\n\n\n")
				
				dk_if(RELEASE "dk_command(${CMAKE_EXE} --build . --config Release --target ${target})")# ${NO_HALT})
			else()
				#dk_fileAppend(${PWD}/DKBUILD.log "${CMAKE_EXE} --build . --config Debug --target ${target} \n\n")
				dk_if(DEBUG "dk_command(${CMAKE_EXE} --build . --config Debug)") # ${NO_HALT} OUTPUT_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)")
				#dk_fileAppend(${PWD}/DKBUILD.log "${echo_output}\n\n\n")
				
				dk_if(RELEASE "dk_command(${CMAKE_EXE} --build . --config Release)") # ${NO_HALT})")
=======

		# Build with CMake		(multi_config / single_config)
		if(EXISTS ${path}/${CONFIG_PATH}/cmake_install.cmake)
			dk_info("Building with CMake (single_config)")
			if(target)
				dk_if(DEBUG  "dk_command(${CMAKE_EXE} --build ${path}/${CONFIG_PATH} --config Debug --target ${target} --verbose)")
				dk_if(RELEASE "dk_command(${CMAKE_EXE} --build ${path}/${CONFIG_PATH} --config Release --target ${target} --verbose)")
			else()
				dk_if(DEBUG "dk_command(${CMAKE_EXE} --build ${path}/${CONFIG_PATH} --config Debug --verbose)")
				dk_if(RELEASE "dk_command(${CMAKE_EXE} --build ${path}/${CONFIG_PATH} --config Release --verbose)")
>>>>>>> Development
			endif()
			dk_return()
		endif()
		if(MULTI_CONFIG)
			if(DEBUG)
<<<<<<< HEAD
				if(EXISTS ${path}/${triple}/${DEBUG_DIR}/cmake_install.cmake)
					dk_cd(${path}/${triple}/${DEBUG_DIR})
					dk_info("Building with CMake")
					if(${ARGC} GREATER 1)
						dk_if(DEBUG "dk_command(${CMAKE_EXE} --build . --config Debug --target ${target})") # ${NO_HALT})
					else()
						dk_if(DEBUG "dk_command(${CMAKE_EXE} --build . --config Debug)") # ${NO_HALT})
					endif()
					dk_cd(${path}/${CONFIG_PATH})
					dk_return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${triple}/${RELEASE_DIR}/cmake_install.cmake)
					dk_cd(${path}/${triple}/${RELEASE_DIR})
					dk_info("Building with CMake")
					if(${ARGC} GREATER 1)
						dk_if(RELEASE "dk_command(${CMAKE_EXE} --build . --config Release --target ${target})") # ${NO_HALT})
					else()
						dk_if(RELEASE "dk_command(${CMAKE_EXE} --build . --config Release)") # ${NO_HALT})
					endif()
					dk_cd(${path}/${CONFIG_PATH})
=======
				if(EXISTS ${path}/${target_triple}/${DEBUG_DIR}/cmake_install.cmake)
					dk_info("Building with CMake (multi_config)")
					if(target)
						dk_command(${CMAKE_EXE} --build ${path}/${target_triple}/${DEBUG_DIR} --config Debug --target ${target} --verbose)
					else()
						dk_command(${CMAKE_EXE} --build ${path}/${target_triple}/${DEBUG_DIR} --config Debug --verbose)
					endif()
					dk_return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${target_triple}/${RELEASE_DIR}/cmake_install.cmake)
					dk_info("Building with CMake (multi_config)")
					if(target)
						dk_command(${CMAKE_EXE} --build ${path}/${target_triple}/${RELEASE_DIR} --config Release --target ${target} --verbose)
					else()
						dk_command(${CMAKE_EXE} --build ${path}/${target_triple}/${RELEASE_DIR} --config Release --verbose)
					endif()
>>>>>>> Development
					dk_return()
				endif()
			endif()
		endif()
		
		# Build with MSBuild		(multi_config)
		file(GLOB sln "${path}/${CONFIG_PATH}/*.sln")
		if(sln)
			dk_info("Building with MSBuild")
			dk_visualStudio(${ARGV})
			dk_return()
		endif()
		
		# Build with XCode			(multi_config)
		file(GLOB xcodeproj "${path}/${CONFIG_PATH}/*.xcodeproj")
		if(xcodeproj)
			dk_info("Building with XCode")
			dk_xcode(${ARGV})
			dk_return()
		endif()
		
		
		# Build with make			(single_config)
		if(EXISTS ${path}/${CONFIG_PATH}/Makefile)
<<<<<<< HEAD
			dk_cd(${path}/${CONFIG_PATH})
=======
			dk_chdir(${path}/${CONFIG_PATH})
>>>>>>> Development
			dk_info("Building with ${path}/${CONFIG_PATH}/Makefile")
			dk_make(${ARGV})
			dk_return()
		endif()
		if(EXISTS ${path}/Makefile)
<<<<<<< HEAD
			dk_cd(${path})
=======
			dk_chdir(${path})
>>>>>>> Development
			dk_info("Building with ${path}/Makefile")
			dk_make(${ARGV})
			dk_return()
		endif()
		
		if(MULTI_CONFIG)
			if(DEBUG)
<<<<<<< HEAD
				if(EXISTS ${path}/${triple}/${DEBUG_DIR}/Makefile)
					dk_cd(${path}/${triple}/${DEBUG_DIR})
					dk_info("Building with ${path}/${triple}/${DEBUG_DIR}/Makefile")
					dk_make(${ARGV})
					dk_cd(${path}/${CONFIG_PATH})
					dk_return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${triple}/${RELEASE_DIR}/Makefile)
					dk_cd(${path}/${triple}/${RELEASE_DIR})
					dk_info("Building with ${path}/${triple}/${RELEASE_DIR}/Makefile")
					dk_make(${ARGV})
					dk_cd(${path}/${CONFIG_PATH})
=======
				if(EXISTS ${path}/${target_triple}/${DEBUG_DIR}/Makefile)
					dk_chdir(${path}/${target_triple}/${DEBUG_DIR})
					dk_info("Building with ${path}/${target_triple}/${DEBUG_DIR}/Makefile")
					dk_make(${ARGV})
					dk_chdir(${path}/${CONFIG_PATH})
					dk_return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${target_triple}/${RELEASE_DIR}/Makefile)
					dk_chdir(${path}/${target_triple}/${RELEASE_DIR})
					dk_info("Building with ${path}/${target_triple}/${RELEASE_DIR}/Makefile")
					dk_make(${ARGV})
					dk_chdir(${path}/${CONFIG_PATH})
>>>>>>> Development
					dk_return()
				endif()
			endif()
		endif()
		
		
		# Build with Android NDK	(single_config)
		if(EXISTS ${path}/${CONFIG_PATH}/AndroidManifest.xml)
			dk_info("Building with Android NDK")
			dk_ndk(${ARGV})
			dk_return()
		endif()
		if(MULTI_CONFIG)
			if(DEBUG)
<<<<<<< HEAD
				if(EXISTS ${path}/${triple}/${DEBUG_DIR}/AndroidManifest.xml)
					dk_cd(${path}/${triple}/${DEBUG_DIR})
					dk_info("Building with Android NDK")
					dk_ndk(${ARGV})
					dk_cd(${path}/${CONFIG_PATH})
					dk_return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${triple}/${RELEASE_DIR}/AndroidManifest.xml)
					dk_cd(${path}/${triple}/${RELEASE_DIR})
					dk_info("Building with Android NDK")
					dk_ndk(${ARGV})
					dk_cd(${path}/${CONFIG_PATH})
=======
				if(EXISTS ${path}/${target_triple}/${DEBUG_DIR}/AndroidManifest.xml)
					dk_chdir(${path}/${target_triple}/${DEBUG_DIR})
					dk_info("Building with Android NDK")
					dk_ndk(${ARGV})
					dk_chdir(${path}/${CONFIG_PATH})
					dk_return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${target_triple}/${RELEASE_DIR}/AndroidManifest.xml)
					dk_chdir(${path}/${target_triple}/${RELEASE_DIR})
					dk_info("Building with Android NDK")
					dk_ndk(${ARGV})
					dk_chdir(${path}/${CONFIG_PATH})
>>>>>>> Development
					dk_return()
				endif()
			endif()
		endif()
		
<<<<<<< HEAD
		
=======
>>>>>>> Development
	#endforeach()
	
	dk_fatal("dk_build(): ${path}/${CONFIG_PATH} has no buildable files")
endfunction()
<<<<<<< HEAD
dk_createOsMacros("dk_build")
=======
>>>>>>> Development







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_build(todo) #TODO
>>>>>>> Development
endfunction()