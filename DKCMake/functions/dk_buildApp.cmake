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
	dk_echo("****** Building ${Target_App} - ${Target_Triple} - ${Target_Type} - ${Target_Level} ******")
	dk_echo("###############################################################################")
	dk_echo()
	
	dk_validate(DKCPP_APPS_DIR "dk_DKBRANCH_DIR()")
	if(("${Target_Type}" STREQUAL "Debug") OR ("${Target_Type}" STREQUAL "All"))
		if(EXISTS "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Triple}/Debug/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Triple}/Debug" --verbose) #--config Debug
		elseif(EXISTS "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Triple}/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Triple}" --verbose) #--config Debug
		else()
			dk_error("Could not find CMakeCache.txt in ${Target_App}/${Target_Triple}/Debug or ${Target_App}/${Target_Triple}")
		endif()
	endif()
	if(("${Target_Type}" STREQUAL "Release") OR ("${Target_Type}" STREQUAL "All"))
		if(EXISTS "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Triple}/Release/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Triple}/Release" --config Release --verbose)
		elseif(EXISTS "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Triple}/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "$ENV{DKCPP_APPS_DIR}/${Target_App}/${Target_Triple}" --config Release --verbose)
		else()
			dk_error("Could not find CMakeCache.txt in ${Target_App}/${Target_Triple}/Release or ${Target_App}/${Target_Triple}")
		endif()
	endif()
	
	dk_echo()
	dk_echo("####################################################################################")
	dk_echo("****** Done Building ${Target_App} - ${Target_Triple} - ${Target_Type} - ${Target_Level} ******")
	dk_echo("####################################################################################")
	dk_echo()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_buildApp()
endfunction()
