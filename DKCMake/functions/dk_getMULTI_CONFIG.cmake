include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
##include_guard()


##################################################################################
# dk_getMULTI_CONFIG()
#
#
function(dk_getMULTI_CONFIG)
	dk_debugFunc(${ARGV})

	###### set MULTI_CONFIG / SINGLE_CONFIG variables ######
	get_property(MULTI_CONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
	if(MULTI_CONFIG)
		dk_set(MULTI_CONFIG TRUE)
		dk_info("*** ${CMAKE_GENERATOR}: Generator is Multi-Config ***")
	else()
		dk_set(SINGLE_CONFIG TRUE)
		dk_info("*** ${CMAKE_GENERATOR}: Generator is Single-Config ***")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_getMULTI_CONFIG()
endfunction()
