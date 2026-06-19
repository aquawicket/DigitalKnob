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
# dk_warning(msg)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
function(dk_warning)
	dk_debugFunc()

	###############################################
	# dk_warning() SETTINGS
	if(NOT "WARNING" IN_LIST dk_log_LEVELS)
		dk_set(dk_log_LEVELS "${dk_log_LEVELS};WARNING")
	endif()
	if(NOT DEFINED dk_log_WARNING_ENABLE)
		dk_set(dk_log_WARNING_ENABLE	1)
	endif()
	if(NOT DEFINED dk_log_WARNING_COLOR)
		dk_set(dk_log_WARNING_COLOR		"yellow")
	endif()
	if(NOT DEFINED dk_log_WARNING_TAG)
		dk_set(dk_log_WARNING_TAG		"WARNING: ")
	endif()
	if(NOT DEFINED dk_log_WARNING_PAUSE)
		dk_set(dk_log_WARNING_PAUSE		0)
	endif()
	if(NOT DEFINED dk_log_WARNING_TIMEOUT)
		dk_set(dk_log_WARNING_TIMEOUT	0)
	endif()
	if(NOT DEFINED dk_log_WARNING_TRACE)
		dk_set(dk_log_WARNING_TRACE		0)
	endif()
	if(NOT DEFINED dk_log_WARNING_LINE)
		dk_set(dk_log_WARNING_LINE		0)
	endif()
	if(NOT DEFINED dk_log_WARNING_HALT)
		dk_set(dk_log_WARNING_HALT		0)
	endif()
	##############################################
	
	if(NOT ARGV)
		message("") # newline
		return()
	endif()
	
	dk_log(WARNING "${ARGV}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	message("")
	message("${lblack}dk_warning()${clr}")
	dk_warning()															# no arguments						(New Line)
	message("")
	message("${lblack}dk_warning(\"\")${clr}")
	dk_warning("")    														# no arguments quoted				(New Line)
	message("")
	message("${lblack}dk_warning( )${clr}")
	dk_warning( )   														# single unquoted space				(New Line)
	message("")
	message("${lblack}dk_warning(\" \")${clr}")
	dk_warning(" ")   														# single quoted space
	message("")
	message("${lblack}dk_warning(dk_warning_single_unquoted_argument_message)${clr}")
	dk_warning(dk_warning_single_unquoted_argument_message)					# single unquoted argument message
	message("")
	message("${lblack}dk_warning(\"dk_warning single quoted argument message\")${clr}")
	dk_warning("dk_warning single quoted argument message")					# single quoted argument message
	message("")
	message("${lblack}dk_warning(dk_warning multiple unquoted argument message)${clr}")
	dk_warning(dk_warning multiple unquoted argument message)					# multiple unquoted arguments message
	message("")
	message("${lblack}dk_warning(\"dk_warning\" \"multiple quoted\" \"arguments message\")${clr}")
	dk_warning("dk_warning" "multiple quoted" "arguments message")			# multiple quoted arguments message
	message("")
	message("${lblack}dk_warning(\"dk_warning\" multiple mixed \"arguments message\")${clr}")
	dk_warning("dk_warning" multiple mixed "arguments message")				# multiple mixed arguments message
	message("")
	message("${lblack}dk_warning(\"\${red}This is \${white}dk_warning \${blue}with color \${clr}\")${clr}")
	dk_warning("${red}This is ${white}dk_warning ${blue}with color ${clr}")
endfunction()
