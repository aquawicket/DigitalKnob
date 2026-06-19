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
# dk_info(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
function(dk_info)
	dk_debugFunc()
	
	#########################################################################
	# dk_info() Settings
	if(NOT "INFO" IN_LIST dk_log_LEVELS)
		dk_set(dk_log_LEVELS "${dk_log_LEVELS};INFO")
	endif()
	if(NOT DEFINED dk_log_INFO_ENABLE)
		dk_set(dk_log_INFO_ENABLE		1)
	endif()
	if(NOT DEFINED dk_log_INFO_COLOR)
		dk_set(dk_log_INFO_COLOR		"white")
	endif()
	if(NOT DEFINED dk_log_INFO_TAG)
		dk_set(dk_log_INFO_TAG			"INFO: ")
	endif()
	if(NOT DEFINED dk_log_INFO_PAUSE)
		dk_set(dk_log_INFO_PAUSE		0)
	endif()
	if(NOT DEFINED dk_log_INFO_SOUND)
		dk_set(dk_log_INFO_SOUND		0)
	endif()
	if(NOT DEFINED dk_log_INFO_TIMEOUT)
		dk_set(dk_log_INFO_TIMEOUT		0)
	endif()
	if(NOT DEFINED dk_log_INFO_TRACE)
		dk_set(dk_log_INFO_TRACE		0)
	endif()
	if(NOT DEFINED dk_log_INFO_LINE)
		dk_set(dk_log_INFO_LINE			0)
	endif()
	if(NOT DEFINED dk_log_INFO_HALT)
		dk_set(dk_log_INFO_HALT			0)
	endif()

	if(NOT ARGV)
		message("") # newline
		return()
	endif()
	
	dk_log(INFO "${ARGV}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	message("")
	message("${lblack}dk_info()${clr}")
	dk_info()															# no arguments						(New Line)
	message("")
	message("${lblack}dk_info(\"\")${clr}")
	dk_info("")    														# no arguments quoted				(New Line)
	message("")
	message("${lblack}dk_info( )${clr}")
	dk_info( )   														# single unquoted space				(New Line)
	message("")
	message("${lblack}dk_info(\" \")${clr}")
	dk_info(" ")   														# single quoted space
	message("")
	message("${lblack}dk_info(dk_info_single_unquoted_argument_message)${clr}")
	dk_info(dk_info_single_unquoted_argument_message)					# single unquoted argument message
	message("")
	message("${lblack}dk_info(\"dk_info single quoted argument message\")${clr}")
	dk_info("dk_info single quoted argument message")					# single quoted argument message
	message("")
	message("${lblack}dk_info(dk_info multiple unquoted argument message)${clr}")
	dk_info(dk_info multiple unquoted argument message)					# multiple unquoted arguments message
	message("")
	message("${lblack}dk_info(\"dk_info\" \"multiple quoted\" \"arguments message\")${clr}")
	dk_info("dk_info" "multiple quoted" "arguments message")			# multiple quoted arguments message
	message("")
	message("${lblack}dk_info(\"dk_info\" multiple mixed \"arguments message\")${clr}")
	dk_info("dk_info" multiple mixed "arguments message")				# multiple mixed arguments message
	message("")
	message("${lblack}dk_info(\"\${red}This is \${white}dk_info \${blue}with color \${clr}\")${clr}")
	dk_info("${red}This is ${white}dk_info ${blue}with color ${clr}")
endfunction()
