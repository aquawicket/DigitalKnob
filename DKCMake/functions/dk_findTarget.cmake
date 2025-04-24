#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
	
<<<<<<< HEAD
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
=======
	dk_validate(ENV{DIGITALKNOB_DIR} "dk_DIGITALKNOB_DIR()")
	## search up to 4 levels deep
	file(GLOB children RELATIVE $ENV{DIGITALKNOB_DIR}/ 
		$ENV{DIGITALKNOB_DIR}/${target}/DKINSTALL.cmake 
		$ENV{DIGITALKNOB_DIR}/**/${target}/DKINSTALL.cmake 
		$ENV{DIGITALKNOB_DIR}/**/**/${target}/DKINSTALL.cmake 
		$ENV{DIGITALKNOB_DIR}/**/**/**/${target}/DKINSTALL.cmake
		$ENV{DIGITALKNOB_DIR}/**/**/**/**/${target}/DKINSTALL.cmake)
	foreach(child ${children})
		dk_info("FOUND: $ENV{DIGITALKNOB_DIR}/${child}")
		dk_replaceAll($ENV{DIGITALKNOB_DIR}/${child} "/DKINSTALL.cmake" "" path)
		set(${RESULT_PATH} ${path} PARENT_SCOPE)
		
		file(STRINGS ${path}/DKINSTALL.cmake dkmake_string)
>>>>>>> Development
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
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()