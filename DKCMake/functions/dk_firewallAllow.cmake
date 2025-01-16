#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_firewallAllow(name executable)
#
#	@name		 	- The name of the firewall rule
#   @executable		- The path to the executable to allow
#
function(dk_firewallAllow)
	dk_debugFunc(2)
	
	set(name 	${ARGV0})
	set(exe		${ARGV1})
	
	dk_assertPath(exe)
	dk_getNativePath(${exe} exe)
	
	message("dk_firewallAllow(${ARGV})")
	#dk_callDKBatch(dk_firewallAllow output "CMD" "C:\\Windows\\System32\\cmd.exe")
	dk_callDKBatch(dk_firewallAllow output "${name}" "${exe}")
	#dk_callDKBatch(dk_firewallAllow ${ARGV0} ${ARGV1})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_firewallAllow("CMD" "C:\\Windows\\System32\\cmd.exe")
endfunction()