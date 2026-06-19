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
# dk_debug(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
function(dk_debug)
	dk_call(dk_debugFunc())
	
	###############################################
	# dk_debug() SETTINGS
	if(NOT "DEBUG" IN_LIST dk_log_LEVELS)
		dk_call(dk_set(dk_log_LEVELS "${dk_log_LEVELS};DEBUG"))
	endif()
	if(NOT DEFINED dk_log_DEBUG_ENABLE)
		dk_set(dk_log_DEBUG_ENABLE	1)
	endif()
	if(NOT DEFINED dk_log_DEBUG_COLOR)
		dk_set(dk_log_DEBUG_COLOR	"lblue")
	endif()
	if(NOT DEFINED dk_log_DEBUG_TAG)
		dk_set(dk_log_DEBUG_TAG		"DEBUG: ")
	endif()
	if(NOT DEFINED dk_log_DEBUG_PAUSE)
		dk_set(dk_log_DEBUG_PAUSE	0)
	endif()
	if(NOT DEFINED dk_log_DEBUG_TIMEOUT)
		dk_set(dk_log_DEBUG_TIMEOUT	0)
	endif()
	if(NOT DEFINED dk_log_DEBUG_TRACE)
		dk_set(dk_log_DEBUG_TRACE	0)
	endif()
	if(NOT DEFINED dk_log_DEBUG_LINE)
		dk_set(dk_log_DEBUG_LINE	0)
	endif()
	if(NOT DEFINED dk_log_DEBUG_HALT)
		dk_set(dk_log_DEBUG_HALT	0)
	endif()
	##############################################

	if(NOT ARGV)
		message("") # newline
		return()
	endif()
	
	dk_validateFunc(dk_log)
	dk_log(DEBUG "${ARGV}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	message("")
	message("${lblack}dk_debug()${clr}")
	dk_debug()															# no arguments						(New Line)
	message("")
	message("${lblack}dk_debug(\"\")${clr}")
	dk_debug("")    													# no arguments quoted				(New Line)
	message("")
	message("${lblack}dk_debug( )${clr}")
	dk_debug( )   														# single unquoted space				(New Line)
	message("")
	message("${lblack}dk_debug(\" \")${clr}")
	dk_debug(" ")   													# single quoted space
	message("")
	message("${lblack}dk_debug(dk_debug_single_unquoted_argument_message)${clr}")
	dk_debug(dk_debug_single_unquoted_argument_message)					# single unquoted argument message
	message("")
	message("${lblack}dk_debug(\"dk_debug single quoted argument message\")${clr}")
	dk_debug("dk_debug single quoted argument message")					# single quoted argument message
	message("")
	message("${lblack}dk_debug(dk_debug multiple unquoted argument message)${clr}")
	dk_debug(dk_debug multiple unquoted argument message)				# multiple unquoted arguments message
	message("")
	message("${lblack}dk_debug(\"dk_debug\" \"multiple quoted\" \"arguments message\")${clr}")
	dk_debug("dk_debug" "multiple quoted" "arguments message")			# multiple quoted arguments message
	message("")
	message("${lblack}dk_debug(\"dk_debug\" multiple mixed \"arguments message\")${clr}")
	dk_debug("dk_debug" multiple mixed "arguments message")				# multiple mixed arguments message
	message("")
	message("${lblack}dk_debug(\"\${red}This is \${white}dk_debug \${blue}with color \${clr}\")${clr}")
	dk_debug("${red}This is ${white}dk_debug ${blue}with color ${clr}") # message with color
endfunction()
