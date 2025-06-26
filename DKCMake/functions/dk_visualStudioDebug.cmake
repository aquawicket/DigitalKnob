#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_visualStudioDebug(Source_Dir) #target #arch
#
#	TODO
#
#	@Source_Dir		- TODO
#
function(dk_visualStudioDebug Source_Dir) #target #arch
	dk_debugFunc()
	
	if(NOT MSVC)
		dk_return()
	endif()
	
	dk_assertPath(Source_Dir)
	
	dk_findFiles(${Source_Dir}/${Target_Tuple} *.sln sln_file)
	dk_basename(${sln_file} sln_file)
	dk_getExtension(${sln_file} extension)
	if(NOT ${extension} STREQUAL ".sln")
		dk_fatal("extension does not equal .sln")
	endif()
	
	if(Debug)
		if(NOT EXISTS ${Source_Dir}/${Target_Tuple}/${sln_file})
			dk_fatal("CANNOT FIND: ${Source_Dir}/${Target_Tuple}/${sln_file}" )
		endif()
		if(${ARGC} GREATER 2)
			set(EXECUTE_COMMAND ${MSBUILD} ${Source_Dir}/${Target_Tuple}/${sln_file} /t:${ARGV1} /p:Configuration=Debug /p:Platform=${ARGV2})
		elseif(${ARGC} GREATER 1)
			set(EXECUTE_COMMAND ${MSBUILD} ${Source_Dir}/${Target_Tuple}/${sln_file} /t:${ARGV1} /p:Configuration=Debug)
		else()
			set(EXECUTE_COMMAND ${MSBUILD} ${Source_Dir}/${Target_Tuple}/${sln_file} /p:Configuration=Debug)
		endif()
		dk_exec(${EXECUTE_COMMAND} WORKING_DIRECTORY ${Source_Dir}/${Target_Tuple})
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()