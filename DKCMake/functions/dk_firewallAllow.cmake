include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_firewallAllow(name executable)
#
#	@name		 	- The name of the firewall rule
#   @executable		- The path to the executable to allow
#
function(dk_firewallAllow name executable)
	dk_debugFunc(${ARGV})
	
	return()	# this function is disabled for now
	
	if(NOT WIN_HOST)
		return()
	endif()
	
	dk_replaceAll("${executable}" "/" "\\\\" executable) #replace / with \

	dk_command(netsh advfirewall firewall add rule name="${name}" dir=in action=allow program="${executable}" enable=yes profile=any)
	dk_command(netsh advfirewall firewall add rule name="${name}" dir=out action=allow program="${executable}" enable=yes profile=any) 
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()