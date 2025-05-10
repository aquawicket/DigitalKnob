#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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
	
	if(NOT QUEUE_BUILD)
		dk_return()
	endif()
	
	dk_getParameter(NO_HALT)

	#dk_assertPath(${path})	
	set(target ${ARGN})
	
	# If we are in MULTI_CONFIG mode, we need to do a second pass to check for build files in SINGLE_CONFIG mode. Some libraries are
	# still built in SINGLE_CONFIG mode event though the main project isn't 
	#if(MULTI_CONFIG)
	#	list(APPEND BUILD_MODE multi_config)
	#endif()
	#list(APPEND BUILD_MODE single_config)
		#dk_assertVar(CONFIG_PATH)

		# Build with CMake		(multi_config / single_config)
		if(EXISTS ${path}/${CONFIG_PATH}/cmake_install.cmake)
			dk_info("Building with CMake (single_config)")
			if(target)
				dk_if(DEBUG  "dk_command(${CMAKE_EXE} --build ${path}/${CONFIG_PATH} --config Debug --target ${target} --verbose)")
				dk_if(RELEASE "dk_command(${CMAKE_EXE} --build ${path}/${CONFIG_PATH} --config Release --target ${target} --verbose)")
			else()
				dk_if(DEBUG "dk_command(${CMAKE_EXE} --build ${path}/${CONFIG_PATH} --config Debug --verbose)")
				dk_if(RELEASE "dk_command(${CMAKE_EXE} --build ${path}/${CONFIG_PATH} --config Release --verbose)")
			endif()
			dk_return()
		endif()
		if(MULTI_CONFIG)
			if(DEBUG)
				if(EXISTS ${path}/${Target_Tuple}/${DEBUG_DIR}/cmake_install.cmake)
					dk_info("Building with CMake (multi_config)")
					if(target)
						dk_command(${CMAKE_EXE} --build ${path}/${Target_Tuple}/${DEBUG_DIR} --config Debug --target ${target} --verbose)
					else()
						dk_command(${CMAKE_EXE} --build ${path}/${Target_Tuple}/${DEBUG_DIR} --config Debug --verbose)
					endif()
					dk_return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${Target_Tuple}/${RELEASE_DIR}/cmake_install.cmake)
					dk_info("Building with CMake (multi_config)")
					if(target)
						dk_command(${CMAKE_EXE} --build ${path}/${Target_Tuple}/${RELEASE_DIR} --config Release --target ${target} --verbose)
					else()
						dk_command(${CMAKE_EXE} --build ${path}/${Target_Tuple}/${RELEASE_DIR} --config Release --verbose)
					endif()
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
			dk_chdir(${path}/${CONFIG_PATH})
			dk_info("Building with ${path}/${CONFIG_PATH}/Makefile")
			dk_make(${ARGV})
			dk_return()
		endif()
		if(EXISTS ${path}/Makefile)
			dk_chdir(${path})
			dk_info("Building with ${path}/Makefile")
			dk_make(${ARGV})
			dk_return()
		endif()
		
		if(MULTI_CONFIG)
			if(DEBUG)
				if(EXISTS ${path}/${Target_Tuple}/${DEBUG_DIR}/Makefile)
					dk_chdir(${path}/${Target_Tuple}/${DEBUG_DIR})
					dk_info("Building with ${path}/${Target_Tuple}/${DEBUG_DIR}/Makefile")
					dk_make(${ARGV})
					dk_chdir(${path}/${CONFIG_PATH})
					dk_return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${Target_Tuple}/${RELEASE_DIR}/Makefile)
					dk_chdir(${path}/${Target_Tuple}/${RELEASE_DIR})
					dk_info("Building with ${path}/${Target_Tuple}/${RELEASE_DIR}/Makefile")
					dk_make(${ARGV})
					dk_chdir(${path}/${CONFIG_PATH})
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
				if(EXISTS ${path}/${Target_Tuple}/${DEBUG_DIR}/AndroidManifest.xml)
					dk_chdir(${path}/${Target_Tuple}/${DEBUG_DIR})
					dk_info("Building with Android NDK")
					dk_ndk(${ARGV})
					dk_chdir(${path}/${CONFIG_PATH})
					dk_return()
				endif()
			elseif(RELEASE)
				if(EXISTS ${path}/${Target_Tuple}/${RELEASE_DIR}/AndroidManifest.xml)
					dk_chdir(${path}/${Target_Tuple}/${RELEASE_DIR})
					dk_info("Building with Android NDK")
					dk_ndk(${ARGV})
					dk_chdir(${path}/${CONFIG_PATH})
					dk_return()
				endif()
			endif()
		endif()
		
	#endforeach()
	
	dk_fatal("dk_build(): ${path}/${CONFIG_PATH} has no buildable files")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_build(todo) #TODO
endfunction()