#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_configure(SOURCE_DIR) #ARGN
#
#	@SOURCE_DIR - The path to the configure file to use, CMakeLists.txt for cmake, configure for Unix, Etc.
#
function(dk_configure SOURCE_DIR) #ARGN
	dk_debugFunc("\${ARGV}")

	dk_assertPath(SOURCE_DIR)
	dk_validate(DKBUILD_TYPE "dk_BUILD_TYPE()")
	dk_validate(CONFIG_PATH "dk_CONFIG_PATH()")
	
	dk_assertPath(${CURRENT_PLUGIN}_DIR)
	dk_printVar(SOURCE_DIR)
	dk_printVar(${CURRENT_PLUGIN}_FOLDER)
	
	#dk_includes(${SOURCE_DIR} ${${CURRENT_PLUGIN}_FOLDER} isSubDirectory)
	#if(isSubDirectory)
		dk_set(BINARY_DIR "${${CURRENT_PLUGIN}_CONFIG_DIR}")			# only use if CURRENT_PLUGIN_FOLDER is a parent directory of SOURCE_DIR
	#else()
	#	dk_set(BINARY_DIR "${SOURCE_DIR}/${CONFIG_PATH}")
	#endif()
	dk_makeDirectory(${BINARY_DIR})
	dk_assertPath(${BINARY_DIR})
	dk_cd(${BINARY_DIR})
	# Configure with CMake		(multi_config / single_config)
	if(EXISTS ${SOURCE_DIR}/CMakeLists.txt)
		dk_info("Configuring with CMake")
		
		dk_validate(DKCMAKE_BUILD "dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
		set(command_list ${DKCMAKE_BUILD} ${ARGN} "-S" "${SOURCE_DIR}" "-B" "${BINARY_DIR}")			
		dk_mergeFlags("${command_list}" command_list)		
		dk_replaceAll("${command_list}" ";" "\" \n\"" command_string)
		dk_fileWrite(${BINARY_DIR}/DKBUILD.log "\"${command_string}\"\n\n")
		dk_queueCommand(${command_list} OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output)# ECHO_OUTPUT_VARIABLE)
		dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		
		#### restore any altered flags ####
		dk_set(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})  
		if(EMSCRIPTEN)
			dk_set(DKCONFIGURE_BUILD ${EMCONFIGURE} ../../configure ${DKCONFIGURE_FLAGS})
		else()
			dk_set(DKCONFIGURE_BUILD ../../configure ${DKCONFIGURE_FLAGS})
		endif()
		return()
	
	# Configure with Autotools	(single_config)
	elseif(EXISTS ${SOURCE_DIR}/configure.ac) # OR EXISTS ${SOURCE_DIR}/configure)
		dk_info("Configuring with Autotools")			
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





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_depend(zlib)
	dk_configure(${ZLIB_DIR})
endfunction()