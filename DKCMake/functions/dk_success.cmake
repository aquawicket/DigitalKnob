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
# dk_success(msg)
#
#	Print a success message to the console
#
#	@msg	- The message to print
#
function(dk_success)
	dk_debugFunc()
	
	###############################################
	# dk_success() SETTINGS
	if(NOT "SUCCESS" IN_LIST dk_log_LEVELS)
		dk_set(dk_log_LEVELS "${dk_log_LEVELS};SUCCESS")
	endif()
	if(NOT DEFINED dk_log_SUCCESS_ENABLE)
		dk_set(dk_log_SUCCESS_ENABLE	1)
	endif()
	if(NOT DEFINED dk_log_SUCCESS_COLOR)
		dk_set(dk_log_SUCCESS_COLOR	"green")
	endif()
	if(NOT DEFINED dk_log_SUCCESS_TAG)
		dk_set(dk_log_SUCCESS_TAG	"SUCCESS: ")
	endif()
	if(NOT DEFINED dk_log_SUCCESS_PAUSE)
		dk_set(dk_log_SUCCESS_PAUSE		0)
	endif()
	if(NOT DEFINED dk_log_SUCCESS_TIMEOUT)
		dk_set(dk_log_SUCCESS_TIMEOUT	0)
	endif()
	if(NOT DEFINED dk_log_SUCCESS_TRACE)
		dk_set(dk_log_SUCCESS_TRACE		0)
	endif()
	if(NOT DEFINED dk_log_SUCCESS_LINE)
		dk_set(dk_log_SUCCESS_LINE		0)
	endif()
	if(NOT DEFINED dk_log_SUCCESS_HALT)
		dk_set(dk_log_SUCCESS_HALT		0)
	endif()
	##############################################
	
	if(NOT ARGV)
		message("") # newline
		return()
	endif()
	
	dk_log(SUCCESS "${ARGV}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	message("")
	message("${lblack}dk_success()${clr}")
	dk_success()															# no arguments						(New Line)
	message("")
	message("${lblack}dk_success(\"\")${clr}")
	dk_success("")    														# no arguments quoted				(New Line)
	message("")
	message("${lblack}dk_success( )${clr}")
	dk_success( )   														# single unquoted space				(New Line)
	message("")
	message("${lblack}dk_success(\" \")${clr}")
	dk_success(" ")   														# single quoted space
	message("")
	message("${lblack}dk_success(dk_success_single_unquoted_argument_message)${clr}")
	dk_success(dk_success_single_unquoted_argument_message)					# single unquoted argument message
	message("")
	message("${lblack}dk_success(\"dk_success single quoted argument message\")${clr}")
	dk_success("dk_success single quoted argument message")					# single quoted argument message
	message("")
	message("${lblack}dk_success(dk_success multiple unquoted argument message)${clr}")
	dk_success(dk_success multiple unquoted argument message)					# multiple unquoted arguments message
	message("")
	message("${lblack}dk_success(\"dk_success\" \"multiple quoted\" \"arguments message\")${clr}")
	dk_success("dk_success" "multiple quoted" "arguments message")			# multiple quoted arguments message
	message("")
	message("${lblack}dk_success(\"dk_success\" multiple mixed \"arguments message\")${clr}")
	dk_success("dk_success" multiple mixed "arguments message")				# multiple mixed arguments message
	message("")
	message("${lblack}dk_success(\"\${red}This is \${white}dk_success \${blue}with color \${clr}\")${clr}")
	dk_success("${red}This is ${white}dk_success ${blue}with color ${clr}")
endfunction()
