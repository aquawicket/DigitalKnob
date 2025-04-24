#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##################################################################################
# dk_registryKeyExists() <reg_path>
#
function(dk_registryKeyExists)
    dk_debugFunc()
	
<<<<<<< HEAD
	set(cmnd cmd /c "reg.exe" query %~1)
=======
	dk_depend(cmd)
	set(cmnd ${CMD_EXE} /c "reg.exe" query %~1)
>>>>>>> Development
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