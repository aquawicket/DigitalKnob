include_guard()

###############################################################################
# dk_visualStudioDebug(path) #target #arch
#
#	TODO
#
#	@path		- TODO
#
function(dk_visualStudioDebug path) #target #arch
	DKDEBUGFUNC(${ARGV})
	
	if(NOT MSVC) #if(NOT VISUAL_STUDIO)
		return()
	endif()
	
	if(NOT EXISTS ${path})
		dk_error("dk_visualStudioDebug(${path}) path does not exist")
	endif()
	
	dk_findFiles(${path}/${OS} *.sln sln_file)
	dk_getFilename(${sln_file} sln_file)
	dk_getExtension(${sln_file} extension)
	if(NOT ${extension} STREQUAL ".sln")
		dk_error("extension does not equal .sln")
	endif()
	
	if(DEBUG AND QUEUE_BUILD)
		if(NOT EXISTS ${path}/${OS}/${sln_file})
			dk_error("CANNOT FIND: ${path}/${OS}/${sln_file}" )
		endif()
		if(${ARGC} GREATER 2)
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${OS}/${sln_file} /t:${ARGV1} /p:Configuration=Debug /p:Platform=${ARGV2})
		elseif(${ARGC} GREATER 1)
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${OS}/${sln_file} /t:${ARGV1} /p:Configuration=Debug)
		else()
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${OS}/${sln_file} /p:Configuration=Debug)
		endif()
		dk_executeProcess(${EXECUTE_COMMAND} WORKING_DIRECTORY ${path}/${OS})
	endif()
endfunction()
dk_createOsMacros("dk_visualStudioDebug" "NO_DEBUG_RELEASE_TAGS")