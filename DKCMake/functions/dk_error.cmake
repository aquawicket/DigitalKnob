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
# dk_error(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a error message to the console
#
#	@msg	- The dk_error to print
#
function(dk_error)
	dk_debugFunc()
	
	###############################################
	# dk_error() SETTINGS
	if(NOT "ERROR" IN_LIST dk_log_LEVELS)
		dk_set(dk_log_LEVELS "${dk_log_LEVELS};ERROR")
	endif()
	if(NOT DEFINED dk_log_ERROR_ENABLE)
		dk_set(dk_log_ERROR_ENABLE	1)
	endif()
	if(NOT DEFINED dk_log_ERROR_COLOR)
		dk_set(dk_log_ERROR_COLOR	"lred")
	endif()
	if(NOT DEFINED dk_log_ERROR_TAG)
		dk_set(dk_log_ERROR_TAG		"ERROR: ")
	endif()
	if(NOT DEFINED dk_log_ERROR_PAUSE)
		dk_set(dk_log_ERROR_PAUSE	0)
	endif()
	if(NOT DEFINED dk_log_ERROR_TIMEOUT)
		dk_set(dk_log_ERROR_TIMEOUT	0)
	endif()
	if(NOT DEFINED dk_log_ERROR_TRACE)
		dk_set(dk_log_ERROR_TRACE	0)
	endif()
	if(NOT DEFINED dk_log_ERROR_LINE)
		dk_set(dk_log_ERROR_LINE	0)
	endif()
	if(NOT DEFINED dk_log_ERROR_HALT)
		dk_set(dk_log_ERROR_HALT	0)
	endif()
	#dk_set(error_song	"200,1000\;200,1000\;200,1000\;200,1000\;200,1000")
	#if(NOT DEFINED dk_log_ERROR_SOUND)
	#	dk_set(dk_log_ERROR_SOUND ${error_song})
	#endif()
	##############################################
	
	if(NOT ARGV)
		message("") # newline
		return()
	endif()
	
	dk_log(ERROR "${ARGV}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
		message("")
	message("${lblack}dk_error()${clr}")
	dk_error()															# no arguments						(New Line)
	message("")
	message("${lblack}dk_error(\"\")${clr}")
	dk_error("")    														# no arguments quoted				(New Line)
	message("")
	message("${lblack}dk_error( )${clr}")
	dk_error( )   														# single unquoted space				(New Line)
	message("")
	message("${lblack}dk_error(\" \")${clr}")
	dk_error(" ")   														# single quoted space
	message("")
	message("${lblack}dk_error(dk_error_single_unquoted_argument_message)${clr}")
	dk_error(dk_error_single_unquoted_argument_message)					# single unquoted argument message
	message("")
	message("${lblack}dk_error(\"dk_error single quoted argument message\")${clr}")
	dk_error("dk_error single quoted argument message")					# single quoted argument message
	message("")
	message("${lblack}dk_error(dk_error multiple unquoted argument message)${clr}")
	dk_error(dk_error multiple unquoted argument message)					# multiple unquoted arguments message
	message("")
	message("${lblack}dk_error(\"dk_error\" \"multiple quoted\" \"arguments message\")${clr}")
	dk_error("dk_error" "multiple quoted" "arguments message")			# multiple quoted arguments message
	message("")
	message("${lblack}dk_error(\"dk_error\" multiple mixed \"arguments message\")${clr}")
	dk_error("dk_error" multiple mixed "arguments message")				# multiple mixed arguments message
	message("")
	message("${lblack}dk_error(\"\${red}This is \${white}dk_error \${blue}with color \${clr}\")${clr}")
	dk_error("${red}This is ${white}dk_error ${blue}with color ${clr}")
endfunction()
