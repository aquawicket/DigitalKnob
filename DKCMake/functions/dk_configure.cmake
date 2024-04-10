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
		
		dk_mergeFlags("${ARGN}" ARGN)
		set(file_output "${DKCMAKE_BUILD};${ARGN};${path}")
		string(REPLACE ";" "\n" file_output "${file_output}")
		message(file_output = "${file_output}")
		file(WRITE ${CURRENT_DIR}/DKBUILD.log "${file_output}\n\n")
		
		dk_queueCommand(${DKCMAKE_BUILD} ${ARGN} ${path} OUTPUT_VARIABLE echo_output ECHO_OUTPUT_VARIABLE) 					# ${DKCMAKE_BUILD} from DKBuildFlags.cmake
		file(APPEND ${CURRENT_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		
		return()
	
	# Configure with Autotools	(single_config)
	elseif(EXISTS ${path}/configure.ac)
		dk_info("Configuring with Autotools")
		dk_setPath(${path}/${SINGLE_CONFIG_BUILD_DIR})
		
		file(APPEND ${CURRENT_DIR}/DKBUILD.log "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}\n")
		if(EXISTS ${path}/configure)
			if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
				dk_queueCommand(bash -c "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}")
			else()
				dk_queueCommand(../../configure ${DKCONFIGURE_FLAGS} ${ARGN})	# ${DKCONFIGURE_FLAGS} from DKBuildFlags.cmake
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
			dk_queueCommand(${ARGN} BASH_ENV)
		else()
			dk_info("dk_queueCommand(${ARGN})")
			#dk_queueCommand(${ARGN})
			dk_queueCommand(${ARGN} BASH_ENV)
		endif()
		return()
	endif()
endfunction()
dk_createOsMacros("dk_configure")