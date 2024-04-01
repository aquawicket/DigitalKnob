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
		
		dk_queueCommand(${DKCMAKE_BUILD} ${ARGN} ${path}) 					# ${DKCMAKE_BUILD} from DKBuildFlags.cmake
		return()
	
	# Configure with Autotools	(single_config)	
	elseif(EXISTS ${path}/configure.ac)
		dk_info("Configuring with Autotools")
		dk_setPath(${path}/${SINGLE_CONFIG_BUILD_DIR})
		if(EXISTS ${path}/configure)
			if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
				dk_queueCommand(bash -c "../../configure ${DKCONFIGURE_FLAGS} ${ARGN}")
			else()
				dk_queueCommand(../../configure ${DKCONFIGURE_FLAGS} ${ARGN})	# ${DKCONFIGURE_FLAGS} from DKBuildFlags.cmake
			endif()
		else()
			dk_warn("No configure file found. It needs to be generated with autotools")
		endif()
		return()
		
	# No Specific configure type. Just pass the arguments to dk_queueCommand to run
	else()
		dk_notice("configure type not detected. just run arguments")
		dk_setPath(${path}/${SINGLE_CONFIG_BUILD_DIR})
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