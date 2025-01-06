#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

macro(getVar)
	###### ${ARGV0} #####
	set(lvl 0)
	set(value ARGV0)
	set(default ${ARGV1})
	while(DEFINED ${value})
		set(name "${name}-> ${value}")
		set(value ${${value}})
		math(EXPR lvl "${lvl} + 1")
	endwhile()

	message("lvl = ${lvl}")
	message("name = ${name}")
	message("value = ${value}")
	message("default = ${default}")
	
	set(${ARGV1} ${value})
	
	if(NOT ${lvl})
		set(${ARGV0} ${default})
	endif()
endmacro()


##############################################################################
# dk_timeout(seconds)
# 
#	Pause execution and wait for <enter> keypress to continue or amount of seconds to pass
#
function(dk_timeout) 
	dk_debugFunc(0 99)
	
	message("\n")
	message("dk_timeout(${ARGV})")
	
	getVar(${ARGV0} seconds 10)
	message("seconds = ${seconds}")

	
	###### CMD ######
	if(EXISTS "$ENV{COMSPEC}")
		string(REPLACE "/" "\\" CMD_EXE "$ENV{COMSPEC}")  # convert to windows path delimiters
		set(cmnd "${CMD_EXE}" /V:ON /c "timeout /T ${seconds}")
		#dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})	
		return()
	endif()
	
	###### BASH ######
	execute_process(COMMAND bash -c "command -v 'bash'" OUTPUT_VARIABLE BASH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(BASH_EXE)
		set(cmnd ${BASH_EXE} -c "read -t ${seconds} -n 1 -s -r -p \"waiting ${seconds} seconds. Press any key to continue . . .\"")
		#dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})
		dk_return()
	endif()
	
	###### SH ######
	execute_process(COMMAND sh -c "command -v 'sh'" OUTPUT_VARIABLE SH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(SH_EXE)			
		# TODO
		#dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})
		dk_return()
	endif()
	
	###### Powershell ######
	find_program(POWERSHELL_EXE powershell.exe)
	if(POWERSHELL_EXE)
		# TODO
		#dk_debug("${cmnd}")
		execute_process(COMMAND ${cmnd})
		dk_return()
	endif()
	
	dk_fatal("dk_pause() failed:  cant find CMD_EXE, BASH_EXE or SH_EXE!")

endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	
	dk_timeout()
	
	dk_timeout(0)
	
	dk_timeout(1)
	
	dk_timeout("2")
	
	#set(timeA)
	dk_timeout(${timeA})
	
	set(timeB 0)
	dk_timeout(${timeB})
	
	set(timeC 1)
	dk_timeout("${timeC}")
	
	set(timeD 2)
	dk_timeout(timeD)
	
	set(varE 3)
	set(timeE ${varE})
	dk_timeout(timeE)
	
	set(varF 4)
	set(timeF varF)
	dk_timeout(timeF)
	
endfunction()
