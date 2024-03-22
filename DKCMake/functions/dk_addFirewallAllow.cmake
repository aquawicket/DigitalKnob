include_guard()

###############################################################################
# dk_addFirewallAllow(name executable)
#
#	@name		 	- The name of the firewall rule
#   @executable		- The path to the executable to allow
#
function(dk_addFirewallAllow name executable)
	DKDEBUGFUNC(${ARGV})
	return()	# this function is disabled for now
	
	if(NOT WIN_HOST)
		return()
	endif()
	
	string(REPLACE "/" "\\\\" executable "${executable}") #replace / with \

	dk_command(netsh advfirewall firewall add rule name="${name}" dir=in action=allow program="${executable}" enable=yes profile=any)
	dk_command(netsh advfirewall firewall add rule name="${name}" dir=out action=allow program="${executable}" enable=yes profile=any) 
endfunction()