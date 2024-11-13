#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_findTarget(target RESULT_PATH RESULT_TYPE)
#
#	TODO
#
#	@target			- TODO
#	@RESULT_PATH	- TODO
#	@RESULT_TYPE	- TODO
#
function(dk_findTarget target RESULT_PATH RESULT_TYPE)
	dk_debugFunc()
	
	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
	## search up to 4 levels deep
	file(GLOB children RELATIVE ${DIGITALKNOB_DIR}/ 
		${DIGITALKNOB_DIR}/${target}/DKMAKE.cmake 
		${DIGITALKNOB_DIR}/**/${target}/DKMAKE.cmake 
		${DIGITALKNOB_DIR}/**/**/${target}/DKMAKE.cmake 
		${DIGITALKNOB_DIR}/**/**/**/${target}/DKMAKE.cmake
		${DIGITALKNOB_DIR}/**/**/**/**/${target}/DKMAKE.cmake)
	foreach(child ${children})
		dk_info("FOUND: ${DIGITALKNOB_DIR}/${child}")
		dk_replaceAll(${DIGITALKNOB_DIR}/${child} "/DKMAKE.cmake" "" path)
		set(${RESULT_PATH} ${path} PARENT_SCOPE)
		
		file(STRINGS ${path}/DKMAKE.cmake dkmake_string)
		if(dkmake_string MATCHES "DKAPP")
			set(${RESULT_TYPE} APP PARENT_SCOPE) 
		else()
			set(${RESULT_TYPE} LIBRARY PARENT_SCOPE)	#LIBRARY is default, we need to label executables to detect them
		endif()
		return()
	endforeach()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()