#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

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
	dk_debug("dk_build(${ARGV})")
	dk_debug("dk_build(${path})")
	#dk_assertPath(${path})
	
	if(NOT QUEUE_BUILD)
		return()
	endif()
	dk_getOption(NO_HALT ${ARGV})

	#dk_assertPath(${path})	
	set(target ${ARGV1})
	
	# If we are in MULTI_CONFIG mode, we need to do a second pass to check for build files in SINGLE_CONFIG mode. Some libraries are
	# still built in SINGLE_CONFIG mode event though the main project isn't 
	#if(MULTI_CONFIG)
	#	list(APPEND BUILD_MODE multi_config)
	#endif()
	#list(APPEND BUILD_MODE single_config)
		#dk_assertVar(CONFIG_PATH)
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
			endif()
			return()
		endif()
		if(MULTI_CONFIG)
			if(DEBUG)
				if(EXISTS ${path}/${triple}/${DEBUG_DIR}/cmake_install.cmake)
					dk_cd(${path}/${triple}/${DEBUG_DIR})
					dk_info("Building with CMake")
					if(${ARGC} GREATER 1)
						dk_if(DEBUG "dk_command(${CMAKE_EXE} --build . --config Debug --target ${target})") # ${NO_HALT})
					else()
						dk_if(DEBUG "dk_command(${CMAKE_EXE} --build . --config Debug)") # ${NO_HALT})
					endif()
					dk_cd(${path}/${CONFIG_PATH})
					return()
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
					return()
				endif()
			endif()
		endif()
		
		# Build with MSBuild		(multi_config)
		file(GLOB sln "${path}/${CONFIG_PATH}/*.sln")
		if(sln)
			dk_info("Building with MSBuild")
			dk_visualStudio(${ARGV})
			return()
		endif()
		
		# Build with XCode			(multi_config)
		file(GLOB xcodeproj "${path}/${CONFIG_PATH}/*.xcodeproj")
		if(xcodeproj)
			dk_info("Building with XCode")
			dk_xcode(${ARGV})
			return()
		endif()
		
		
		# Build with make			(single_config)
		if(EXISTS ${path}/${CONFIG_PATH}/Makefile)
			dk_info("Building with make")
			dk_make(${ARGV})
			return()
		endif()
		if(MULTI_CONFIG)
			if(DEBUG)
				if(EXISTS ${path}/${triple}/${DEBUG_DIR}/Makefile)
					dk_cd(${path}/${triple}/${DEBUG_DIR})
					dk_info("Building with make")
					dk_make(${ARGV})
					dk_cd(${path}/${CONFIG_PATH})
					return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${triple}/${RELEASE_DIR}/Makefile)
					dk_cd(${path}/${triple}/${RELEASE_DIR})
					dk_info("Building with make")
					dk_make(${ARGV})
					dk_cd(${path}/${CONFIG_PATH})
					return()
				endif()
			endif()
		endif()
		
		
		# Build with Android NDK	(single_config)
		if(EXISTS ${path}/${CONFIG_PATH}/AndroidManifest.xml)
			dk_info("Building with Android NDK")
			dk_ndk(${ARGV})
			return()
		endif()
		if(MULTI_CONFIG)
			if(DEBUG)
				if(EXISTS ${path}/${triple}/${DEBUG_DIR}/AndroidManifest.xml)
					dk_cd(${path}/${triple}/${DEBUG_DIR})
					dk_info("Building with Android NDK")
					dk_ndk(${ARGV})
					dk_cd(${path}/${CONFIG_PATH})
					return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${triple}/${RELEASE_DIR}/AndroidManifest.xml)
					dk_cd(${path}/${triple}/${RELEASE_DIR})
					dk_info("Building with Android NDK")
					dk_ndk(${ARGV})
					dk_cd(${path}/${CONFIG_PATH})
					return()
				endif()
			endif()
		endif()
		
		
	#endforeach()
	
	dk_fatal("dk_build(): ${path}/${CONFIG_PATH} has no buildable files")
endfunction()
dk_createOsMacros("dk_build")







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()