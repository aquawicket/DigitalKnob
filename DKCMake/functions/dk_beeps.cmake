#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##############################################################################
# dk_beeps(array)
#
#	Play an array of beeps. Each array item is formated as "frequency,dureation" 
#
function(dk_beeps)
	dk_debugFunc()

#	if(DEFINED "${ARGV}")
#		set(array 	"${${ARGV}}")
#	elseif(DEFINED ARGV)
#		set(array 	"${ARGV}")
#	else()
#		dk_fatal("dk_beeps(${ARGV}): array is invalid.")
#	endif()
	dk_getArg(0 array)

	#set(song "")
	foreach(beep ${array})
		set(song "${song}[console]::beep(${beep})\;")
	endforeach()
	set(ps_command "${song}")

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
		set(cmnd ${POWERSHELL_EXE} "${ps_command}")
		#dk_debug("cmnd = ${cmnd}")
		execute_process(COMMAND ${cmnd})	
		dk_return()
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

	#dk_fatal("Could not locate bash, sh, cmd.exe or powershell.exe")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_echo("Testing dk_beep.cmake")

	set(imperial_march "440,500" "440,500" "440,500" "349,350" "523,150" "440,500" "349,350" "523,150" 
	"440,1000" "659,500" "659,500" "659,500" "698,350" "523,150" "415,500" "349,350" "523,150" "440,1000")

	set(FATAL_SOUND imperial_march)
	dk_beeps(${FATAL_SOUND})

endfunction()
