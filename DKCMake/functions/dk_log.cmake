#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################





#########################################################################
# dk_debug(message)
#
#	Print a debug message to the console
#
#	@message	- The message to print
#
function(dk_log)
	dk_debugFunc()
	
	###### dk_log()Settings ###################################################################
	dk_validateFunc(dk_color)
	dk_validateFunc(dk_if)

	# 0 VERBOSE		dk_verbose
	# 1 DEBUG		dk_debug
	# 2 INFO		dk_info
	# 3 SUCCESS		dk_success
	# 4 TODO		dk_todo
	# 5 NOTICE		dk_notice
	# 6 FIXME		dk_fixme
	# 7 WARNING		dk_warning
	# 8 ERROR		dk_error
	# 9 FATAL		dk_fatal

	if(NOT DEFINED dk_log_ENABLE)
		dk_set(dk_log_ENABLE  1)
	endif()

	#dk_if(NOT DEFINED ENV{dk_log_NOHALT}		[[ dk_set(dk_log_NOHALT 			1) ]])
	#dk_if(NOT DEFINED dk_log_BG_COLOR			[[ dk_set(dk_log_BG_COLOR 			"${bg_lblue}") ]])
	#dk_if(NOT DEFINED dk_log_FG_COLOR			[[ dk_set(dk_log_FG_COLOR 			"${black}") ]])
	#set(clr "${ESC}[0J;${default}${black}"	CACHE INTERNAL "")

	# DEFAULT
	if(NOT "DEFAULT" IN_LIST dk_log_LEVELS)
		dk_set(dk_log_LEVELS "${dk_log_LEVELS};DEFAULT")
	endif()
	if(NOT DEFINED dk_log_DEFAULT_ENABLE)
		dk_set(dk_log_DEFAULT_ENABLE		1)
	endif()
	if(NOT DEFINED dk_log_DEFAULT_COLOR)
		dk_set(dk_log_DEFAULT_COLOR		"white")
	endif()
	if(NOT DEFINED dk_log_DEFAULT_TAG)		
		dk_set(dk_log_DEFAULT_TAG		"DEFAULT: ")
	endif()
	if(NOT DEFINED dk_log_DEFAULT_PAUSE)
		dk_set(dk_log_DEFAULT_PAUSE		0)
	endif()
	if(NOT DEFINED dk_log_DEFAULT_TIMEOUT)
		dk_set(dk_log_DEFAULT_TIMEOUT	0)
	endif()
	if(NOT DEFINED dk_log_DEFAULT_TRACE)
		dk_set(dk_log_DEFAULT_TRACE		0)
	endif()
	if(NOT DEFINED dk_log_DEFAULT_LINE)	
		dk_set(dk_log_DEFAULT_LINE		0)
	endif()
	if(NOT DEFINED dk_log_DEFAULT_HALT)
		dk_set(dk_log_DEFAULT_HALT		0)
	endif()
	##########################################################################################

	dk_call( dk_getParameter(TRACE REMOVE) )
	dk_getParameter(NO_TRACE REMOVE)
	dk_getParameter(LINE REMOVE)
	dk_getParameter(NO_LINE REMOVE)
	dk_getParameter(SOUND REMOVE)
	dk_getParameter(NO_SOUND REMOVE)
	dk_getParameter(PAUSE REMOVE)
	dk_getParameter(NO_PAUSE REMOVE)
	dk_getParameter(TIMEOUT REMOVE)
	dk_getParameter(NO_TIMEOUT REMOVE)
	dk_getParameter(HALT REMOVE)
	dk_getParameter(NO_HALT REMOVE)
	
	if(NOT "${dk_log_ENABLE}" EQUAL "1")
		dk_return()
	endif()
	
	if((ARGV) AND (ARGV0 IN_LIST dk_log_LEVELS))
		set(_level_ "${ARGV0}")
		dk_validateFunc(dk_allButFirstArgs)
		dk_allButFirstArgs(${ARGV})
#		message("${dk_allButFirstArgs}")
		set(_message_ "${dk_allButFirstArgs}")
	elseif(ARGV)
		set(_level_ "DEFAULT")
		set(_message_ "${ARGV}")
	else()
		message("")
		return()
	endif()

	if(NOT dk_log_${_level_}_ENABLE)
		dk_return()
	endif()

