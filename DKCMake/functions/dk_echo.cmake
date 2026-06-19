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
# dk_echo(msg)
#
#	Print a message to the console
#
#	@msg	- The message to print
#
function(dk_echo)
	dk_debugFunc()
	
	if(NOT ARGV)
		message("") # newline
		return()
	endif()
	
#	if(NOT echo_fileline)
#		__FILE__(_FILE_ 1)
#		__LINE__(_LINE_ 1)
#		dk_basename("${_FILE_}" _FILE_)
#		set(echo_fileline "${_FILE_}:${_LINE_}   " CACHE INTERNAL "")
#	endif()
#	message("${echo_fileline}${ARGV}")
#	dk_unset(echo_fileline)

	message("${ARGV}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	message("")
	message("${lblack}dk_echo()${clr}")
	dk_echo()															# no arguments						(New Line)
	message("")
	message("${lblack}dk_echo(\"\")${clr}")
	dk_echo("")    														# no arguments quoted				(New Line)
	message("")
	message("${lblack}dk_echo( )${clr}")
	dk_echo( )   														# single unquoted space				(New Line)
	message("")
	message("${lblack}dk_echo(\" \")${clr}")
	dk_echo(" ")   														# single quoted space
	message("")
	message("${lblack}dk_echo(dk_echo_single_unquoted_argument_message)${clr}")
	dk_echo(dk_echo_single_unquoted_argument_message)					# single unquoted argument message
	message("")
	message("${lblack}dk_echo(\"dk_echo single quoted argument message\")${clr}")
	dk_echo("dk_echo single quoted argument message")					# single quoted argument message
	message("")
	message("${lblack}dk_echo(dk_echo multiple unquoted argument message)${clr}")
	dk_echo(dk_echo multiple unquoted argument message)					# multiple unquoted arguments message
	message("")
	message("${lblack}dk_echo(\"dk_echo\" \"multiple quoted\" \"arguments message\")${clr}")
	dk_echo("dk_echo" "multiple quoted" "arguments message")			# multiple quoted arguments message
	message("")
	message("${lblack}dk_echo(\"dk_echo\" multiple mixed \"arguments message\")${clr}")
	dk_echo("dk_echo" multiple mixed "arguments message")				# multiple mixed arguments message
	message("")
	message("${lblack}dk_echo(\"\${red}This is \${white}dk_echo \${blue}with color \${clr}\")${clr}")
	dk_echo("${red}This is ${white}dk_echo ${blue}with color ${clr}")
endfunction()