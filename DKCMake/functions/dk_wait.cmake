#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
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
	dk_debugFunc("\${ARGV}")
	
	dk_isNumber("${ARGV0}" isNumber)
	if(isNumber)
		set(timeout ${ARGV0})
		set(msg "${ARGV1}") 
	else()
		set(timeout 60) # default
		set(msg "${ARGV0}")
	endif()
	
	dk_echo("\n\n${msg}\nWaiting ${timeout} seconds...\npress any key to continue.")
	
	# FIXME: This needs to adhear to the shell type we are in. Not the host OS. Hence, we can be on a WIN32 host 
	# yet, still be in a unix environment.. and timeout wont work, and vice versa. 
	# We need to find a true way to determine if we are in a cmd, powershell or unix sh / bash type shell.
	math(EXPR timeout_p1 ${timeout}+1)
	
	dk_depend(bash)
	#find_program(BASH_EXE bash)
	dk_depend(cmd)
	#find_program(CMD_EXE cmd.exe)
	if(BASH_EXE) #if(UNIX_HOST OR MINGW)
		execute_process(COMMAND bash -c "read -n 1 -r -s -t ${timeout}" TIMEOUT ${timeout_p1})
	elseif(CMD_EXE) #elseif(WIN_HOST OR WIN32)
		execute_process(COMMAND cmd /c "timeout ${timeout}" TIMEOUT ${timeout_p1})
	else()
		dk_fatal("dk_wait(): Not implemented for this platform")
	endif()	
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()