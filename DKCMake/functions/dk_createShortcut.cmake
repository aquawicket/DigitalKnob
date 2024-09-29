#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_createShortcut(shortcut_path, target_path) arguments
#
#
function(dk_createShortcut shortcut_path target_path) # arguments
	dk_debugFunc("\${ARGV}")
	#dk_debug("dk_createShortcut(${ARGV})")
	
	set(arguments ${ARGN})
	if(DEFINED ENV{WSLENV})
		execute_process(COMMAND wslpath -m "${shortcut_path}" OUTPUT_VARIABLE shortcut_path COMMAND_ECHO STDOUT OUTPUT_STRIP_TRAILING_WHITESPACE)
	endif()

	if(arguments)
		dk_callDKPowershell(dk_createShortcut '${shortcut_path}' '${target_path}' '${arguments}')
	else()
		dk_callDKPowershell(dk_createShortcut '${shortcut_path}' '${target_path}')
	endif()
	
	#if(NOT EXISTS "${shortcut_path}")
	#	dk_fatal("dk_createShortcut failed.  shortcut_path:${shortcut_path} not found")
	#endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_validate(DKDESKTOP_DIR   "dk_DKHOME_DIR()")
	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
	dk_validate(DKDOWNLOAD_DIR  "dk_DIGITALKNOB_DIR()")
	
	#dk_createShortcut("${DKDESKTOP_DIR}/digitalknob.lnk" "C:/Users/Administrator/digitalknob")
	dk_createShortcut("${DKDESKTOP_DIR}/HelloWorld.lnk" "C:/Windows/System32/wsl.exe" "/mnt/c/Users/Administrator/digitalknob/Development/DKApps/HelloWorld/linux_x86_64/Debug/HelloWorld_APP")
endfunction()
