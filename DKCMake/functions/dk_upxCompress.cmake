include_guard()

###############################################################################
# dk_upxCompress(path)
#
#	UPX compress an executable or dynamic library file
#
#	@path		- The full path to the binary file to compress with UPX
#
function(dk_upxCompress path)
	DKDEBUGFUNC(${ARGV})
	dk_info("UPX compressing ${path}...")
	dk_info("Please wait...")
	dk_executeProcess("${UPX_EXE} -9 -v ${path}")
endfunction()
