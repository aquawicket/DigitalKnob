include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_linkDir(path)
#
#	Add a directory to the compiler library paths
#
#	@path	The path to add to the compiler library paths
#
function(dk_linkDir path)
	dk_debugFunc(${ARGV})
	
	#foreach(item ${ARGV})
		#list(FIND DKLINKDIRS_LIST "${item}" index)
		#list(FIND DKLINKDIRS_LIST "${path}" index)
		if(path IN_LIST DKLINKDIRS_LIST)
		if(${index} GREATER -1)
			continue()  # already in the list
		endif()
		#dk_append(DKLINKDIRS_LIST ${item})
		dk_append(DKLINKDIRS_LIST ${path})
		#link_directories(${item})
		link_directories(${path})
	#endforeach()
endfunction()
dk_createOsMacros("dk_linkDir")




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()