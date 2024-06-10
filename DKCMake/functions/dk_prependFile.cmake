include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_prependFile(path string)
#
#	TODO
#
#	@path	- TODO
#	@string	- TODO
# 
function(dk_prependFile path string)
	dk_debugFunc(${ARGV})
	
	file(READ "${path}" file_data)
	file(write "${pah}" "${string}\n${filedata}")
endfunction()