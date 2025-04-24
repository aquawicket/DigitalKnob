#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_firewallAllow(name executable)
#
#	@name		 	- The name of the firewall rule
#   @executable		- The path to the executable to allow
#
<<<<<<< HEAD
function(dk_firewallAllow name executable)
	dk_debugFunc()
	
	return()	# this function is disabled for now
	
	if(NOT WIN_HOST)
		return()
	endif()
	
	dk_replaceAll("${executable}" "/" "\\\\" executable) #replace / with \

	dk_command(netsh advfirewall firewall add rule name="${name}" dir=in action=allow program="${executable}" enable=yes profile=any)
	dk_command(netsh advfirewall firewall add rule name="${name}" dir=out action=allow program="${executable}" enable=yes profile=any) 
=======
function(dk_firewallAllow)
	message("dk_firewallAllow.cmake(${ARGV})")
	dk_debugFunc(2)
	
	#dk_assertPath("${ARGV1}")
	dk_callDKBatch(dk_firewallAllow "${ARGV0}" "${ARGV1}")
>>>>>>> Development
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
endfunction()
=======
	dk_debugFunc(0)
	
	dk_firewallAllow("CMake-Gui" "C:/Users/Administrator/digitalknob/DKTools/cmake-3.29.5-windows-x86_64/bin/cmake-gui.exe")
endfunction()
>>>>>>> Development
