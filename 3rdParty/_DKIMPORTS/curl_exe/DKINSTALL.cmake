#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


####################################################################
# curl_exe
#
function(DKINSTALL)
dk_debugFunc(0 1)
	
	### Test if already valid
	if(EXISTS "${curl_exe}")
		execute_process(COMMAND ${curl_exe} --version RESULT_VARIABLE exit_code OUTPUT_QUIET)
		if("${exit_code}" STREQUAL "0")
			return()
		endif()
	endif()

	if(EXISTS "${curl_exe}")
		message("curl_exe:'${curl_exe}' already exists")
		dk_return()
	endif()

	###### GET curl_exe ######
	if(NOT EXISTS "${curl_exe}")
		dk_findProgram(curl_exe curl.exe)
	endif()
	#if(NOT EXISTS "${curl_exe}")
	#	dk_debug("DKSHELL = ${DKSHELL}")
	#	execute_process(COMMAND $ENV{DKSHELL} -c "command -v curl" OUTPUT_VARIABLE curl_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	#endif()

	####### CHECK curl_exe ######
	if(NOT EXISTS "${curl_exe}")
		dk_fatal("curl_exe:'${curl_exe}' NOT FOUND")
	endif()
	
	### Test command
	execute_process(COMMAND "${curl_exe}" --version RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(${exit_code})
		dk_error("curl_exe:'${curl_exe}' FAILED")
		return()
	endif()
	
	dk_set(curl_exe "${curl_exe}")

endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_unset(curl_exe)
	
	dk_validate(curl_exe "dk_depend(curl_exe)")
	dk_debug("curl_exe = ${curl_exe}")
	
	dk_validate(curl_exe "dk_depend(curl_exe)")
	dk_debug("curl_exe = ${curl_exe}")
endfunction()	