#	message("${_message_}")
#	message("${ARGV0}")
	dk_echo("${dk_log_BG_COLOR}${${dk_log_${_level_}_COLOR}}${dk_log_${_level_}_TAG}${_message_}${clr}")

	### TRACE ###
	if((dk_log_${_level_}_TRACE) AND (NOT NO_TRACE))# OR (TRACE))
		dk_echo("\n${${dk_log_${_level_}_COLOR}}###### TRACE_ON_${_level_} ######")
		dk_stacktrace()
		message("${clr}")
	endif()

	### LINE ###
	if((dk_log_${_level_}_LINE) AND (NOT NO_LINE))# OR (LINE))
		dk_echo("\n${${dk_log_${_level_}_COLOR}}###### LINE_ON_${_level_} ######")
		#d_k_showFileLine("${BASH_SOURCE[1]}" "${BASH_LINENO[1-1]}")
		message("${clr}")
	endif()

	### SOUND ###
	if((dk_log_${_level_}_SOUND) AND (NOT NO_SOUND))# OR (SOUND))
		dk_echo("\n${${dk_log_${_level_}_COLOR}}###### SOUND_ON_${_level_} ######${clr}")
		dk_pause()
		dk_beeps(dk_log_${_level_}_SOUND)
	endif()

	### PAUSE ###
	if((dk_log_${_level_}_PAUSE) AND (NOT NO_PAUSE))# OR (PAUSE))
		dk_echo("\n${${dk_log_${_level_}_COLOR}}###### PAUSE_ON_${_level_} ######${clr}")
		dk_pause()
	endif()

	### TIMEOUT ###
	if((dk_log_${_level_}_TIMEOUT) AND (NOT NO_TIMEOUT))# OR (TIMEOUT))
		dk_echo("\n${${dk_log_${_level_}_COLOR}}###### TIMEOUT_ON_${_level_} ######${clr}")
		dk_timeout(dk_log_${_level_}_TIMEOUT)
	endif()

	### HALT ###
	if((dk_log_${_level_}_HALT) AND (NOT NO_HALT))# OR (HALT))
		dk_echo("\n${${dk_log_${_level_}_COLOR}}###### HALT_ON_${_level_} ######${clr}")
		dk_exit(13)
	endif()

endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	message("")
	message("${lblack}dk_log()${clr}")
	dk_log()															# no arguments						(New Line)
	
	message("")
	message("${lblack}dk_log(\"\")${clr}")
	dk_log("")    														# no arguments quoted				(New Line)
	
	message("")
	message("${lblack}dk_log( )${clr}")
	dk_log( )   														# single unquoted space				(New Line)
	
	message("")
	message("${lblack}dk_log(\" \")${clr}")
	dk_log(" ")   														# single quoted space
	
	message("")
	message("${lblack}dk_log(dk_log_single_unquoted_argument_message)${clr}")
	dk_log(dk_log_single_unquoted_argument_message)						# single unquoted argument message
	
	message("")
	message("${lblack}dk_log(\"dk_log single quoted argument message\")${clr}")
	dk_log("dk_log single quoted argument message")						# single quoted argument message
	
	message("")
	message("${lblack}dk_log(dk_log multiple unquoted argument message)${clr}")
	dk_log(dk_log multiple unquoted argument message)					# multiple unquoted arguments message
	
	message("")
	message("${lblack}dk_log(\"dk_log\" \"multiple quoted\" \"arguments message\")${clr}")
	dk_log("dk_log" "multiple quoted" "arguments message")				# multiple quoted arguments message
	
	message("")
	message("${lblack}dk_log(\"dk_log\" multiple mixed \"arguments message\")${clr}")
	dk_log("dk_log" multiple mixed "arguments message")					# multiple mixed arguments message
	
	message("")
	message("${lblack}dk_log(\"\${red}This is \${white}dk_log \${blue}with color \${clr}\")${clr}")
	dk_log("${red}This is ${white}dk_log ${blue}with color ${clr}")		# message with color
	
	dk_log(         "test dk_log message")
	dk_log(DEFAULT  "test dk_log DEFAULT message")
	dk_log(VERBOSE	"test dk_log VERBOSE message")
	dk_log(DEBUG	"test dk_log DEBUG message")
	dk_log(INFO		"test dk_log INFO message")
	dk_log(SUCCESS	"test dk_log SUCCESS message")
	dk_log(TODO		"test dk_log TODO message")
	dk_log(NOTICE	"test dk_log NOTICE message")
	dk_log(FIXME	"test dk_log FIXME message")
	dk_log(WARNING	"test dk_log WARNING message")
	dk_log(ERROR	"test dk_log ERROR message")
	
	message("")
	message("${lblack}dk_log(FATAL	\"test dk_log FATAL message w/NO_HALT\" NO_HALT)${clr}")
	dk_log(FATAL	"test dk_log FATAL message w/NO_HALT" NO_HALT)
	
	message("")
	message("${lblack}dk_log(FATAL	\"test dk_log FATAL message\")${clr}")
	dk_log(FATAL	"test dk_log FATAL message")
endfunction()
