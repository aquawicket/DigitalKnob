#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_createShortcut(shortcut_path, target_path) arguments
#
#
function(dk_createShortcut shortcut_path target_path) # arguments
	dk_debugFunc()
	dk_debug("dk_createShortcut(${ARGV}).cmake")
	
	set(arguments ${ARGN})
	if(DEFINED ENV{WSL_DISTRO_NAME})
		#execute_process(COMMAND ${WSLPATH_EXE} -m "${shortcut_path}" OUTPUT_VARIABLE shortcut_path COMMAND_ECHO STDOUT OUTPUT_STRIP_TRAILING_WHITESPACE)
		#dk_replaceAll("${shortcut_path}" "/mnt/c" "C:" shortcut_path)
		#dk_replaceAll("${target_path}" "/mnt/c" "C:" target_path)
	endif()

	if(arguments)
		dk_callDKPowershell(dk_createShortcut rtn_var "${shortcut_path}" "${target_path}" ${arguments})
	else()
		dk_callDKPowershell(dk_createShortcut rtn_var "${shortcut_path}" "${target_path}")
	endif()
	
	#FIXME: This does not work
	#if(NOT EXISTS "${shortcut_path}")
	#	dk_fatal("dk_createShortcut failed.  shortcut_path:${shortcut_path} not found")
	#endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(ENV{DKDESKTOP_DIR}   "dk_DKDESKTOP_DIR()")
	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
	dk_validate(DKDOWNLOAD_DIR  "dk_DIGITALKNOB_DIR()")
	
	#dk_createShortcut("$ENV{DKDESKTOP_DIR}/digitalknob.lnk" "C:/Users/Administrator/digitalknob")
	dk_createShortcut("C:/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/linux_x86_64/Debug/HelloWorld_APP.lnk" "C:/Windows/System32/wsl.exe" "/mnt/c/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/linux_x86_64/Debug/HelloWorld_APP")
endfunction()
