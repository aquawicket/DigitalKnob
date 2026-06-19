#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_Target_Build()
#
#	Target_Build = Debug, Release
#
function(dk_Target_Build)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(Target_Build "${ARGV0}")
	
	###### GET ######	
	elseif(DEFINED ENV{Target_Build})
		dk_set(Target_Build "$ENV{Target_Build}")
	
	else()
		dk_echo()
		if(Target_Build_Cache)
			dk_echo(" 0) ${Target_Build_Cache}")
		endif()
		
		dk_echo()
		dk_echo(" 1) Release")
		dk_echo(" 2) Debug")
		dk_echo(" 3) Go Back")
		dk_echo(" 4) Exit")
		dk_echo()
		
		dk_keyboardInput(input)
		if("${input}" EQUAL "0")
			dk_set(Target_Build ${Target_Build_Cache})
		elseif("${input}" STREQUAL "1")
			dk_set(Target_Build "Release")
		elseif("${input}" EQUAL "2")
			dk_set(Target_Build "Debug")
		elseif("${input}" EQUAL "3")
			dk_unset(Target_Env)
		elseif("${input}" EQUAL "4")
			dk_exit(0)
		else()
			dk_warning("invalid selection: '${input}'")
		endif()
	endif()
	
	dk_set(${Target_Build} 1)	
	
	###### VALIDATE RESULT ######
	if(Debug)
	elseif(Release)
	else()
		dk_fatal("Target_Build:'${Target_Build}' is INVALID!")
	endif()
	
	dk_debug("Target_Build = ${Target_Build}")
	dk_debug("${Target_Build} = ${${Target_Build}}")
	
	### Target_Build ###
	dk_validate(Target_Tuple	"dk_Target_Tuple()")
	if(Debug)
		dk_set(Target_Build_Dir   "${Target_Tuple}/${Debug_Dir}")
	elseif(Release)
		dk_set(Target_Build_Dir   "${Target_Tuple}/${Release_Dir}")
	endif()
	dk_assertVar(Target_Build_Dir)
	dk_debug("Target_Build_Dir = ${Target_Build_Dir}")
	
	### CURRENT_PLUGIN_Build_Dir ###
	if(CURRENT_PLUGIN)
		dk_set(${CURRENT_PLUGIN}_Build_Dir "${${CURRENT_PLUGIN}}/${Target_Build_Dir}")
		dk_debug("${CURRENT_PLUGIN}_Build_Dir = ${${CURRENT_PLUGIN}_Build_Dir}")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	###### GET ######
    dk_Target_Build()
	dk_echo("Target_Build = ${Target_Build}")
	dk_echo("${Target_Build} = ${${Target_Build}}")
	
	###### SET ######
	dk_Target_Build("All")
	dk_echo("Target_Build = ${Target_Build}")
	dk_echo("${Target_Build} = ${${Target_Build}}")
endfunction()