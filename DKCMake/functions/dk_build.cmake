#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_build(path, target) NO_HALT
#
#	TODO
#
#	path 				- path to the library root 	 I.E. ${MyLibrary_Dir} 
#	target (optional)	- The target of the project to build
#
function(dk_build path) #target NO_HALT
	dk_debugFunc()
	
	#if(NOT REBUILDALL)
		foreach(lib ${$ENV{CURRENT_PLUGIN}_LIBS})
			if(NOT DEFINED missing_libs)
				set(missing_libs 0)
			endif()
			if(NOT EXISTS "${lib}")
				set(missing_libs 1)
			else()
				dk_notice("${lib} already exists")
			endif()
		endforeach()
		if("${missing_libs}" EQUAL "0")
			dk_notice("$ENV{CURRENT_PLUGIN} libs already built. skipping...")
			return()
		endif()
	#endif()
	
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
		#dk_assertVar(Target_Config)

		# Build with CMake		(multi_config / single_config)
		if(EXISTS ${path}/${Target_Config}/cmake_install.cmake)
			dk_validate(CMAKE_EXE "dk_depend(cmake)")

			if(target)
				if(Debug)
					dk_info("###### Building $ENV{CURRENT_PLUGIN}_${target}_Debug with CMake (single_config) ######")
					dk_exec(${CMAKE_EXE} --build ${path}/${Target_Config} --config Debug --target ${target} --verbose)
				endif()
				if(Release)
					dk_info("###### Building $ENV{CURRENT_PLUGIN}_${target}_Release with CMake (single_config) ######")
					dk_exec(${CMAKE_EXE} --build ${path}/${Target_Config} --config Release --target ${target} --verbose)
				endif()
			else()
				if(Debug)
					dk_info("###### Building $ENV{CURRENT_PLUGIN}_Debug with CMake (single_config) ######")
					dk_exec(${CMAKE_EXE} --build ${path}/${Target_Config} --config Debug --verbose)
				endif()
				if(Release)
					dk_info("###### Building $ENV{CURRENT_PLUGIN}_Release with CMake (single_config) ######")
					dk_exec(${CMAKE_EXE} --build ${path}/${Target_Config} --config Release --verbose)
				endif()
			endif()
			dk_return()
		endif()
		if(MULTI_CONFIG)
			if(Debug)
				if(EXISTS ${path}/${Target_Tuple}/${Debug_Dir}/cmake_install.cmake)
					
					dk_validate(CMAKE_EXE "dk_depend(cmake)")
					if(target)
						dk_info("###### Building $ENV{CURRENT_PLUGIN}_${target}_Debug with CMake (multi_config) ######")
						dk_exec(${CMAKE_EXE} --build ${path}/${Target_Tuple}/${Debug_Dir} --config Debug --target ${target} --verbose)
					else()
						dk_info("###### Building $ENV{CURRENT_PLUGIN}_Debug with CMake (multi_config) ######")
						dk_exec(${CMAKE_EXE} --build ${path}/${Target_Tuple}/${Debug_Dir} --config Debug --verbose)
					endif()
					dk_return()
				endif()
			elseif(Release)
				if(EXISTS ${path}/${Target_Tuple}/${Release_Dir}/cmake_install.cmake)
					dk_validate(CMAKE_EXE "dk_depend(cmake)")
					if(target)
						dk_info("###### Building $ENV{CURRENT_PLUGIN}_${target}_Release with CMake (multi_config) ######")
						dk_exec(${CMAKE_EXE} --build ${path}/${Target_Tuple}/${Release_Dir} --config Release --target ${target} --verbose)
					else()
						dk_info("###### Building $ENV{CURRENT_PLUGIN}_Release with CMake (multi_config) ######")
						dk_exec(${CMAKE_EXE} --build ${path}/${Target_Tuple}/${Release_Dir} --config Release --verbose)
					endif()
					dk_return()
				endif()
			endif()
		endif()
		
		# Build with MSBuild		(multi_config)
		file(GLOB sln "${path}/${Target_Config}/*.sln")
		if(sln)
			dk_info("###### Building $ENV{CURRENT_PLUGIN} with MSBuild ######")
			dk_visualStudio(${ARGV})
			dk_return()
		endif()
		
		# Build with XCode			(multi_config)
		file(GLOB xcodeproj "${path}/${Target_Config}/*.xcodeproj")
		if(xcodeproj)
			dk_info("###### Building $ENV{CURRENT_PLUGIN} with XCode ######")
			dk_xcode(${ARGV})
			dk_return()
		endif()
		
		
		# Build with make			(single_config)
		if(EXISTS ${path}/${Target_Config}/Makefile)
			dk_chdir(${path}/${Target_Config})
			dk_info("Building with ${path}/${Target_Config}/Makefile")
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
			if(Debug)
				if(EXISTS ${path}/${Target_Tuple}/${Debug_Dir}/Makefile)
					dk_chdir(${path}/${Target_Tuple}/${Debug_Dir})
					dk_info("Building with ${path}/${Target_Tuple}/${Debug_Dir}/Makefile")
					dk_make(${ARGV})
					dk_chdir(${path}/${Target_Config})
					dk_return()
				endif()
			elseif(Release)
				if(EXISTS ${path}/${Target_Tuple}/${Release_Dir}/Makefile)
					dk_chdir(${path}/${Target_Tuple}/${Release_Dir})
					dk_info("Building with ${path}/${Target_Tuple}/${Release_Dir}/Makefile")
					dk_make(${ARGV})
					dk_chdir(${path}/${Target_Config})
					dk_return()
				endif()
			endif()
		endif()
		
		
		# Build with Android NDK	(single_config)
		if(EXISTS ${path}/${Target_Config}/AndroidManifest.xml)
			dk_info("###### Building $ENV{CURRENT_PLUGIN} with Android NDK ######")
			dk_ndk(${ARGV})
			dk_return()
		endif()
		if(MULTI_CONFIG)
			if(Debug)
				if(EXISTS ${path}/${Target_Tuple}/${Debug_Dir}/AndroidManifest.xml)
					dk_chdir(${path}/${Target_Tuple}/${Debug_Dir})
					dk_info("###### Building $ENV{CURRENT_PLUGIN} with Android NDK ######")
					dk_ndk(${ARGV})
					dk_chdir(${path}/${Target_Config})
					dk_return()
				endif()
			elseif(Release)
				if(EXISTS ${path}/${Target_Tuple}/${Release_Dir}/AndroidManifest.xml)
					dk_chdir(${path}/${Target_Tuple}/${Release_Dir})
					dk_info("###### Building $ENV{CURRENT_PLUGIN} with Android NDK ######")
					dk_ndk(${ARGV})
					dk_chdir(${path}/${Target_Config})
					dk_return()
				endif()
			endif()
		endif()
		
	#endforeach()
	
	dk_fatal("dk_build(): ${path}/${Target_Config} has no buildable files")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_build(todo) #TODO
endfunction()