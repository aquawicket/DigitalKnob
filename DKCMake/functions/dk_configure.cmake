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
	
	if(NOT EXISTS ${path})
		dk_error("dk_configure(${path}) path does not exist")
	endif()
	
	# Configure with CMake		(multi_config / single_config)
	if(EXISTS ${path}/CMakeLists.txt)
		dk_info("Configuring with CMake")
		#dk_setPath(${path}/${BUILD_DIR})
		dk_queueCommand(${DKCMAKE_BUILD} ${ARGN} ${path}) 	# ${DKCMAKE_BUILD} from DKBuildFlags.cmake
		return()
		
	# Configure with Autotools	(single_config)	
	elseif(EXISTS ${path}/configure)
		dk_info("Configuring with Autotools")
		dk_setPath(${path}/${BUILD_DIR})
		dk_queueCommand(${DKCONFIGURE_BUILD} ${ARGN})		# ${DKCONFIGURE_BUILD} from DKBuildFlags.cmake
		return()
	endif()
	
	dk_error("dk_configure(): ${path} has no configureable files")
endfunction()
dk_createOsMacros("dk_configure")