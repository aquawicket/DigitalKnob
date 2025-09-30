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
# dk_build(Source_Dir, target, NO_HALT)
#
#	TODO
#
#	Source_Dir 			- path to the library root 	 I.E. ${MyLibrary_Dir} 
#	target (optional)	- The target name of the project to build
#
function(dk_build)
	dk_debugFunc(0 99)
	
	###### Source_Dir ######
	if(ARGV0)
		set(Source_Dir "${ARGV0}")
	elseif(${CURRENT_PLUGIN})
		set(Source_Dir "${${CURRENT_PLUGIN}}")
	endif()
	dk_assertPath("${Source_Dir}")
	if(NOT "${Source_Dir}" STREQUAL "${${CURRENT_PLUGIN}}")
		dk_notice("dk_build(): Source_Dir:${Source_Dir} != ${CURRENT_PLUGIN}:${${CURRENT_PLUGIN}}")
	endif()
	dk_debug("Source_Dir = ${Source_Dir}")

	### target ###
	if(ARGV1)
		set(target "${ARGV1}")
	endif()

	dk_validate(Target_Config_Type "dk_Target_Config()")
	
	### Config_Dir ###
	dk_validate(${CURRENT_PLUGIN}_Config_Dir "dk_Target_Config()")
	set(Config_Dir "${${CURRENT_PLUGIN}_Config_Dir}")
	dk_assertVar(Config_Dir)
	dk_debug("Config_Dir = ${Config_Dir}")
	
	### Build_Dir ###
	dk_validate(${CURRENT_PLUGIN}_Build_Dir "dk_Target_Config()")
	set(Build_Dir "${${CURRENT_PLUGIN}_Build_Dir}")
	dk_debug("Build_Dir = ${Build_Dir}")
	
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
	
	dk_getParameter(NO_HALT)
	
	# If we are in MULTI_CONFIG mode, we need to do a second pass to check for build files in SINGLE_CONFIG mode. Some libraries are
	# still built in SINGLE_CONFIG mode event though the main project isn't 
	#if(MULTI_CONFIG)
	#	list(APPEND BUILD_MODE multi_config)
	#endif()
	#list(APPEND BUILD_MODE single_config)
		#dk_assertVar(Target_Config)

		# Build with CMake		(multi_config / single_config)
		if(EXISTS "${Config_Dir}/cmake_install.cmake")
			dk_validate(cmake_exe "dk_depend(cmake)")
			if(target)
				if(Debug)
					dk_echo("\n###### Building $ENV{CURRENT_PLUGIN}_${target}_Debug with CMake ######")
					dk_exec(${cmake_exe} --build "${Config_Dir}" --config Debug --target ${target} --verbose)
				endif()
				if(Release)
					dk_echo("\n###### Building $ENV{CURRENT_PLUGIN}_${target}_Release with CMake ######")
					dk_exec(${cmake_exe} --build "${Config_Dir}" --config Release --target ${target} --verbose)
				endif()
			else()
				if(Debug)
					dk_echo("\n###### Building $ENV{CURRENT_PLUGIN}_Debug with CMake ######")
					dk_exec(${cmake_exe} --build "${Config_Dir}" --config Debug --verbose)
				endif()
				if(Release)
					dk_echo("\n###### Building $ENV{CURRENT_PLUGIN}_Release with CMake ######")
					dk_exec(${cmake_exe} --build "${Config_Dir}" --config Release --verbose)
				endif()
			endif()
			dk_return()
		endif()
