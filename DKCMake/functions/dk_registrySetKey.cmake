include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

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
	dk_debugFunc(${ARGV})

	
	if(WIN_HOST)
		dk_replaceAll(${key}  "/"  "\\"  key)
		dk_replaceAll(${value}  "/"  "\\"  value)
		dk_replaceAll(${data}  "/"  "\\"  data)
		execute_process(COMMAND reg add "${key}" /v "${value}" /t REG_SZ /d "${data}" /f /reg:64 OUTPUT_VARIABLE _output ERROR_VARIABLE _output RESULT_VARIABLE _failed)
		dk_verbose(output)
		dk_verbose(_failed)
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()