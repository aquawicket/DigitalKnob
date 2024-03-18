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
	
	#if(NOT EXISTS ${path})
	#	This could be a bash command then
	#	dk_error("dk_configure(${path}): path does not exist")
	#endif()
	
	# Configure with CMake		(multi_config / single_config)
	if(EXISTS ${path}/CMakeLists.txt)
		dk_info("Configuring with CMake")
		#dk_setPath(${path}/${BUILD_DIR})
		dk_queueCommand(${DKCMAKE_BUILD} ${ARGN} ${path}) 	# ${DKCMAKE_BUILD} from DKBuildFlags.cmake
		return()
	
	# Configure with Autotools	(single_config)	
	elseif(EXISTS ${path}/configure.ac)
		dk_info("Configuring with Autotools")
		dk_setPath(${path}/${BUILD_DIR})
		#dk_queueCommand(${DKCONFIGURE_BUILD} ${ARGN})		# ${DKCONFIGURE_BUILD} from DKBuildFlags.cmake
		if(EXISTS ${path}/configure)
			if(MINGW AND MSYSTEM OR ANDROID)
				dk_queueBash(../../configure ${DKCONFIGURE_FLAGS} ${ARGN})
			else()
				dk_queueCommand(../../configure ${DKCONFIGURE_FLAGS} ${ARGN})
			endif()
		else()
			dk_warn("No configure file found. It needs to be generated with autotools")
		endif()
		return()
		
	# No Specific configure type. Just pass the arguments to dk_queueBash to run
	else()
		dk_info("configure type not detected. just run arguments")
		dk_setPath(${path}/${BUILD_DIR})
		if(MINGW AND MSYSTEM OR ANDROID)
			dk_queueBash(${ARGN})
		else()
			dk_queueCommand(${ARGN})
		endif()
		return()
	endif()
endfunction()
dk_createOsMacros("dk_configure")