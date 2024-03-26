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
			string(TOUPPER ${plugin} PLUGIN_NAME)
			dk_setPath(${${PLUGIN_NAME}}/${SINGLE_CONFIG_BUILD_DIR})
		endif()
		dk_queueCommand(${DKCMAKE_BUILD} ${ARGN} ${path}) 					# ${DKCMAKE_BUILD} from DKBuildFlags.cmake
		return()
	
	# Configure with Autotools	(single_config)	
	elseif(EXISTS ${path}/configure.ac)
		dk_info("Configuring with Autotools")
		dk_setPath(${path}/${SINGLE_CONFIG_BUILD_DIR})
		if(EXISTS ${path}/configure)
			if(MSYSTEM)
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
		if(MSYSTEM)
			dk_queueCommand(bash -c "${ARGN}")
		else()
			dk_queueCommand(${ARGN})
		endif()
		return()
	endif()
endfunction()
dk_createOsMacros("dk_configure")