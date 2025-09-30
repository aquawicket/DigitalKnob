#!/usr/bin/cmake -P


### DK.cmake ###############################################################
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
# dk_firewallAllow(executable)
# dk_firewallAllow(name executable)
#
#	@name:optional 	- The name of the firewall rule
#   @executable		- The path to the executable to allow
#
function(dk_firewallAllow)
	dk_debugFunc(1 2)
	
	if(ARGV1)
		set(_name_ "${ARGV0}")
		set(_executable_ "${ARGV1}")
	else()
		set(_executable_ "${ARGV0}")
		dk_basename("${_executable_}" _name_)
		dk_removeExtension("${_name_}" _name_)
	endif()
	dk_assertVar(_name_)
	dk_assertVar(_executable_)
	#cmake_path(NATIVE_PATH _executable_ NORMALIZE _executable_)
	string(REPLACE "/" "\\" _executable_ ${_executable_})
	dk_debug("_name_ = ${_name_}")
	dk_debug("_executable_ = ${_executable_}")
	
	if("${dk_firewallAllow_DEBUG}" STREQUAL "1")
		dk_echo("${bg_blue} ${white} dk_firewallAllow ${_name_} ${_executable_} ${clr}")
	endif()
	
	dk_registryContains("HKLM/SYSTEM/ControlSet001/Services/SharedAccess/Parameters/FirewallPolicy/FirewallRules" "${_executable_}")
	if(dk_registryContains)
		if("${dk_firewallAllow_DEBUG}" STREQUAL "1")
			dk_debug("registry already contains a firewall rule for '${_executable_}'")
		endif()
		return()
	endif()
	
	dk_notice("Adding firewall allow rule for ${_name_} ${_executable_} . . .")
	
	#dk_findProgram(netsh_exe netsh.exe "$ENV{windir}/System32")
	if(NOT EXISTS "${netsh_exe}")
		set(netsh_exe "C:/Windows/System32/netsh.exe")
	endif()
	if(EXISTS "${netsh_exe}")
		dk_debug("dk_exec(${netsh_exe} advfirewall firewall add rule name=\"${_name_}\" dir=in action=allow program=\"${_executable_}\" enable=yes profile=any)")
		dk_exec(${netsh_exe} advfirewall firewall add rule name="${_name_}" dir=in action=allow program="${_executable_}" enable=yes profile=any)
		dk_debug("dk_exec(${netsh_exe} advfirewall firewall add rule name=\"${_name_}\" dir=out action=allow program=\"${_executable_}\" enable=yes profile=any)")
		dk_exec(${netsh_exe} advfirewall firewall add rule name="${_name_}" dir=out action=allow program="${_executable_}" enable=yes profile=any)
	endif()
	
	###### Windows Firewall Control ######
	if(NOT EXISTS "${wfc_exe}")
		set(wfc_exe "$ENV{ProgramFiles}/Malwarebytes/Windows Firewall Control/wfc.exe")
	endif()
	if(NOT EXISTS "${wfcUI_exe}")
		set(wfcUI_exe "$ENV{ProgramFiles}/Malwarebytes/Windows Firewall Control/wfcUI.exe")
	endif()
	if(EXISTS "${wfc_exe}")
		set(WFC_APP "${wfc_exe}")
	endif()
	if(EXISTS "${wfcUI_exe}")
		set(WFC_APP "${wfcUI_exe}")
	endif()
	string(REPLACE "/" "\\" WFC_APP ${WFC_APP})
	dk_echo("${WFC_APP}" -allow "${_executable_}")
	dk_exec("${WFC_APP}" -allow "${_executable_}") #|| (echo errorlevel = !errorlevel! & %clearerror%)
	######################################
	
	#dk_callDKBatch(dk_firewallAllow ${ARGV})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_firewallAllow("curl_exe" "C:/Windows/System32/curl.exe")
	dk_firewallAllow("C:/Windows/System32/curl.exe")
	#dk_firewallAllow("C:/Users/Administrator/DigitalKnob/DKTools/git-portable-2.46.2-64-bit/mingw64/libexec/git-core/git-remote-https.exe")
endfunction()
