#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_visualStudioDebug(path) #target #arch
#
#	TODO
#
#	@path		- TODO
#
function(dk_visualStudioDebug path) #target #arch
	dk_debugFunc()
	
	if(NOT MSVC) #if(NOT VISUAL_STUDIO)
		dk_return()
	endif()
	
	if(NOT EXISTS ${path})
		dk_fatal("dk_visualStudioDebug(${path}) path does not exist")
	endif()
	
	dk_findFiles(${path}/${triple} *.sln sln_file)
	dk_basename(${sln_file} sln_file)
	dk_getExtension(${sln_file} extension)
	if(NOT ${extension} STREQUAL ".sln")
		dk_fatal("extension does not equal .sln")
	endif()
	
	if(DEBUG AND QUEUE_BUILD)
		if(NOT EXISTS ${path}/${triple}/${sln_file})
			dk_fatal("CANNOT FIND: ${path}/${triple}/${sln_file}" )
		endif()
		if(${ARGC} GREATER 2)
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${triple}/${sln_file} /t:${ARGV1} /p:Configuration=Debug /p:Platform=${ARGV2})
		elseif(${ARGC} GREATER 1)
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${triple}/${sln_file} /t:${ARGV1} /p:Configuration=Debug)
		else()
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${triple}/${sln_file} /p:Configuration=Debug)
		endif()
		dk_executeProcess(${EXECUTE_COMMAND} WORKING_DIRECTORY ${path}/${triple})
	endif()
endfunction()
dk_createOsMacros("dk_visualStudioDebug" "NO_DEBUG_RELEASE_TAGS")






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()