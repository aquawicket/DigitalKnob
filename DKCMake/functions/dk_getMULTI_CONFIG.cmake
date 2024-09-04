include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
##include_guard()


##################################################################################
# dk_getMULTI_CONFIG()
#
#
function(dk_getMULTI_CONFIG)
	dk_debugFunc(${ARGV})
	
	dk_validate(DKBUILD_TYPE "dk_getBUILD_TYPE()")  # get DEBUG, RELEASE variables
	dk_validate(OS           "dk_getTargetTriple()")
	
	###### set MULTI_CONFIG / SINGLE_CONFIG variables ######
	get_property(MULTI_CONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
	if(MULTI_CONFIG)
		if(CMAKE_BUILD_TYPE)
			dk_error("multi-config generators don't use CMAKE_BUILD_TYPE")
		endif()
		
		#dk_printVar(CMAKE_CONFIGURATION_TYPES)
		dk_unset(SINGLE_CONFIG)
		dk_set(MULTI_CONFIG 1)
		dk_set(BUILD_DIR ${triple})
		dk_set(MULTI_CONFIG_BUILD_DIR ${triple})
		dk_info("*** ${CMAKE_GENERATOR}: Generator is Multi-Config ***")
		
		dk_assert(MULTI_CONFIG)
		dk_assert(BUILD_DIR)
		dk_assert(MULTI_CONFIG_BUILD_DIR)
	
	else() # SINGLE_CONFIG
		if(CMAKE_CONFIGURATION_TYPES)
			dk_error("single-config generators don't use CMAKE_CONFIGURATION_TYPES")
		endif()
		
		dk_set(SINGLE_CONFIG 1)
		dk_unset(MULTI_CONFIG)
		
		if(DEBUG)
			dk_set	(CMAKE_BUILD_TYPE Debug)
			dk_set	(BUILD_DIR ${triple}/${DEBUG_DIR})
			dk_set	(SINGLE_CONFIG_BUILD_DIR ${triple}/${DEBUG_DIR})
			dk_info("*** ${CMAKE_GENERATOR}: Generator is Single-Config (Debug) ***")
		elseif(RELEASE)
			dk_set	(CMAKE_BUILD_TYPE Release)
			dk_set	(BUILD_DIR ${triple}/${RELEASE_DIR})
			dk_set	(SINGLE_CONFIG_BUILD_DIR ${triple}/${RELEASE_DIR})
			dk_info("*** ${CMAKE_GENERATOR}: Generator is Single-Config (Release) ***")
		endif()
		
		dk_assert(SINGLE_CONFIG)
		dk_assert(BUILD_DIR)
		dk_assert(CMAKE_BUILD_TYPE)
		dk_assert(SINGLE_CONFIG_BUILD_DIR)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_getMULTI_CONFIG()
endfunction()
