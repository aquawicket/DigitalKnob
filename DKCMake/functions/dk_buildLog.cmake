#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_buildLog(entry) PATH
#
#	Log an entry to a DKBUILD.log file in the projects ouput directory.
#   (will also be printed on screen)
#
#
function(dk_buildLog entry)
	dk_debugFunc()
	
	dk_getParameterValue(PATH)
	
	if(DEFINED "${entry}")
		set(msg "${entry} = ${${entry}}")
	else()
		set(msg "${entry}")
	endif()
	dk_info("${msg}")
	
	dk_validate(Target_App_Dir "dk_Target_Tuple()")  #TODO - move to 'dk_DK_Project_Dir.cmake'
	dk_validate(CONFIG_PATH "dk_CONFIG_PATH()")
	dk_assertPath("${Target_App_Dir}/${CONFIG_PATH}")
	dk_fileAppend("${Target_App_Dir}/${CONFIG_PATH}/DKBUILD.log" "${msg}\n")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_buildLog("test entry")
	set(myVar "my variable")
	dk_buildLog(myVar)
endfunction()