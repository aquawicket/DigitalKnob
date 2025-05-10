#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_buildApp()
#
#
function(dk_buildApp)
	dk_debugFunc(0)

	dk_echo()
	dk_echo("###############################################################################")
	dk_echo("****** Building ${Target_App} - ${Target_Tuple} - ${Target_Type} - ${Target_Level} ******")
	dk_echo("###############################################################################")
	dk_echo()
	
	dk_validate(DKCPP_APPS_DIR "dk_DKBRANCH_DIR()")
	if(("${Target_Type}" STREQUAL "Debug") OR ("${Target_Type}" STREQUAL "All"))
		if(EXISTS "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}/Debug/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}/Debug" --verbose) #--config Debug
		elseif(EXISTS "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}" --verbose) #--config Debug
		else()
			dk_error("Could not find CMakeCache.txt in ${Target_App}/${Target_Tuple}/Debug or ${Target_App}/${Target_Tuple}")
		endif()
	endif()
	if(("${Target_Type}" STREQUAL "Release") OR ("${Target_Type}" STREQUAL "All"))
		if(EXISTS "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}/Release/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}/Release" --config Release --verbose)
		elseif(EXISTS "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}" --config Release --verbose)
		else()
			dk_error("Could not find CMakeCache.txt in ${Target_App}/${Target_Tuple}/Release or ${Target_App}/${Target_Tuple}")
		endif()
	endif()
	
	dk_echo()
	dk_echo("####################################################################################")
	dk_echo("****** Done Building ${Target_App} - ${Target_Tuple} - ${Target_Type} - ${Target_Level} ******")
	dk_echo("####################################################################################")
	dk_echo()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_buildApp()
endfunction()
