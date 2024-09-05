include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_gitApplyPatch(<directory> <patch_file>)
#
#	<directory>		- The directory to patch from
#   <patch_file>	- Full path to the patch file
#
#	https://stackoverflow.com/a/66755317/688352
#
function(dk_gitApplyPatch directory patch_file)
	dk_debugFunc(${ARGV})
	
	## First run a check 
	dk_append(COMMAND_ARGS git)
	dk_append(COMMAND_ARGS apply)
	dk_append(COMMAND_ARGS --check)
	dk_append(COMMAND_ARGS --verbose)
	dk_append(COMMAND_ARGS ${patch_file})
	dk_info(COMMAND ${COMMAND_ARGS})
	execute_process(COMMAND ${COMMAND_ARGS}
					WORKING_DIRECTORY ${directory}
					RESULT_VARIABLE result
					OUTPUT_VARIABLE output
					OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(NOT ${result} EQUAL 0)
		#dk_error("ERROR: 'An error occured patching with ${patch_file}'")
		return()	# RETURN if the patch check failed, it may have already been patched
	endif()
	#dk_printVar(output)
	
	## Then do the actual patch 
	dk_append(COMMAND_ARGS git)
	dk_append(COMMAND_ARGS apply)
	#dk_append(COMMAND_ARGS --check)
	dk_append(COMMAND_ARGS --verbose)
	dk_append(COMMAND_ARGS ${patch_file})
	execute_process(COMMAND ${COMMAND_ARGS}
					WORKING_DIRECTORY ${directory}
					RESULT_VARIABLE result
					OUTPUT_VARIABLE output
					OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(NOT ${result} EQUAL 0)
		dk_error("ERROR: 'An error occured patching with ${patch_file}'")
	endif()
	#dk_printVar(output)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()