#		if(MULTI_CONFIG)
#			if(Debug)
#				ifdk_validate(cmake_exe "dk_depend(cmake)")
#					if(target)
#						dk_echo("\n###### Building $ENV{CURRENT_PLUGIN}_${target}_Debug with CMake (multi_config) ######")
#						dk_exec(${cmake_exe} --build "${Config_Dir}" --config Debug --target ${target} --verbose)
#					else()
#						dk_echo("\n###### Building $ENV{CURRENT_PLUGIN}_Debug with CMake (multi_config) ######")
#						dk_exec(${cmake_exe} --build "${Config_Dir}" --config Debug --verbose)
#					endif()
#					dk_return()
#				endif()
#			elseif(Release)
#				if(EXISTS "${Config_Dir}/cmake_install.cmake")
#					dk_depend(cmake)
#					if(target)
#						dk_echo("\n###### Building $ENV{CURRENT_PLUGIN}_${target}_Release with CMake (multi_config) ######")
#						dk_exec(${cmake_exe} --build "${Config_Dir}" --config Release --target ${target} --verbose)
#					else()
#						dk_echo("\n###### Building $ENV{CURRENT_PLUGIN}_Release with CMake (multi_config) ######")
#						dk_exec(${cmake_exe} --build "${Config_Dir}" --config Release --verbose)
#					endif()
#					dk_return()
#				endif()
#			endif()
#		endif()
		
		# Build with MSBuild
		file(GLOB sln "${Config_Dir}/*.sln")
		if(sln)
			dk_echo("\n###### Building $ENV{CURRENT_PLUGIN} with ${sln} ######")
			dk_visualStudio(${ARGV})
			dk_return()
		endif()
		
		# Build with XCode
		file(GLOB xcodeproj "${Config_Dir}/*.xcodeproj")
		if(xcodeproj)
			dk_echo("\n###### Building $ENV{CURRENT_PLUGIN} with ${xcodeproj} ######")
			dk_xcode(${ARGV})
			dk_return()
		endif()
		
		
		# Build with make
		file(GLOB Makefile "${Config_Dir}/Makefile")
		if(Makefile)
		#if(EXISTS "${Config_Dir}/Makefile")
			dk_chdir("${Config_Dir}")
			dk_echo("\n###### Building $ENV{CURRENT_PLUGIN} with ${Makefile} ######")
			dk_make(${ARGV})
			dk_return()
		endif()
		file(GLOB Makefile "${Source_Dir}/Makefile")
		if(Makefile)
		#if(EXISTS "${Source_Dir}/Makefile")
			dk_chdir("${Source_Dir}")
			dk_echo("\n###### Building $ENV{CURRENT_PLUGIN} with ${Makefile} ######")
			dk_make(${ARGV})
			dk_return()
		endif()
		
#		if(MULTI_CONFIG)
#			if(Debug)
#				if(EXISTS "${Config_Dir}/Makefile")
#					dk_chdir("${Config_Dir}")
#					dk_echo("\n###### Building $ENV{CURRENT_PLUGIN} with ${Config_Dir}/Makefile ######")
#					dk_make(${ARGV})
#					dk_chdir("${Config_Dir}")
#					dk_return()
#				endif()
#			elseif(Release)
#				if(EXISTS "${Config_Dir}/Makefile")
#					dk_chdir("${Config_Dir}")
#					dk_echo("\n###### Building $ENV{CURRENT_PLUGIN} with ${Config_Dir}/Makefile ######")
#					dk_make(${ARGV})
#					dk_chdir("${Config_Dir}")
#					dk_return()
#				endif()
#			endif()
#		endif()
		
		
		# Build with Android NDK	(single_config)
		file(GLOB AndroidManifest_xml "${Config_Dir}/AndroidManifest.xml")
		#if(EXISTS "${Config_Dir}/AndroidManifest.xml")
		if(AndroidManifest_xml)
			dk_echo("\n###### Building $ENV{CURRENT_PLUGIN} with ${AndroidManifest_xml} ######")
			dk_ndk(${ARGV})
			dk_return()
		endif()
#		if(MULTI_CONFIG)
#			if(Debug)
#				if(EXISTS "${Config_Dir}/AndroidManifest.xml")
#					dk_chdir("${Config_Dir}")
#					dk_echo("\n###### Building $ENV{CURRENT_PLUGIN}_Debug with Android NDK ######")
#					dk_ndk(${ARGV})
#					dk_chdir("${Config_Dir}")
#					dk_return()
#				endif()
#			elseif(Release)
#				if(EXISTS "${Config_Dir}/AndroidManifest.xml")
#					dk_chdir("${Config_Dir}")
#					dk_echo("\n###### Building $ENV{CURRENT_PLUGIN}_Release with Android NDK ######")
#					dk_ndk(${ARGV})
#					dk_chdir("${Config_Dir}")
#					dk_return()
#				endif()
#			endif()
#		endif()
		
	#endforeach()
	
	dk_assertPath("${Config_Dir}")
	dk_fatal("dk_build(): ${Config_Dir} has no buildable files")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_build(todo) #TODO
endfunction()