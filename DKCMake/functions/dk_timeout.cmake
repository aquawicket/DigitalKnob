#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##############################################################################
# dk_timeout(seconds)
# 
#	Pause execution and wait for <enter> keypress to continue or amount of seconds to pass
#
function(dk_timeout) 
	dk_debugFunc(0 1)
	
	###### ${seconds} #####
	set(seconds ${ARGV})
	if(NOT seconds)
		set(seconds "10")
	endif()

	if(DEFINED "${ARGV}")
		set(seconds 	"${${ARGV}}")
	elseif(DEFINED ARGV)
		set(seconds 	"${ARGV}")
	else()
		dk_fatal("dk_timeout(${ARGV}): dk_timeout is invalid.")
	endif()

	
	###### Cmd ######
	if(DEFINED ENV{COMSPEC})
		dk_replaceAll($ENV{COMSPEC} "/" "\\" CMD_EXE)   # convert to windows path delimiters
		set(cmnd "${CMD_EXE} /c timeout /T ${seconds}")
		dk_debug("cmnd = ${cmnd}")
		execute_process(COMMAND ${cmnd})
		dk_return()
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
	
	dk_timeout(1)
	dk_timeout(5)
	dk_timeout()
endfunction()
