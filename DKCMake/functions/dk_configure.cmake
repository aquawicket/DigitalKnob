include_guard()

###############################################################################
# dk_configure(path) #ARGN
#
#	TODO
#
#	@path - The path to the configure file to use, CMakeLists.txt for cmake, Configure for Unix, Etc.
#
function(dk_configure path) #ARGN
	DKDEBUGFUNC(${ARGV})
	
	# Configure with CMake		(multi_config / single_config)
	if(EXISTS ${path}/CMakeLists.txt)
		dk_info("Configuring with CMake")
		if(SINGLE_CONFIG)
			# Make sure the plugin variable is alpha-numeric and uppercase
			string(TOUPPER ${plugin} PLUGIN_NAME)
			string(MAKE_C_IDENTIFIER ${PLUGIN_NAME} PLUGIN_NAME)
			dk_setPath(${${PLUGIN_NAME}}/${SINGLE_CONFIG_BUILD_DIR}) 
		endif()
		
		set(command_list ${DKCMAKE_BUILD} ${ARGN} ${path})				
		dk_mergeFlags("${command_list}" command_list)		
		string(REPLACE ";" "\" \n\"" command_string "${command_list}")
		
		file(WRITE ${CURRENT_DIR}/DKBUILD.log "\"${command_string}\"\n\n")
		
		#dk_queueCommand(${DKCMAKE_BUILD} ${ARGN} ${path} OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
		dk_queueCommand(${command_list} OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
		file(APPEND ${CURRENT_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		
		return()
	
	# Configure with Autotools	(single_config)
	elseif(EXISTS ${path}/configure.ac)
		dk_info("Configuring with Autotools")
		dk_setPath(${path}/${SINGLE_CONFIG_BUILD_DIR})
		
		file(APPEND ${CURRENT_DIR}/DKBUILD.log "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}\n")
		if(EXISTS ${path}/configure)
			if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
				#dk_queueCommand(bash -c "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}")
				dk_queueCommand(bash -c "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}" OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
				file(APPEND ${CURRENT_DIR}/DKBUILD.log "${echo_output}\n\n\n")
			else()
				#dk_queueCommand(../../configure ${DKCONFIGURE_FLAGS} ${ARGN})
				dk_queueCommand(../../configure ${DKCONFIGURE_FLAGS} ${ARGN} OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
				file(APPEND ${CURRENT_DIR}/DKBUILD.log "${echo_output}\n\n\n")
			endif()
		else()
			dk_warning("No configure file found. It may need to be generated with autotools")
		endif()
		return()
		
	# No Specific configure type. Just pass the arguments to dk_queueCommand to run
	else()
		dk_notice("configure type not detected. just run arguments")
		dk_setPath(${path}/${SINGLE_CONFIG_BUILD_DIR})
		
		file(APPEND ${CURRENT_DIR}/DKBUILD.log "${ARGN}\n")
		if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
			#string(REPLACE ";" " " BASH_COMMANDS "${ARGN}")
			#dk_queueCommand(bash -c "${ANDROID_BASH_EXPORTS} ${BASH_COMMANDS}")
			#dk_queueCommand(${ARGN} BASH_ENV)
			dk_queueCommand(${ARGN} BASH_ENV OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			file(APPEND ${CURRENT_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		else()
			dk_info("dk_queueCommand(${ARGN})")
			#dk_queueCommand(${ARGN})
			dk_queueCommand(${ARGN} BASH_ENV OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			file(APPEND ${CURRENT_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		endif()
		return()
	endif()
endfunction()
dk_createOsMacros("dk_configure")