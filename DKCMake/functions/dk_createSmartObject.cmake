include(${CMAKE_CURRENT_LIST_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_createSmartObject(object)
#
#	TODO
#	We can scan each plugin and attempt to create it's variable and infomation manually here
#
#	@object		- TODO
#
function(dk_createSmartObject object)
	dk_debugFunc(${ARGV})
	
	dk_todo()
	dk_verbose("dk_createSmartObject(${object})")
	# We require something that can resolve to a full, valid path containing a DKMAKE.cmake file 
endfunction()