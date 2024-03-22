include_guard()

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
	DKDEBUGFUNC(${ARGV})
	## search up to 4 levels deep
	file(GLOB children RELATIVE ${DIGITALKNOB_DIR}/ 
		${DIGITALKNOB_DIR}/${target}/DKMAKE.cmake 
		${DIGITALKNOB_DIR}/**/${target}/DKMAKE.cmake 
		${DIGITALKNOB_DIR}/**/**/${target}/DKMAKE.cmake 
		${DIGITALKNOB_DIR}/**/**/**/${target}/DKMAKE.cmake
		${DIGITALKNOB_DIR}/**/**/**/**/${target}/DKMAKE.cmake)
	foreach(child ${children})
		dk_info("FOUND: ${DIGITALKNOB_DIR}/${child}")
		string(REPLACE "/DKMAKE.cmake" "" path ${DIGITALKNOB_DIR}/${child})
		set(${RESULT_PATH} ${path} PARENT_SCOPE)
		
		file(STRINGS ${path}/DKMAKE.cmake dkmake_string)
		string(FIND "${dkmake_string}" "DKAPP" index)
		if(${index} GREATER -1)
		#dk_includes("${dkmake_string}" "DKAPP" index)
		#if(${index})
			set(${RESULT_TYPE} APP PARENT_SCOPE) 
		else()
			set(${RESULT_TYPE} LIBRARY PARENT_SCOPE)	#LIBRARY is default, we need to label executables to detect them
		endif()
		return()
	endforeach()
endfunction()