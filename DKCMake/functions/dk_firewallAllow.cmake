#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
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
	
	if(${ARGC} GREATER 1)
		set(dk_firewallAllow_name 	"${ARGV0}")
		set(dk_firewallAllow_executable 	"${ARGV1}")
	else()
		set(dk_firewallAllow_executable 	"${ARGV0}")
		dk_basename("${dk_firewallAllow_executable}" dk_firewallAllow_name)
		dk_removeExtension("${dk_firewallAllow_name}" dk_firewallAllow_name)
	endif()
	dk_assertVar(dk_firewallAllow_name)
	dk_assertVar(dk_firewallAllow_executable)
	#dk_pathToWindows("${dk_firewallAllow_executable}" dk_firewallAllow_executable)
	string(REPLACE "/" "\\" dk_firewallAllow_executable ${dk_firewallAllow_executable})
	#dk_debug("dk_firewallAllow_name = ${dk_firewallAllow_name}")
	#dk_debug("dk_firewallAllow_executable = ${dk_firewallAllow_executable}")
	
	dk_registryContains("HKLM/SYSTEM/ControlSet001/Services/SharedAccess/Parameters/FirewallPolicy/FirewallRules" "${dk_firewallAllow_executable}")
	if(dk_registryContains)
		dk_notice("registry already contains a firewall rule for '${dk_firewallAllow_executable}'")
		return()
	endif()
	
	dk_notice("Adding firewall allow rule for ${dk_firewallAllow_name} ${dk_firewallAllow_executable} . . .")
	
	#dk_findProgram(netsh_exe netsh.exe "$ENV{windir}/System32")
	if(NOT EXISTS "${netsh_exe}")
		set(netsh_exe "C:/Windows/System32/netsh.exe")
	endif()
	if(EXISTS "${netsh_exe}")
		dk_debug("dk_exec(${netsh_exe} advfirewall firewall add rule name=\"${dk_firewallAllow_name}\" dir=in action=allow program=\"${dk_firewallAllow_executable}\" enable=yes profile=any)")
		dk_exec(${netsh_exe} advfirewall firewall add rule name="${dk_firewallAllow_name}" dir=in action=allow program="${dk_firewallAllow_executable}" enable=yes profile=any)
		dk_debug("dk_exec(${netsh_exe} advfirewall firewall add rule name=\"${dk_firewallAllow_name}\" dir=out action=allow program=\"${dk_firewallAllow_executable}\" enable=yes profile=any)")
		dk_exec(${netsh_exe} advfirewall firewall add rule name="${dk_firewallAllow_name}" dir=out action=allow program="${dk_firewallAllow_executable}" enable=yes profile=any)
	endif()
	
	###### Windows Firewall Control ######
	if(NOT EXISTS "${WFC_APP}")
		set(WFC_APP "$ENV{ProgramFiles}/Malwarebytes/Windows Firewall Control/wfc.exe")
	endif()
	if(NOT EXISTS "${WFC_APP}")
		set(WFC_APP "$ENV{ProgramFiles}/Malwarebytes/Windows Firewall Control/wfcUI.exe")
	endif()
	if(EXISTS "${WFC_APP}")
		string(REPLACE "/" "\\" WFC_APP ${WFC_APP})
		dk_debug("${WFC_APP}" -allow "${dk_firewallAllow_executable}")
		dk_exec("${WFC_APP}" -allow "${dk_firewallAllow_executable}")
	endif()
	######################################
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_firewallAllow("curl.exe" "C:/Windows/System32/curl.exe")
	dk_firewallAllow("C:/Windows/System32/curl.exe")
	#dk_firewallAllow("C:/Users/Administrator/DigitalKnob/DKTools/git-portable-2.46.2-64-bit/mingw64/libexec/git-core/git-remote-https.exe")
endfunction()
