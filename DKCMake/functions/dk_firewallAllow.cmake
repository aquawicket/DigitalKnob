#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_firewallAllow(name executable)
#
#	@name		 	- The name of the firewall rule
#   @executable		- The path to the executable to allow
#
function(dk_firewallAllow name executable)
	dk_debugFunc()
	
	return()	# this function is disabled for now
	
	if(NOT WIN_HOST)
		return()
	endif()
	
	dk_replaceAll("${executable}" "/" "\\\\" executable) #replace / with \

	dk_command(netsh advfirewall firewall add rule name="${name}" dir=in action=allow program="${executable}" enable=yes profile=any)
	dk_command(netsh advfirewall firewall add rule name="${name}" dir=out action=allow program="${executable}" enable=yes profile=any) 
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()