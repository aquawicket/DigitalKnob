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
# dk_notice(msg)
#
#	Print a NOTICE message
#
#	@msg	- The message to print
#
function(dk_notice)
	dk_debugFunc()
	
	###############################################
	# dk_notice() SETTINGS
	dk_set(dk_log_LEVELS "${dk_log_LEVELS};NOTICE")
	if(NOT DEFINED dk_log_NOTICE_ENABLE)
		dk_set(dk_log_NOTICE_ENABLE		1)
	endif()
	if(NOT DEFINED dk_log_NOTICE_COLOR)
		dk_set(dk_log_NOTICE_COLOR	"lyellow")
	endif()
	if(NOT DEFINED dk_log_NOTICE_TAG)
		dk_set(dk_log_NOTICE_TAG	"NOTICE: ")
	endif()
	if(NOT DEFINED dk_log_NOTICE_PAUSE)
		dk_set(dk_log_NOTICE_PAUSE		0)
	endif()
	if(NOT DEFINED dk_log_NOTICE_TIMEOUT)
		dk_set(dk_log_NOTICE_TIMEOUT	0)
	endif()
	if(NOT DEFINED dk_log_NOTICE_TRACE)
		dk_set(dk_log_NOTICE_TRACE		0)
	endif()
	if(NOT DEFINED dk_log_NOTICE_LINE)
		dk_set(dk_log_NOTICE_LINE		0)
	endif()
	if(NOT DEFINED dk_log_NOTICE_HALT)
		dk_set(dk_log_NOTICE_HALT		0)
	endif()
	##############################################
	
	if(NOT ARGV)
		message("") # newline
		return()
	endif()
	
	dk_log(NOTICE "${ARGV}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	message("")
	message("${lblack}dk_notice()${clr}")
	dk_notice()															# no arguments						(New Line)
	message("")
	message("${lblack}dk_notice(\"\")${clr}")
	dk_notice("")    														# no arguments quoted				(New Line)
	message("")
	message("${lblack}dk_notice( )${clr}")
	dk_notice( )   														# single unquoted space				(New Line)
	message("")
	message("${lblack}dk_notice(\" \")${clr}")
	dk_notice(" ")   														# single quoted space
	message("")
	message("${lblack}dk_notice(dk_notice_single_unquoted_argument_message)${clr}")
	dk_notice(dk_notice_single_unquoted_argument_message)					# single unquoted argument message
	message("")
	message("${lblack}dk_notice(\"dk_notice single quoted argument message\")${clr}")
	dk_notice("dk_notice single quoted argument message")					# single quoted argument message
	message("")
	message("${lblack}dk_notice(dk_notice multiple unquoted argument message)${clr}")
	dk_notice(dk_notice multiple unquoted argument message)					# multiple unquoted arguments message
	message("")
	message("${lblack}dk_notice(\"dk_notice\" \"multiple quoted\" \"arguments message\")${clr}")
	dk_notice("dk_notice" "multiple quoted" "arguments message")			# multiple quoted arguments message
	message("")
	message("${lblack}dk_notice(\"dk_notice\" multiple mixed \"arguments message\")${clr}")
	dk_notice("dk_notice" multiple mixed "arguments message")				# multiple mixed arguments message
	message("")
	message("${lblack}dk_notice(\"\${red}This is \${white}dk_notice \${blue}with color \${clr}\")${clr}")
	dk_notice("${red}This is ${white}dk_notice ${blue}with color ${clr}")
endfunction()