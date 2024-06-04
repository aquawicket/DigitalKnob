include(${DKCMAKE_DIR}/functions/DK.cmake)
include_guard()

###############################################################################
# dk_validateBranch()
#
#
function(dk_validateBranch)
	dk_debugFunc(${ARGV})
	
	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	get_filename_component(FOLDER ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
	set(DKBRANCH "Development")
	
	dk_validate DIGITALKNOB_DIR "dk_getDKPaths"
	

	
endfunction()
