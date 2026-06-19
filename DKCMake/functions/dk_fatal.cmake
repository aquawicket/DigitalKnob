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
# dk_fatal(msg)
#
#	Print a fatal message to the console
#
#	@msg	- The message to print
#
function(dk_fatal)
	
	###############################################
	# dk_fatal() SETTINGS
	if(NOT "FATAL" IN_LIST dk_log_LEVELS)
		dk_set(dk_log_LEVELS "${dk_log_LEVELS};FATAL")
	endif()
	if(NOT DEFINED dk_log_FATAL_ENABLE)
		dk_set(dk_log_FATAL_ENABLE		1)
	endif()
	if(NOT DEFINED dk_log_FATAL_COLOR)
		dk_set(dk_log_FATAL_COLOR		"red")
	endif()
	if(NOT DEFINED dk_log_FATAL_TAG)
		dk_set(dk_log_FATAL_TAG			"FATAL: ")
	endif()
	if(NOT DEFINED dk_log_FATAL_PAUSE)
		dk_set(dk_log_FATAL_PAUSE		0)
	endif()
	if(NOT DEFINED dk_log_FATAL_TIMEOUT)
		dk_set(dk_log_FATAL_TIMEOUT		0)
	endif()
	if(NOT DEFINED dk_log_FATAL_TRACE)
		dk_set(dk_log_FATAL_TRACE		1)
	endif()
	if(NOT DEFINED dk_log_FATAL_LINE)
		dk_set(dk_log_FATAL_LINE		0)
	endif()
	if(NOT DEFINED dk_log_FATAL_HALT)
		dk_set(dk_log_FATAL_HALT		1)
	endif()
	#dk_set(imperial_march "440,500\;440,500\;440,500\;349,350\;523,150\;440,500\;349,350\;523,150\;440,1000\;659,500\;659,500\;659,500\;698,350\;523,150\;415,500\;349,350\;523,150\;440,1000")
	#if(NOT DEFINED dk_log_FATAL_SOUND)
	#	dk_set(dk_log_FATAL_SOUND					${imperial_march}				)
	#endif()
	##############################################
	
	if(NOT ARGV)
		message("") # newline
		return()
	endif()
	
	#dk_getParameter(NO_HALT  REMOVE)
	
	dk_log(FATAL "${ARGV}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	message("")
	message("${lblack}dk_fatal()${clr}")
	dk_fatal()															# no arguments						(New Line)
	message("")
	message("${lblack}dk_fatal(\"\")${clr}")
	dk_fatal("")    													# no arguments quoted				(New Line)
	message("")
	message("${lblack}dk_fatal( )${clr}")
	dk_fatal( )   														# single unquoted space				(New Line)
	message("")
	message("${lblack}dk_fatal(\" \")${clr}")
	dk_fatal(" ")   													# single quoted space
	message("")
	message("${lblack}dk_fatal(dk_fatal_single_unquoted_argument_message)${clr}")
	dk_fatal(dk_fatal_single_unquoted_argument_message)					# single unquoted argument message
	message("")
	message("${lblack}dk_fatal(\"dk_fatal single quoted argument message\")${clr}")
	dk_fatal("dk_fatal single quoted argument message")					# single quoted argument message
	message("")
	message("${lblack}dk_fatal(dk_fatal multiple unquoted argument message)${clr}")
	dk_fatal(dk_fatal multiple unquoted argument message)				# multiple unquoted arguments message
	message("")
	message("${lblack}dk_fatal(\"dk_fatal\" \"multiple quoted\" \"arguments message\")${clr}")
	dk_fatal("dk_fatal" "multiple quoted" "arguments message")			# multiple quoted arguments message
	message("")
	message("${lblack}dk_fatal(\"dk_fatal\" multiple mixed \"arguments message\")${clr}")
	dk_fatal("dk_fatal" multiple mixed "arguments message")				# multiple mixed arguments message
	message("")
	message("${lblack}dk_fatal(\"\${red}This is \${white}dk_fatal \${blue}with color \${clr}\")${clr}")
	dk_fatal("${red}This is ${white}dk_fatal ${blue}with color ${clr}")
endfunction()
