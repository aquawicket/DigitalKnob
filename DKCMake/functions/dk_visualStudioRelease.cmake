#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_visualStudioRelease(path) #target #arch
#
#	TODO
#
#	@path		- TODO
#
function(dk_visualStudioRelease path) #target #arch
	dk_debugFunc()
	
	if(NOT MSVC) #if(NOT VISUAL_STUDIO)
		dk_return()
	endif()
	
	if(NOT EXISTS ${path})
		dk_fatal("dk_visualStudioRelease(${path}) path does not exist")
	endif()
	
	dk_findFiles(${path}/${Target_Tuple} *.sln sln_file)
	dk_basename(${sln_file} sln_file)
	
	dk_getExtension(${sln_file} extension)
	if(NOT ${extension} STREQUAL ".sln")
		dk_fatal("extension does not equal .sln")
	endif()
	
	if(Release AND QUEUE_BUILD)
		if(NOT EXISTS ${path}/${Target_Tuple}/${sln_file})
			dk_fatal("CANNOT FIND: ${path}/${Target_Tuple}/${sln_file}")
		endif()
		if(${ARGC} GREATER 2)
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${Target_Tuple}/${sln_file} /t:${ARGV1} /p:Configuration=Release /p:Platform=${ARGV2})
		elseif(${ARGC} GREATER 1)
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${Target_Tuple}/${sln_file} /t:${ARGV1} /p:Configuration=Release)
		else()
			set(EXECUTE_COMMAND ${MSBUILD} ${path}/${Target_Tuple}/${sln_file} /p:Configuration=Release)
		endif()
		dk_exec(${EXECUTE_COMMAND} WORKING_DIRECTORY ${path}/${Target_Tuple})
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()