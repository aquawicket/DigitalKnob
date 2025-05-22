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

##################################################################################
# dk_registryKeyExists() <reg_path>
#
function(dk_registryKeyExists)
    dk_debugFunc()
	
	dk_depend(cmd)
	set(cmnd ${CMD_EXE} /c "reg.exe" query %~1)
	execute_process(COMMAND echo ${cmnd} RESULT_VARIABLE result)
	message("result = ${result}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
    
    #dk_registryKeyExists("HKEY_CURRENT_USER/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.txt")
    dk_registryKeyExists(HKEY_CURRENT_USER)
	dk_registryKeyExists(HKEY_LOCAL_MACH)
endfunction()