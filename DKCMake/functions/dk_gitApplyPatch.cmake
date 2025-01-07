#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_gitApplyPatch(<directory> <patch_file>)
#
#	<directory>		- Full path to the directory of the file to patch
#   <patch_file>		- Full path to the patch file
#
#	https://stackoverflow.com/a/66755317/688352
#
function(dk_gitApplyPatch directory patch_file)
	dk_debugFunc(2)
	
	dk_depend(git) # dk_import will push to the PLUGIN stack
#	if("${CURRENT_PLUGIN}" STREQUAL "GIT" AND PREV_PLUGIN)				
#		dk_set(CURRENT_PLUGIN ${PREV_PLUGIN})						# so we will pop the stack here
		
		###### Print the current plugin to the window title bar ######
#		dk_title("CURRENT_PLUGIN -> ${CURRENT_PLUGIN}")
#	endif()
	
	dk_unset(COMMAND_ARGS)
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
			dk_warning("'Could not apply patch: ${patch_file}'")
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
	dk_debugFunc()
	
	dk_gitApplyPatch("C:/Users/Administrator/digitalknob/Development/3rdParty/rmlui-master" "C:/Users/Administrator/digitalknob/Development/3rdParty/_DKIMPORTS/rmlui/rmlui.patch")
endfunction()




