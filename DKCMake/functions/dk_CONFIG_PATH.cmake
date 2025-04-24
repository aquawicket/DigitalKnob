#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
##include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development


##################################################################################
# dk_CONFIG_PATH()
#
#
function(dk_CONFIG_PATH)
	dk_debugFunc()
	
<<<<<<< HEAD
	dk_validate(DKBUILD_TYPE  "dk_DKBUILD_TYPE()")  	# get {DEBUG} {RELEASE}
	dk_validate(TARGET_TRIPLE "dk_TARGET_TRIPLE()")		# get {triple}
=======
	dk_validate(target_type  	"dk_target_type()")     # get {DEBUG} {RELEASE}
	dk_validate(target_triple   "dk_target_triple()")	# get {target_triple}
>>>>>>> Development
	
	###### set MULTI_CONFIG / SINGLE_CONFIG variables ######
	get_property(MULTI_CONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
	if(MULTI_CONFIG)
		if(CMAKE_BUILD_TYPE)
			dk_error("multi-config generators don't use CMAKE_BUILD_TYPE")
		endif()
		
		dk_set(MULTI_CONFIG 1)
		dk_unset(SINGLE_CONFIG)
<<<<<<< HEAD
		dk_set(CONFIG_PATH ${triple})
		if(DEBUG)
			dk_set(BUILD_PATH   ${triple}/${DEBUG_DIR})
		elseif(RELEASE)
			dk_set(BUILD_PATH   ${triple}/${RELEASE_DIR})
=======
		dk_set(CONFIG_PATH ${target_triple})
		if(DEBUG)
			dk_set(BUILD_PATH   ${target_triple}/${DEBUG_DIR})
		elseif(RELEASE)
			dk_set(BUILD_PATH   ${target_triple}/${RELEASE_DIR})
>>>>>>> Development
		endif()
		dk_validate(CMAKE_GENERATOR "dk_CMAKE_GENERATOR()")
		dk_info("*** ${CMAKE_GENERATOR}: Generator is MULTI_CONFIG (${CMAKE_CONFIGURATION_TYPES}) ***")
		
		dk_assertVar(MULTI_CONFIG)
		dk_assertVar(CONFIG_PATH)
		dk_assertVar(BUILD_PATH)
		
	else() # SINGLE_CONFIG
		if(CMAKE_CONFIGURATION_TYPES)
			dk_error("single-config generators don't use CMAKE_CONFIGURATION_TYPES")
		endif()
		
		dk_set(SINGLE_CONFIG 1)
		dk_unset(MULTI_CONFIG)
		if(DEBUG)
			dk_set	(CMAKE_BUILD_TYPE Debug)
<<<<<<< HEAD
			dk_set	(CONFIG_PATH ${triple}/${DEBUG_DIR})
			dk_set	(BUILD_PATH ${triple}/${DEBUG_DIR})
=======
			dk_set	(CONFIG_PATH ${target_triple}/${DEBUG_DIR})
			dk_set	(BUILD_PATH ${target_triple}/${DEBUG_DIR})
>>>>>>> Development
			
			dk_validate(CMAKE_GENERATOR "dk_CMAKE_GENERATOR()")
			dk_info("*** ${CMAKE_GENERATOR}: Generator is SINGLE_CONFIG (${CMAKE_BUILD_TYPE}) ***")
		elseif(RELEASE)
			dk_set	(CMAKE_BUILD_TYPE Release)
<<<<<<< HEAD
			dk_set	(CONFIG_PATH ${triple}/${RELEASE_DIR})
			dk_set	(BUILD_PATH ${triple}/${RELEASE_DIR})
=======
			dk_set	(CONFIG_PATH ${target_triple}/${RELEASE_DIR})
			dk_set	(BUILD_PATH ${target_triple}/${RELEASE_DIR})
>>>>>>> Development
			
			dk_validate(CMAKE_GENERATOR "dk_CMAKE_GENERATOR()")
			dk_info("*** ${CMAKE_GENERATOR}: Generator is SINGLE_CONFIG (${CMAKE_BUILD_TYPE}) ***")
		endif()
		
		dk_assertVar(SINGLE_CONFIG)
		dk_assertVar(CMAKE_BUILD_TYPE)
		dk_assertVar(CONFIG_PATH)
		dk_assertVar(BUILD_PATH)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_CONFIG_PATH()
endfunction()
