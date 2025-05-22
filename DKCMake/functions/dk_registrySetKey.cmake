#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_registrySetKey(key value data)
#
#	TODO
#
#	@key	- TODO
#	@value	- TODO
#	@data	- TODO
#
function(dk_registrySetKey key value data)
	dk_debugFunc()

	
	if(Windows_Host)
		dk_replaceAll(${key}  "/"  "\\"  key)
		dk_replaceAll(${value}  "/"  "\\"  value)
		dk_replaceAll(${data}  "/"  "\\"  data)
		execute_process(COMMAND reg add "${key}" /v "${value}" /t REG_SZ /d "${data}" /f /reg:64 OUTPUT_VARIABLE _output ERROR_VARIABLE _output RESULT_VARIABLE _failed)
		dk_verbose(output)
		dk_verbose(_failed)
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()