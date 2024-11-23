#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_firewallAllow(name executable)
#
#	@name		 	- The name of the firewall rule
#   @executable		- The path to the executable to allow
#
function(dk_firewallAllow)
	dk_debugFunc(2)
	
	dk_callDKBatch(dk_firewallAllow output "CMD" "C:\\Windows\\System32\\cmd.exe")
	#dk_callDKBatch(dk_firewallAllow ${ARGV0} ${ARGV1})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_firewallAllow("CMD" "C:\\Windows\\System32\\cmd.exe")
endfunction()