#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
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
	
	dk_getOptionValue(PATH)
	
	if(DEFINED ${entry})
		set(msg "${entry} = ${${entry}}")
	else()
		set(msg "${entry}")
	endif()
	dk_info("${msg}")
	
	dk_validate(DK_Project_Dir "dk_target_triple()")  #TODO - move to 'dk_DK_Project_Dir.cmake'
	dk_validate(CONFIG_PATH "dk_CONFIG_PATH()")
	dk_assertPath("${DK_Project_Dir}/${CONFIG_PATH}")
	dk_fileAppend("${DK_Project_Dir}/${CONFIG_PATH}/DKBUILD.log" "${msg}\n")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_buildLog("test entry")
	set(myVar "my variable")
	dk_buildLog(myVar)
endfunction()