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
	dk_debugFunc("\${ARGV}")
	
	dk_validate(DKBUILD_TYPE "dk_getBUILD_TYPE()")
	dk_validate(BUILD_DIR "dk_getMULTI_CONFIG()")
	
	set(BUILD_PATH "${path}/${BUILD_DIR}")
	dk_assert(path)
	dk_getOption(NO_HALT 	${ARGV})
	
	# Configure with CMake		(multi_config / single_config)
	if(EXISTS ${path}/CMakeLists.txt)
		dk_info("Configuring with CMake")
		if(SINGLE_CONFIG)
			# Make sure the plugin variable is alpha-numeric and uppercase
			dk_printVar(path)
			dk_printVar(plugin)
			dk_assert(plugin)
			dk_toUpper(${plugin} PLUGIN_NAME)
			dk_convertToCIdentifier(${PLUGIN_NAME} PLUGIN_NAME)
			dk_assert(SINGLE_CONFIG_BUILD_DIR)
			dk_cd(${${PLUGIN_NAME}}/${SINGLE_CONFIG_BUILD_DIR})
		endif()
		
		dk_validate(DKCMAKE_BUILD "dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
		set(command_list ${DKCMAKE_BUILD} ${ARGN} ${path})				
		dk_mergeFlags("${command_list}" command_list)		
		dk_replaceAll("${command_list}" ";" "\" \n\"" command_string)
		
		dk_fileWrite(${PWD}/DKBUILD.log "\"${command_string}\"\n\n")
		
		#dk_queueCommand(${DKCMAKE_BUILD} ${ARGN} ${path} OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
		dk_queueCommand(${command_list} OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
		dk_fileAppend(${PWD}/DKBUILD.log "${echo_output}\n\n\n")
		
		return()
	
	# Configure with Autotools	(single_config)
	elseif(EXISTS ${path}/configure.ac OR EXISTS ${path}/configure)
		dk_info("Configuring with Autotools")			
		dk_fileAppend(${BUILD_PATH}/DKBUILD.log "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}\n")
		if(EXISTS ${path}/configure)
			if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
				#dk_queueCommand(bash -c "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}" WORKING_DIRECTORY "${BUILD_PATH}" OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
				dk_queueCommand(bash -c "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}" OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
				dk_fileAppend(${BUILD_PATH}/DKBUILD.log "${echo_output}\n\n\n")
			else()
				#dk_queueCommand(../../configure ${DKCONFIGURE_FLAGS} ${ARGN} WORKING_DIRECTORY "${BUILD_PATH}" OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
				dk_queueCommand(../../configure ${DKCONFIGURE_FLAGS} ${ARGN} OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
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
			#dk_queueCommand(${ARGN} BASH_ENV WORKING_DIRECTORY "${BUILD_PATH}" OUTPUT_VARIABLE echo_output)# ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_queueCommand(${ARGN} BASH_ENV OUTPUT_VARIABLE echo_output)# ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_fileAppend(${BUILD_PATH}/DKBUILD.log "${echo_output}\n\n\n")
		else()
			#dk_queueCommand(${ARGN} BASH_ENV WORKING_DIRECTORY "${BUILD_PATH}" OUTPUT_VARIABLE echo_output)# ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_queueCommand(${ARGN} BASH_ENV OUTPUT_VARIABLE echo_output)# ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_fileAppend(${BUILD_PATH}/DKBUILD.log "${echo_output}\n\n\n")
		endif()
		return()
	endif()
endfunction()
dk_createOsMacros("dk_configure")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()