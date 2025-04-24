#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_configure(SOURCE_DIR) #ARGN
#
#	@SOURCE_DIR - The path to the configure file to use, CMakeLists.txt for cmake, configure for Unix, Etc.
#
function(dk_configure SOURCE_DIR) #ARGN
	dk_debugFunc()
<<<<<<< HEAD
	dk_debug("dk_configure(${ARGV})")
	
	dk_assertPath(SOURCE_DIR)
	dk_validate(DKBUILD_TYPE "dk_DKBUILD_TYPE()")
	dk_validate(CONFIG_PATH "dk_CONFIG_PATH()")
	
	if(NOT CURRENT_PLUGIN)
		if(NOT EXISTS ${SOURCE_DIR}/DKMAKE.cmake)
			dk_fatal("dk_configure(): The SOURCE_DIR:${SOURCE_DIR} does not contain a DKMAKE.cmake file.")
		endif()
		dk_basename(${SOURCE_DIR} CURRENT_PLUGIN)
		dk_set(CURRENT_PLUGIN ${CURRENT_PLUGIN})
		dk_set(${CURRENT_PLUGIN} ${SOURCE_DIR})
		dk_set(${CURRENT_PLUGIN}_CONFIG_DIR ${SOURCE_DIR}/${CONFIG_PATH})
	endif()
	
	dk_assertPath(${CURRENT_PLUGIN})
	dk_set(BINARY_DIR "${${CURRENT_PLUGIN}_CONFIG_DIR}")
	dk_makeDirectory(${BINARY_DIR})
	dk_assertPath(${BINARY_DIR})
	dk_cd(${BINARY_DIR})
	# Configure with CMake		(multi_config / single_config)
	
	# FIXME: This needs to be case sensitive. For example, openssl has Configure in it's root directory. On windows, EXISTS ${SOURCE_DIR}/configure will return true.
	# This will cause problems, so we need file Exists conditions to be case sensitive.
=======
	
	dk_assertPath(SOURCE_DIR)
	dk_validate(target_type "dk_target_type()")
	dk_validate(CONFIG_PATH "dk_CONFIG_PATH()")
	
	dk_assertPath($ENV{CURRENT_PLUGIN})
	
	if(NOT EXISTS "${$ENV{CURRENT_PLUGIN}_CONFIG_DIR}")
		set($ENV{CURRENT_PLUGIN}_CONFIG_DIR "${$ENV{CURRENT_PLUGIN}}/${CONFIG_PATH}")
		dk_mkdir("${$ENV{CURRENT_PLUGIN}_CONFIG_DIR}")
	endif()
	dk_assertPath($ENV{CURRENT_PLUGIN}_CONFIG_DIR)
	
	dk_set(BINARY_DIR "${$ENV{CURRENT_PLUGIN}_CONFIG_DIR}")
	dk_assertVar(BINARY_DIR)
	
	dk_mkdir("${BINARY_DIR}")
	dk_assertPath("${BINARY_DIR}")
	
	dk_chdir("${BINARY_DIR}")
	# Configure with CMake		(multi_config / single_config)
	
	
	
	
	###### Configure with CMAKE ######
	# FIXME: This needs to be case sensitive. For example, openssl has Configure in it's root directory. On windows, if(EXISTS ${SOURCE_DIR}/configure) will return true.
	# This will cause problems on unix and any casesensitive platforms, so we need file Exists conditions to be case sensitive.
>>>>>>> Development
	get_filename_component(cmakelists_path "${SOURCE_DIR}/CMakeLists.txt" REALPATH)
	if(NOT "${cmakelists_path}" STREQUAL "${SOURCE_DIR}/CMakeLists.txt")
		unset(cmakelists_path)
	endif()
