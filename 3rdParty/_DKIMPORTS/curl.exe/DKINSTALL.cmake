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
# DKINSTALL()
#
function(DKINSTALL)
dk_debugFunc(0 1)
	
	execute_process(COMMAND "${curl.exe}" --version RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(NOT "${exit_code}" STREQUAL "0")
		dk_pathToCmake("$ENV{curl.exe}" curl.exe)
	endif()
	
	execute_process(COMMAND "${curl.exe}" --version RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(NOT "${exit_code}" STREQUAL "0")
		dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
		set(curl.exe "${DKTOOLS_DIR}/cosmos/curl")
		if(NOT EXISTS "${curl.exe}")
			dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
			dk_download("https://cosmo.zip/pub/cosmos/bin/curl" "${DKDOWNLOAD_DIR}/curl")
			dk_copy("${DKDOWNLOAD_DIR}/curl" "${curl.exe}")
		endif()
	endif()

	execute_process(COMMAND "${curl.exe}" --version RESULT_VARIABLE exit_code)
	if(NOT "${exit_code}" STREQUAL "0")
		if(EXISTS "${curl.exe}")
			dk_error("curl.exe:'${curl.exe}' FAILED")
		else()
			dk_error("curl.exe:'${curl.exe}' NOT FOUND")
		endif()
		return()
	endif()
	
	
	#return
	dk_firewallAllow("${curl.exe}")
	dk_set(curl.exe "${curl.exe}")
	#dk_debug("curl.exe = ${curl.exe}")	

endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)	
	
	dk_echo()
	dk_echo("####### Test dk_depend curl.exe ######")
	dk_unset(curl.exe)
	dk_validate(curl.exe "dk_depend(curl.exe)")
	dk_debug("curl.exe = ${curl.exe}")
	execute_process(COMMAND "${curl.exe}" --version RESULT_VARIABLE exit_code)
	
#	dk_echo()
#	dk_echo("###### Test %%dk_call%% curl.exe ######")
#	dk_unset(curl.exe)
#	dk_call(curl.exe --version)
	
endfunction()	