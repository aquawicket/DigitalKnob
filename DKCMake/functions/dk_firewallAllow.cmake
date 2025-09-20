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
	
	#dk_callDKBatch(dk_firewallAllow "${ARGV0}" "${ARGV1}")
	dk_callDKBatch(dk_firewallAllow ${ARGV})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_firewallAllow("curl_exe" "C:/Windows/System32/curl.exe")
	dk_firewallAllow("C:/Windows/System32/curl.exe")
endfunction()
