include_guard()

###############################################################################
# dk_appendEnvPath(path)
#
#	@path	- The CMake / style full path to append the the Environment Path variable
#
function(dk_appendEnvPath path)
	dk_debug("dk_appendEnvPath(${ARGV})")
	if(NOT EXISTS ${path})
		dk_warn("dk_appendEnvPath(): path:${} path does not exist")
		return()
	endif()
	if(NOT path)
		return()
	endif()
	if(WIN_HOST)
		set(path_printable "${path}" CACHE FILEPATH:"")
		string(REPLACE "/" "\\" path_printable "${path_printable}")
		string(REPLACE "/" "\\" path "${path}")
	else()
		set(path_printable "${path}")
	endif()
	
	dk_debug(ENV{PATH}  PRINTVAR)
	string(FIND "$ENV{PATH}" "${path}" hasPath)
	if(${hasPath} GREATER -1)
		dk_warn("${path_printable} is already in the PATH environment list\n")
	else()
		set(ENV{PATH} "$ENV{PATH};${path}")
		dk_info("added ${path_printable} to the PATH environment list\n")
	endif()
	dk_debug(ENV{PATH}  PRINTVAR)
endfunction()
