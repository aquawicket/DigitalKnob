#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##############################################################################
# dk_beep(frequency, duration)
# 
#
function(dk_beep)
	dk_debugFunc(0 2)
	
	#set(frequency ${ARGV0})
	#set(duration ${ARGV1})
	dk_getArg(0 frequency 500)
	dk_getArg(1 duration 500)
	
#	###### BASH ######
#	execute_process(COMMAND bash -c "command -v 'bash'" OUTPUT_VARIABLE BASH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
#	if(EXISTS "${BASH_EXE}")
#		set(cmnd ${BASH_EXE} -c "read -p '' stdin&& echo $stdin")
#		#message("${cmnd}")
#		execute_process(COMMAND ${cmnd} OUTPUT_VARIABLE stdin OUTPUT_STRIP_TRAILING_WHITESPACE)
#		if("${stdin}" STREQUAL "$stdin")
#			set(stdin "")
#		endif()
#		set(${ARGV0} "${stdin}" PARENT_SCOPE)
#		return()
#	endif()
	
#	###### SH ######
#	execute_process(COMMAND sh -c "command -v 'sh'" OUTPUT_VARIABLE SH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)	
#	if(EXISTS "${SH_EXE}")
#		set(cmnd ${SH_EXE} -c "read -p '' stdin&& echo $stdin")
#		#message("${cmnd}")
#		execute_process(COMMAND ${cmnd} OUTPUT_VARIABLE stdin OUTPUT_STRIP_TRAILING_WHITESPACE)
#		if("${stdin}" STREQUAL "$stdin")
#			set(stdin "")
#		endif()
#		set(${ARGV0} "${stdin}" PARENT_SCOPE)
#		return()
#	endif()
	
	###### POWERSHELL ######
	find_program(POWERSHELL_EXE powershell.exe)
	if(EXISTS "${POWERSHELL_EXE}")
		set(cmnd ${POWERSHELL_EXE} "[console]::beep(${frequency},${duration})")
		execute_process(COMMAND ${cmnd})	
		return()
	endif()
	
	###### CMD ######
#	if(EXISTS "$ENV{COMSPEC}")
#		string(REPLACE "/" "\\" CMD_EXE "$ENV{COMSPEC}")  # convert to windows path delimiters
#		set(cmnd "${CMD_EXE}" /V:ON /c "set /p stdin=& echo !stdin!")
#		#message("${cmnd}")
#		execute_process(COMMAND ${cmnd} OUTPUT_VARIABLE rtn_code OUTPUT_STRIP_TRAILING_WHITESPACE)		
#		if("${rtn_code}" STREQUAL "!rtn_code!")
#			set(rtn_code "")
#		endif()
#		set(${ARGV0} "${rtn_code}" PARENT_SCOPE)
#		return()
#	endif()
#	
	dk_fatal("Could not locate bash, sh, cmd.exe or powershell.exe")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo("Testing dk_beep.cmake")
	dk_beep(500 500)
	dk_beep(600 750)
	dk_beep(700 1000)
	dk_beep()
endfunction()
