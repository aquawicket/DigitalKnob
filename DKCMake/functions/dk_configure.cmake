include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_configure(path) #ARGN
#
#	TODO
#
#	@path - The path to the configure file to use, CMakeLists.txt for cmake, Configure for Unix, Etc.
#
function(dk_configure path) #ARGN
	dk_debugFunc(${ARGV})
	
	dk_assert(path)
	dk_getOption(NO_HALT ${ARGV})
	
	if((NOT SINGLE_CONFIG) AND (NOT MULTI_CONFIG))
		dk_getMULTI_CONFIG()
	endif()
	
	if(SINGLE_CONFIG)
		# Make sure the plugin variable is alpha-numeric and uppercase
		#dk_assert(plugin)
		#dk_toUpper(${plugin} PLUGIN_NAME)
		#dk_convertToCIdentifier(${PLUGIN_NAME} PLUGIN_NAME)
		set(BUILD_PATH "${path}/${SINGLE_CONFIG_BUILD_DIR}")
		#if(NOT EXISTS "${BUILD_PATH}")
		#	dk_error("BUILD_PATH:${BUILD_PATH} not found")
		#endif()
	elseif(MULTI_CONFIG)
		set(BUILD_PATH "${path}/${MULTI_CONFIG_BUILD_DIR}")
	else()
		dk_error("Neither SINGLE_CONFIG or MULTI_CONFIG is set")
	endif()
	dk_printVar(BUILD_PATH)
	
	# Configure with CMake		(multi_config / single_config)
	if(EXISTS "${path}/CMakeLists.txt")
		dk_info("Configuring with CMake")
		dk_validate(DKCMAKE_BUILD "dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
		set(command_list ${DKCMAKE_BUILD} ${ARGN} ${path})				
		dk_mergeFlags("${command_list}" command_list)		
		dk_replaceAll("${command_list}" ";" "\" \n\"" command_string)
		dk_fileWrite("${BUILD_PATH}/DKBUILD.log" "\"${command_string}\"\n\n")
		#dk_queueCommand(${DKCMAKE_BUILD} ${ARGN} ${path} OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
		dk_queueCommand(${command_list}                                               WORKING_DIRECTORY "${BUILD_PATH}" OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
		dk_fileAppend("${BUILD_PATH}/DKBUILD.log" "${echo_output}\n\n\n")
		return()
	
	# Configure with Autotools	(single_config)
	elseif(EXISTS ${path}/configure.ac)
		dk_info("Configuring with Autotools")			
		dk_fileAppend(${BUILD_PATH}/DKBUILD.log "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}\n")
		if(EXISTS ${path}/configure)
			if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
				dk_queueCommand(bash -c "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}"  WORKING_DIRECTORY "${BUILD_PATH}" OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
				dk_fileAppend(${BUILD_PATH}/DKBUILD.log "${echo_output}\n\n\n")
			else()
				dk_queueCommand(../../configure ${DKCONFIGURE_FLAGS} ${ARGN}            WORKING_DIRECTORY "${BUILD_PATH}" OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
				dk_fileAppend(${BUILD_PATH}/DKBUILD.log "${echo_output}\n\n\n")
			endif()
		else()
			dk_warning("No configure file found. It may need to be generated with autotools")
		endif()
		return()
		
	# No Specific configure type. Just pass the arguments to dk_queueCommand to run
	else()
		dk_notice("configure type not detected. just run arguments")	
		dk_fileAppend(${BUILD_PATH}/DKBUILD.log "${ARGN}\n")
		if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
			#dk_replaceAll("${ARGN}"  ";"  " "  BASH_COMMANDS)
			#dk_queueCommand(bash -c "${ANDROID_BASH_EXPORTS} ${BASH_COMMANDS}")
			#dk_queueCommand(${ARGN} BASH_ENV)
			dk_queueCommand(${ARGN} BASH_ENV                                            WORKING_DIRECTORY "${BUILD_PATH}" OUTPUT_VARIABLE echo_output)# ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_fileAppend(${BUILD_PATH}/DKBUILD.log "${echo_output}\n\n\n")
		else()
			dk_queueCommand(${ARGN} BASH_ENV                                            WORKING_DIRECTORY "${BUILD_PATH}" OUTPUT_VARIABLE echo_output)# ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_fileAppend(${BUILD_PATH}/DKBUILD.log "${echo_output}\n\n\n")
		endif()
		return()
	endif()
endfunction()
dk_createOsMacros("dk_configure")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()