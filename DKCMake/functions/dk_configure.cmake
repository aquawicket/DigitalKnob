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
# dk_configure(Source_Dir) #ARGN
#
#	@Source_Dir - The path to the configure file to use, CMakeLists.txt for cmake, configure for Unix, Etc.
#				  If no Source_Dir is specified, ${${CURRENT_PLUGIN}} will be used
#
function(dk_configure Source_Dir) #ARGN
	dk_debugFunc()
	
	set(Source_Dir "${ARGV0}")
	# TODO - get AllButFirstArgs here
	dk_assertPath(Source_Dir)
	dk_assertPath(${CURRENT_PLUGIN})
	dk_basename("${${CURRENT_PLUGIN}}")
	set(Plugin_Name "${dk_basename}")
	dk_toLower("${Source_Dir}")
	set(SOURCE_DIR_lower "${dk_toLower}")
	dk_toLower("${${CURRENT_PLUGIN}}")
	set(CURRENT_PLUGIN_lower "${dk_toLower}")
	if(NOT "${SOURCE_DIR_lower}" STREQUAL "${CURRENT_PLUGIN_lower}")
		dk_error("dk_build(): Source_Dir:${Source_Dir} != ${CURRENT_PLUGIN}:${${CURRENT_PLUGIN}}")
	endif()

	#if(NOT REBUILDALL)
		foreach(lib ${${CURRENT_PLUGIN}_LIBS})
			if(NOT DEFINED missing_libs)
				set(missing_libs 0)
			endif()
			if(NOT EXISTS "${lib}")
				set(missing_libs 1)
			endif()
		endforeach()
		if("${missing_libs}" EQUAL "0")
			dk_notice("${CURRENT_PLUGIN} libs already built. skipping...")
			return()
		endif()
	#endif()
	
	dk_validate(Target_Type "dk_Target_Type()")
	dk_validate(Target_Config "dk_Target_Config()")
	
	dk_assertPath(${${CURRENT_PLUGIN}})
	
	if(NOT EXISTS "${${CURRENT_PLUGIN}_CONFIG_DIR}")
		set(${CURRENT_PLUGIN}_CONFIG_DIR "${${CURRENT_PLUGIN}}/${Target_Config}")
		dk_mkdir("${${CURRENT_PLUGIN}_CONFIG_DIR}")
	endif()
	dk_assertPath("${${CURRENT_PLUGIN}_CONFIG_DIR}")
	
	dk_set(BINARY_DIR "${${CURRENT_PLUGIN}_CONFIG_DIR}")
	dk_assertVar(BINARY_DIR)
	
	#	if(REBUILDALL)
		dk_clearCmakeCache(${BINARY_DIR})
	#	endif()

	dk_mkdir("${BINARY_DIR}")
	dk_assertPath("${BINARY_DIR}")
	
	dk_chdir("${BINARY_DIR}")
	# Configure with CMake		(multi_config / single_config)
	
	
	###### Configure with CMAKE ######
	# FIXME: This needs to be case sensitive. For example, openssl has Configure in it's root directory. On windows, if(EXISTS ${Source_Dir}/configure) will return true.
	# This will cause problems on unix and any casesensitive platforms, so we need file Exists conditions to be case sensitive.
	get_filename_component(cmakelists_path "${Source_Dir}/CMakeLists.txt" REALPATH)
	if(NOT "${cmakelists_path}" STREQUAL "${Source_Dir}/CMakeLists.txt")
		unset(cmakelists_path)
	endif()
	if(EXISTS ${cmakelists_path})
		dk_info("###### Configuring ${CURRENT_PLUGIN} with CMake ######")
		
		dk_assertPath(${DKCMAKE_DIR})		
		dk_validate(DKCMAKE_BUILD "dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
		dk_validate(CMAKE_GENERATOR "dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
		
		#### create thr Cmake configure command ###
#		dk_assertPath(Source_Dir)
#		dk_assertPath(BINARY_DIR)
		set(command_list ${DKCMAKE_BUILD} ${ARGN} "-S" "${Source_Dir}" "-B" "${BINARY_DIR}")			
		dk_mergeFlags("${command_list}" command_list)		
		
		#### Execute the Cmake configure command ####
		dk_sleep(3)
		message("sleeping for 3 seconds before running cmake configure")
		dk_exec(${command_list})
		
		dk_replaceAll("${command_list}" ";" "\" \n\"" command_string)
		dk_fileWrite(${BINARY_DIR}/DKBUILD.log "\"${command_string}\"\n\n")
		
		#### restore any altered flags ####
		dk_set(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})
		return()
	endif()	

	###### Configure with ../../configure ######
	# FIXME: This needs to be case sensitive. For example, openssl has Configure in it's root directory. On windows, if(EXISTS ${Source_Dir}/configure) will return true.
	# This will cause problems on unix and any casesensitive platforms, so we need file Exists conditions to be case sensitive.
	get_filename_component(configure_path "${Source_Dir}/configure" REALPATH)
	if(NOT "${configure_path}" STREQUAL "${Source_Dir}/configure")
		unset(configure_path)
	endif()
	if(EXISTS ${Source_Dir}/configure.ac OR EXISTS ${configure_path})
		# Configure with Autotools	(single_config)
		dk_echo("###### Configuring ${CURRENT_PLUGIN} with ../../configure ######")
		
		dk_fileAppend(${BINARY_DIR}/DKBUILD.log "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}\n")
		if(EXISTS "${Source_Dir}/configure")
			if(Windows_Host AND (MSYSTEM OR Android OR Emscripten))
				dk_depend(bash)
				dk_exec(${BASH_EXE} -c "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}")
				dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${dk_exec}\n\n\n")
			else()
				dk_exec(../../configure ${DKCONFIGURE_FLAGS} ${ARGN})
				dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${dk_exec}\n\n\n")
			endif()
		else()
			dk_warning("No configure file found. It may need to be generated with autotools")
		endif()
		
		#### restore any altered flags ####
		dk_set(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})  
		if(Emscripten)
			dk_set(DKCONFIGURE_BUILD ${EMCONFIGURE} ../../configure ${DKCONFIGURE_FLAGS})
		else()
			dk_set(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
		endif()
		
		return()
	endif()
		
	
	###### configure with provided commands ######
	# No Specific configure type. Just pass the arguments to dk_exec to run
	#else()
		dk_notice("###### configure type not detected for ${CURRENT_PLUGIN}. Running provided commands unaltered ######")
		dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${ARGN}\n")
		
		#f(Windows_Host AND (MSYSTEM OR Android OR Emscripten))
		#	dk_exec(${ARGN} BASH_ENV OUTPUT_VARIABLE echo_output) # ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
		#	dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		#else()
			dk_exec(${ARGN}) # ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${dk_exec}\n\n\n")
		#endif()
	#endif()
	
	#### restore any altered flags ####
	dk_set(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})  
	if(Emscripten)
		dk_set(DKCONFIGURE_BUILD ${EMCONFIGURE} ../../configure ${DKCONFIGURE_FLAGS})
	else()
		dk_set(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_depend(zlib)
	dk_configure(${ZLIB})
endfunction()