include_guard()

###############################################################################
# dk_getUnixPath(path unix_path)
#
#	@path		 	- windows in path
#   @unix_path		- The returned unix style path
#
macro(dk_getUnixPath path unix_path)
	if(WIN32)
		dk_depend(MSYS2)
		execute_process(COMMAND cygpath.exe "${path}" OUTPUT_VARIABLE ${unix_path} OUTPUT_STRIP_TRAILING_WHITESPACE)
		string (STRIP ${unix_path} unix_path)
	endif(WIN32)
endmacro()