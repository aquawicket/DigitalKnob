include_guard()

###############################################################################
# dk_applyPatch(directory patch_file)
#
#	@directory		- The directory to patch from
#   @patch_file		- Full path to the patch file
#
#	https://stackoverflow.com/a/66755317/688352
#
macro(dk_applyPatch directory patch_file)

	## First run a check 
	set(COMMAND_ARGS "")
	set(COMMAND_ARGS ${COMMAND_ARGS} git)
	set(COMMAND_ARGS ${COMMAND_ARGS} apply)
	set(COMMAND_ARGS ${COMMAND_ARGS} --check)
	set(COMMAND_ARGS ${COMMAND_ARGS} --verbose)
	set(COMMAND_ARGS ${COMMAND_ARGS} ${patch_file})
	dk_debug("${COMMAND_ARGS}")
	execute_process(COMMAND ${COMMAND_ARGS}
					WORKING_DIRECTORY ${directory}
					RESULT_VARIABLE result
					OUTPUT_VARIABLE output
					OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(NOT ${result} EQUAL 0)
		#dk_error("ERROR: 'An error occured patching with ${patch_file}'")
		return()	# RETURN if the patch check failed, it may have already been patched
	endif()
	dk_debug(output)
	
	## THen do the actual patch 
	set(COMMAND_ARGS "")
	set(COMMAND_ARGS ${COMMAND_ARGS} git)
	set(COMMAND_ARGS ${COMMAND_ARGS} apply)
	#set(COMMAND_ARGS ${COMMAND_ARGS} --check)
	set(COMMAND_ARGS ${COMMAND_ARGS} --verbose)
	set(COMMAND_ARGS ${COMMAND_ARGS} ${patch_file})
	dk_debug(COMMAND_ARGS)
	execute_process(COMMAND ${COMMAND_ARGS}
					WORKING_DIRECTORY ${directory}
					RESULT_VARIABLE result
					OUTPUT_VARIABLE output
					OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(NOT ${result} EQUAL 0)
		dk_error("ERROR: 'An error occured patching with ${patch_file}'")
	endif()
	dk_info(output)
endmacro()