include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_gitApplyPatch(<directory> <patch_file>)
#
#	<directory>		- Full path to the directory of the file to patch
#   <patch_file>		- Full path to the patch file
#
#	https://stackoverflow.com/a/66755317/688352
#
function(dk_gitApplyPatch directory patch_file)
	dk_debugFunc("\${ARGV}")
	
	dk_validate(GIT_EXE "dk_installGit()")
	dk_append(COMMAND_ARGS ${GIT_EXE})
	dk_append(COMMAND_ARGS apply)
	dk_append(COMMAND_ARGS --verbose)
	dk_append(COMMAND_ARGS --no-index)
	dk_append(COMMAND_ARGS --unsafe-paths)
	dk_append(COMMAND_ARGS --directory=${directory})
	dk_append(COMMAND_ARGS ${patch_file})
	dk_append(COMMAND_ARGS --reject)
	execute_process(COMMAND ${COMMAND_ARGS}
					WORKING_DIRECTORY ${DIGITALKNOB_DIR}
					RESULT_VARIABLE result
					OUTPUT_VARIABLE output
					OUTPUT_STRIP_TRAILING_WHITESPACE)
	dk_debug("result = ${result}")
	dk_debug("output = ${output}")
	if(NOT ${result} EQUAL 0)
			dk_error("ERROR: 'An error occured patching with ${patch_file}'")
	endif()
	dk_success("Patch successful: ${patch_file}")
	
	
#	dk_validate(GIT_EXE "dk_installGit()")
#	dk_append(COMMAND_ARGS ${GIT_EXE})
#	dk_append(COMMAND_ARGS apply)
#	dk_append(COMMAND_ARGS --verbose)
#	dk_append(COMMAND_ARGS --no-index)
#	dk_append(COMMAND_ARGS --unsafe-paths)
#	dk_append(COMMAND_ARGS --directory=${directory})
#	dk_append(COMMAND_ARGS ${patch_file})
#	execute_process(COMMAND ${COMMAND_ARGS}
#					WORKING_DIRECTORY ${DIGITALKNOB_DIR}
#					RESULT_VARIABLE result
#					OUTPUT_VARIABLE output
#					OUTPUT_STRIP_TRAILING_WHITESPACE)
#	if(NOT ${result} EQUAL 0)
#			dk_error("ERROR: 'An error occured patching with ${patch_file}'")
#	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc("\${ARGV}")
	
	dk_gitApplyPatch("C:/Users/Administrator/digitalknob/Development/3rdParty/rmlui-master" "C:/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/rmlui/termux.patch")
endfunction()




