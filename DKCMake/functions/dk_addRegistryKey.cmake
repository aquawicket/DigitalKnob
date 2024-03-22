include_guard()

###############################################################################
# dk_addRegistryKey(key value data)
#
#	TODO
#
#	@key	- TODO
#	@value	- TODO
#	@data	- TODO
#
function(dk_addRegistryKey key value data)
	DKDEBUGFUNC(${ARGV})
	if(WIN_HOST)
		string(REPLACE "/" "\\" key   ${key})
		string(REPLACE "/" "\\" value ${value})
		string(REPLACE "/" "\\" data  ${data})
		execute_process(COMMAND reg add "${key}" /v "${value}" /t REG_SZ /d "${data}" /f /reg:64 OUTPUT_VARIABLE _output ERROR_VARIABLE _output RESULT_VARIABLE _failed)
		dk_verbose(output	PRINTVAR)
		dk_verbose(_failed	PRINTVAR)
	endif()
endfunction()