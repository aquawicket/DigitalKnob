include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_configure(SOURCE_DIR) #ARGN
#
#	@SOURCE_DIR - The path to the configure file to use, CMakeLists.txt for cmake, configure for Unix, Etc.
#
function(dk_configure SOURCE_DIR) #ARGN
	dk_debugFunc("\${ARGV}")
	
	dk_validate(DKBUILD_TYPE "dk_getBUILD_TYPE()")
	dk_validate(BUILD_DIR "dk_getMULTI_CONFIG()")
	
	#dk_set(BINARY_DIR "${SOURCE_DIR}/${BUILD_DIR}")
	dk_set(BINARY_DIR "${CURRENT_PLUGIN_DIR}/${BUILD_DIR}")
	
	# Configure with CMake		(multi_config / single_config)
	if(EXISTS ${SOURCE_DIR}/CMakeLists.txt)
		dk_info("Configuring with CMake")
		
		dk_validate(DKCMAKE_BUILD "dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
		set(command_list ${DKCMAKE_BUILD} ${ARGN} "-S=${SOURCE_DIR}" "-B=${BINARY_DIR}")			
		dk_mergeFlags("${command_list}" command_list)		
		dk_replaceAll("${command_list}" ";" "\" \n\"" command_string)
		dk_fileWrite(${BINARY_DIR}/DKBUILD.log "\"${command_string}\"\n\n")
		dk_queueCommand(${command_list} OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
		dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		
		dk_set(DKCMAKE_BUILD ${CMAKE_EXE} -G ${CMAKE_GENERATOR} ${DKCMAKE_FLAGS})  # restore any altered flags
		return()
	
	# Configure with Autotools	(single_config)
	elseif(EXISTS ${SOURCE_DIR}/configure.ac) # OR EXISTS ${SOURCE_DIR}/configure)
		dk_info("Configuring with Autotools")			
		dk_fileAppend(${BINARY_DIR}/DKBUILD.log "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}\n")
		if(EXISTS ${SOURCE_DIR}/configure)
			if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
				dk_queueCommand(bash -c "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}" OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
				dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
			else()
				dk_queueCommand(../../configure ${DKCONFIGURE_FLAGS} ${ARGN} OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
				dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
			endif()
		else()
			dk_warning("No configure file found. It may need to be generated with autotools")
		endif()
		return()
		
	# No Specific configure type. Just pass the arguments to dk_queueCommand to run
	else()
		dk_notice("configure type not detected. just run arguments")
#		if(SINGLE_CONFIG)
#			# Make sure the plugin variable is alpha-numeric and uppercase
#			dk_assert(SINGLE_CONFIG_BUILD_DIR)
#			dk_cd(${SOURCE_DIR}/${SINGLE_CONFIG_BUILD_DIR})
#		endif()
		dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${ARGN}\n")
		if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
			dk_queueCommand(${ARGN} BASH_ENV OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
		else()
			dk_queueCommand(${ARGN} BASH_ENV OUTPUT_VARIABLE echo_output ERROR_VARIABLE echo_output ECHO_OUTPUT_VARIABLE)
			dk_fileAppend(${BINARY_DIR}/DKBUILD.log "${echo_output}\n\n\n")
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