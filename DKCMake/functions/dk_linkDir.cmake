include_guard()

###############################################################################
# dk_linkDir(path)
#
#	Add a directory to the compiler library paths
#
#	@path	The path to add to the compiler library paths
#
function(dk_linkDir path)
	DKDEBUGFUNC(${ARGV})
	#foreach(item ${ARGV})
		#list(FIND DKLINKDIRS_LIST "${item}" index)
		list(FIND DKLINKDIRS_LIST "${path}" index)
		if(${index} GREATER -1)
			continue()  # already in the list
		endif()
		#dk_set(DKLINKDIRS_LIST ${DKLINKDIRS_LIST} ${item})
		dk_set(DKLINKDIRS_LIST ${DKLINKDIRS_LIST} ${path})
		#link_directories(${item})
		link_directories(${path})
	#endforeach()
endfunction()
dk_createOsMacros("dk_linkDir")