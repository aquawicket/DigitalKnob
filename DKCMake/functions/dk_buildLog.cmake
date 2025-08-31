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
# dk_buildLog(entry) PATH
#
#	Log an entry to a DKBUILD.log file in the projects ouput directory.
#   (will also be printed on screen)
#
#
function(dk_buildLog)
	dk_debugFunc(1 2)
	
	dk_getParameterValue(PATH)
	
	set(msg "${ARGV0}")
	dk_echo("${msg}")
		
	if(NOT PATH)
		dk_validate(Target_App_Dir "dk_Target_Tuple()")
		dk_validate(Target_Config "dk_Target_Config()")
		set(PATH "${Target_App_Dir}/${Target_Config}")
	endif()
		
	
	if(NOT EXISTS "${PATH}")
		dk_warning("Cannot write DKBUILD.log. Directory does not exist")
		return()
	endif()
	dk_fileAppend("${PATH}/DKBUILD.log" "${msg}\n")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_buildLog("test entry")
	set(myVar "my variable")
	dk_buildLog(myVar)
endfunction()