<<<<<<< HEAD
	get_filename_component(configure_path "${SOURCE_DIR}/configure" REALPATH)
	if(NOT "${configure_path}" STREQUAL "${SOURCE_DIR}/configure")
		unset(configure_path)
	endif()
	
	if(EXISTS ${cmakelists_path})
		dk_info("Configuring with CMake")
		dk_assertPath(DKCMAKE_DIR)
		dk_assertPath(SOURCE_DIR)
		dk_assertPath(BINARY_DIR)
		
		dk_validate(DKCMAKE_BUILD "dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
		set(command_list ${DKCMAKE_BUILD} ${ARGN} "-S" "${SOURCE_DIR}" "-B" "${BINARY_DIR}")			
		dk_mergeFlags("${command_list}" command_list)		
		dk_replaceAll("${command_list}" ";" "\" \n\"" command_string)
=======
	if(EXISTS ${cmakelists_path})
		dk_info("###### Configuring $ENV{CURRENT_PLUGIN} with CMake ######")
		dk_assertPath($ENV{DKCMAKE_DIR})
		dk_assertPath(SOURCE_DIR)
		dk_assertPath(BINARY_DIR)
		
		dk_validate(DKCMAKE_BUILD "dk_load($ENV{DKCMAKE_DIR}/DKBuildFlags.cmake)")
		dk_validate(CMAKE_GENERATOR "dk_load($ENV{DKCMAKE_DIR}/DKBuildFlags.cmake)")
		
		#### create thr Cmake configure command ###
		set(command_list ${DKCMAKE_BUILD} ${ARGN} "-S" "${SOURCE_DIR}" "-B" "${BINARY_DIR}")			
		dk_mergeFlags("${command_list}" command_list)		
		dk_replaceAll("${command_list}" ";" "\" \n\"" command_string)
		
		#### Execute the Cmake configure command ####
>>>>>>> Development
		dk_fileWrite(${BINARY_DIR}/DKBUILD.log "\"${command_string}\"\n\n")
		dk_queueCommand(${command_list} OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output)
		dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		
<<<<<<< HEAD
		#### restore any altered flags ####
		dk_set(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})  
		if(EMSCRIPTEN)
			dk_set(DKCONFIGURE_BUILD ${EMCONFIGURE} ../../configure ${DKCONFIGURE_FLAGS})
		else()
			dk_set(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
		endif()
		return()
	
	
	
	#elseif(EXISTS ${SOURCE_DIR}/configure.ac OR EXISTS ${SOURCE_DIR}/configure)
	elseif(EXISTS ${SOURCE_DIR}/configure.ac OR EXISTS ${configure_path})
		# Configure with Autotools	(single_config)
		dk_info("Configuring with configure")
=======

	###### Configure with ../../configure ######
	# FIXME: This needs to be case sensitive. For example, openssl has Configure in it's root directory. On windows, if(EXISTS ${SOURCE_DIR}/configure) will return true.
	# This will cause problems on unix and any casesensitive platforms, so we need file Exists conditions to be case sensitive.
	get_filename_component(configure_path "${SOURCE_DIR}/configure" REALPATH)
	if(NOT "${configure_path}" STREQUAL "${SOURCE_DIR}/configure")
		unset(configure_path)
	endif()
	elseif(EXISTS ${SOURCE_DIR}/configure.ac OR EXISTS ${configure_path})
		# Configure with Autotools	(single_config)
		dk_info("###### Configuring $ENV{CURRENT_PLUGIN} with ../../configure ######")
>>>>>>> Development
		
		dk_fileAppend(${BINARY_DIR}/DKBUILD.log "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}\n")
		if(EXISTS ${SOURCE_DIR}/configure)
			if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
				dk_depend(bash)
				dk_queueCommand(${BASH_EXE} -c "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}" OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output)# ECHO_OUTPUT_VARIABLE)
				dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
			else()
				dk_queueCommand(../../configure ${DKCONFIGURE_FLAGS} ${ARGN} OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output)# ECHO_OUTPUT_VARIABLE)
				dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
			endif()
		else()
			dk_warning("No configure file found. It may need to be generated with autotools")
		endif()
		
<<<<<<< HEAD
		#### restore any altered flags ####
		dk_set(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})  
		if(EMSCRIPTEN)
			dk_set(DKCONFIGURE_BUILD ${EMCONFIGURE} ../../configure ${DKCONFIGURE_FLAGS})
		else()
			dk_set(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
		endif()
		return()
		
	# No Specific configure type. Just pass the arguments to dk_queueCommand to run
	else()
		dk_notice("configure type not detected. running argument in bash environment")
		dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${ARGN}\n")
		
		if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
			dk_queueCommand(${ARGN} BASH_ENV OUTPUT_VARIABLE echo_output) # ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		else()
			dk_queueCommand(${ARGN} BASH_ENV OUTPUT_VARIABLE echo_output) # ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		endif()
		
		#### restore any altered flags ####
		dk_set(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})  
		if(EMSCRIPTEN)
			dk_set(DKCONFIGURE_BUILD ${EMCONFIGURE} ../../configure ${DKCONFIGURE_FLAGS})
		else()
			dk_set(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
		endif()
		return()
		
	endif()
endfunction()
dk_createOsMacros("dk_configure")
=======
	
	###### configure with provided commands ######
	# No Specific configure type. Just pass the arguments to dk_queueCommand to run
	else()
		dk_notice("###### configure type not detected for $ENV{CURRENT_PLUGIN}. Running provided commands unaltered ######")
		dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${ARGN}\n")
		
		#f(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
		#	dk_queueCommand(${ARGN} BASH_ENV OUTPUT_VARIABLE echo_output) # ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
		#	dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		#else()
			dk_queueCommand(${ARGN} OUTPUT_VARIABLE echo_output) # ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		#endif()
	endif()
	
	
	
	#### restore any altered flags ####
	dk_set(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})  
	if(EMSCRIPTEN)
		dk_set(DKCONFIGURE_BUILD ${EMCONFIGURE} ../../configure ${DKCONFIGURE_FLAGS})
	else()
		dk_set(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
	endif()
	
endfunction()

>>>>>>> Development





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_depend(zlib)
	dk_configure(${ZLIB_DIR})
endfunction()