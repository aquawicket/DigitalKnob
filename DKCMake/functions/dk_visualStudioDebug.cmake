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
# dk_visualStudioDebug(Source_Dir, Target, Arch)
#
#
#	@Source_Dir
#
function(dk_visualStudioDebug)
	dk_debugFunc()
	
	if(NOT MSVC)
		dk_return()
	endif()
	
	###### CURRENT_PLUGIN ######
	dk_assertPath(${CURRENT_PLUGIN})
	
	###### Source_Dir ######
	if(ARGV)
		set(Source_Dir "${ARGV0}")
	else()
		set(Source_Dir "${${CURRENT_PLUGIN}}")
	endif()
	dk_assertPath(Source_Dir)
	
	###### Target ######
	if(ARGV)
		set(Target "${ARGV1}")
	endif()
	
	###### Arch ######
	if(ARGV)
		set(Arch "${ARGV2}")
	endif()
	
	dk_findFiles(${Source_Dir}/${Target_Tuple} *.sln sln_file)
	dk_basename(${sln_file} sln_file)
	dk_getExtension(${sln_file} extension)
	if(NOT ${extension} STREQUAL ".sln")
		dk_fatal("extension does not equal .sln")
	endif()
	
	if(Debug)
		if(NOT EXISTS ${Source_Dir}/${Target_Tuple}/${sln_file})
			dk_error("${Source_Dir}/${Target_Tuple}/${sln_file} not found")
		endif()
		if(${ARGC} GREATER 2)
			dk_exec(${MSBUILD} ${Source_Dir}/${Target_Tuple}/${sln_file} /t:${Target} /p:Configuration=Debug /p:Platform=${Arch} WORKING_DIRECTORY ${Source_Dir}/${Target_Tuple})
		elseif(${ARGC} GREATER 1)
			dk_exec(${MSBUILD} ${Source_Dir}/${Target_Tuple}/${sln_file} /t:${Target} /p:Configuration=Debug WORKING_DIRECTORY ${Source_Dir}/${Target_Tuple})
		else()
			dk_exec(${MSBUILD} ${Source_Dir}/${Target_Tuple}/${sln_file} /p:Configuration=Debug WORKING_DIRECTORY ${Source_Dir}/${Target_Tuple})
		endif()
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()