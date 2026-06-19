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
# dk_fixme(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a fixme message to the console
#
#	@msg	- The message to print
#
function(dk_fixme)
	dk_debugFunc()

	###############################################
	# dk_fixme() SETTINGS
	if(NOT "FIXME" IN_LIST dk_log_LEVELS)
		dk_set(dk_log_LEVELS "${dk_log_LEVELS};FIXME")
	endif()
	if(NOT DEFINED dk_log_FIXME_ENABLE)
		dk_set(dk_log_FIXME_ENABLE		1)
	endif()
	if(NOT DEFINED dk_log_FIXME_COLOR)
		dk_set(dk_log_FIXME_COLOR		"lyellow")
	endif()
	if(NOT DEFINED dk_log_FIXME_TAG)
		dk_set(dk_log_FIXME_TAG			"FIXME: ")
	endif()
	if(NOT DEFINED dk_log_FIXME_PAUSE)
		dk_set(dk_log_FIXME_PAUSE		0)
	endif()
	if(NOT DEFINED dk_log_FIXME_TIMEOUT)
		dk_set(dk_log_FIXME_TIMEOUT		0)
	endif()
	if(NOT DEFINED dk_log_FIXME_TRACE)
		dk_set(dk_log_FIXME_TRACE		0)
	endif()
	if(NOT DEFINED dk_log_FIXME_LINE)
		dk_set(dk_log_FIXME_LINE		0)
	endif()
	if(NOT DEFINED dk_log_FIXME_HALT)
		dk_set(dk_log_FIXME_HALT		0)
	endif()
	##############################################
	
	if(NOT ARGV)
		message("") # newline
		return()
	endif()
	
	dk_log(FIXME "${ARGV}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
	
	message("")
	message("${lblack}dk_fixme()${clr}")
	dk_fixme()															# no arguments						(New Line)
	message("")
	message("${lblack}dk_fixme(\"\")${clr}")
	dk_fixme("")    														# no arguments quoted				(New Line)
	message("")
	message("${lblack}dk_fixme( )${clr}")
	dk_fixme( )   														# single unquoted space				(New Line)
	message("")
	message("${lblack}dk_fixme(\" \")${clr}")
	dk_fixme(" ")   														# single quoted space
	message("")
	message("${lblack}dk_fixme(dk_fixme_single_unquoted_argument_message)${clr}")
	dk_fixme(dk_fixme_single_unquoted_argument_message)					# single unquoted argument message
	message("")
	message("${lblack}dk_fixme(\"dk_fixme single quoted argument message\")${clr}")
	dk_fixme("dk_fixme single quoted argument message")					# single quoted argument message
	message("")
	message("${lblack}dk_fixme(dk_fixme multiple unquoted argument message)${clr}")
	dk_fixme(dk_fixme multiple unquoted argument message)					# multiple unquoted arguments message
	message("")
	message("${lblack}dk_fixme(\"dk_fixme\" \"multiple quoted\" \"arguments message\")${clr}")
	dk_fixme("dk_fixme" "multiple quoted" "arguments message")			# multiple quoted arguments message
	message("")
	message("${lblack}dk_fixme(\"dk_fixme\" multiple mixed \"arguments message\")${clr}")
	dk_fixme("dk_fixme" multiple mixed "arguments message")				# multiple mixed arguments message
	message("")
	message("${lblack}dk_fixme(\"\${red}This is \${white}dk_fixme \${blue}with color \${clr}\")${clr}")
	dk_fixme("${red}This is ${white}dk_fixme ${blue}with color ${clr}")
endfunction()
