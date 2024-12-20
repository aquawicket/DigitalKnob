#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##############################################################################
# dk_wait([timeout] [msg])
# 
#	Wait until a keypress or timeout has elapsed in seconds
#
#	@timeout:(Optional)	- default = 60
#	@msg:(Optional)		- default = "press and key to continue."
#
function(dk_wait) 
	dk_debugFunc()
	
	dk_isNumber(isNumber "${ARGV0}")
	if(isNumber)
		set(timeout ${ARGV0})
		set(msg "${ARGV1}") 
	else()
		set(timeout 60) # default
		set(msg "${ARGV0}")
	endif()
	
	#dk_echo("\n\n${msg}\nWaiting ${timeout} seconds...\npress any key to continue.")
	
	# FIXME: This needs to adhear to the shell type we are in. Not the host OS. Hence, we can be on a WIN32 host 
	# yet, still be in a unix environment.. and timeout wont work, and vice versa. 
	# We need to find a true way to determine if we are in a cmd, powershell or unix sh / bash type shell.
	#math(EXPR timeout_p1 ${timeout}+1)
	
	
	#dk_depend(cmd)
	#dk_depend(bash)
	if(NOT CMD_EXE) 
		set(CMD_EXE "$ENV{COMSPECZZZ}")
	endif()
	if((NOT CMD_EXE) AND (NOT BASH_EXE))
		set(BASH_EXE bash)
	endif()
	
	
	if(CMD_EXE)
		execute_process(COMMAND ${CMD_EXE} /c "timeout ${timeout}" TIMEOUT ${timeout})
	elseif(BASH_EXE)
		execute_process(COMMAND ${BASH_EXE} -c "read -n 1 -r -s -t ${timeout}" TIMEOUT ${timeout})
	else()
		dk_fatal("dk_wait(): Not implemented for this platform")
	endif()	
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_wait()
	dk_wait(5)
	dk_wait(3 "CUSTOM WAIT MESSAGE")
endfunction()