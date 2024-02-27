include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


###############################################################################
# dk_command(args) NOASSERT
#
#	TODO
#
#	@args	- TODO
#
function(dk_command)
	DKDEBUGFUNC(${ARGV})
	
	#dk_includes("${ARGN}" "NOASSERT" has_NOASSERT)
	#if(${has_NOASSERT})
	#	set(NOASSERT NOASSERT)
	#endif()
	
	dk_mergeFlags("${ARGV}" merged_args)
	#string(REPLACE ";" " " spaced_args "${merged_args}")
	#dk_info("\n${CLR}${magenta} dk_command> ${spaced_args}\n")
	
	#if(EMSCRIPTEN)
	#	dk_executeProcess(${EMMAKE} bash ${merged_args})
	#else()
	
	if(MSYS OR MINGW OR MSYSTEM)
		dk_msys2_bash(${merged_args})
	else()
		dk_executeProcess(${merged_args})
	endif()
endfunction()
dk_createOsMacros("dk_command")