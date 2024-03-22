include_guard()

###############################################################################
# dk_setPath(path)
#
#	TODO
#
#	@path	- TODO
#
function(dk_setPath path)
	DKDEBUGFUNC(${ARGV})
	#if(path STREQUAL "OFF")
	#	return() 
	#endif()	
	
	if(NOT EXISTS ${path})
		dk_warn("path:${path} does not exist.")
		dk_warn("Creating directory: ${path})")
		dk_makeDirectory(${path})
	endif()
	
	dk_set(CURRENT_DIR ${path})
	
	# TODO https://stackoverflow.com/a/6595001/688352
	# NOTE: Some 3rdParty projects break when their binary output path is changed. It may be better to compile the project normally, then do a library install to a final common location 
#	if(WIN_HOST)
#		foreach(item ${DKCMAKE_BUILD})
#			#string(FIND "${item}" "-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=" index)
#			#if(${index} GREATER -1)
#			dk_includes("${item}" "-DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=" result)
#			if(${result})
#				list(REMOVE_ITEM DKCMAKE_BUILD ${item})
#			endif()
#	
#			#string(FIND "${item}" "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=" index)
#			#if(${index} GREATER -1)
#			dk_includes("${item}" "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=" result)
#			if(${result})
#				list(REMOVE_ITEM DKCMAKE_BUILD ${item})
#			endif()
#		
#			#string(FIND "${item}" "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=" index)
#			#if(${index} GREATER -1)
#			dk_includes("${item}" "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=" result)
#			if(${result})
#				list(REMOVE_ITEM DKCMAKE_BUILD ${item})
#			endif()
#		endforeach()
#		dk_set(DKCMAKE_BUILD ${DKCMAKE_BUILD} -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=${CURRENT_DIR} -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=${CURRENT_DIR} -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=${CURRENT_DIR})
#	endif()
endfunction()
dk_createOsMacros("dk_setPath")