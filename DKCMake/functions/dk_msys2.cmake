include_guard()

###############################################################################
# dk_msys2(args)
#
#	TODO
#
#	@args	- TODO
#
function(dk_msys2)
	DKDEBUGFUNC(${ARGV})
	#string(REPLACE "C:/" "/c/" ARGV "${ARGV}")
	dk_info("\n${CLR}${magenta} msys2> ${ARGV}\n")
	
	execute_process(COMMAND ${MSYS2}/usr/bin/bash -c "export PATH=${MSYS2}/mingw64/bin:$PATH; export PATH=${MSYS2}/usr/bin:$PATH;" ${ARGV}
		RESULT_VARIABLE result 
		ERROR_VARIABLE error 
		WORKING_DIRECTORY ${CURRENT_DIR} 
		OUTPUT_STRIP_TRAILING_WHITESPACE)
		
	if(NOT ${result} EQUAL 0)
		dk_debug(command	PRINTVAR)
		dk_debug(result		PRINTVAR)
		dk_debug(error		PRINTVAR)
	endif()
endfunction()
dk_createOsMacros("dk_msys2")