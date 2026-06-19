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
# dk_toLower(<str> <rtn_var:OPTIONAL>)
#
#	Convert a string to lower case
#
#	<str>   		- The input string to convert
#	<dk_toLower>	- Returns the converted output string
#
function(dk_toLower)
	dk_debugFunc(1 2)
	

	string(TOLOWER "${ARGV0}" dk_toLower)
	
	
	###### return ######
	set(dk_toLower ${dk_toLower} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_toLower} PARENT_SCOPE)
	else()
		message("${dk_toLower}") 
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
#    (ALL_Chars "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0   ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~")
set(Valid_Chars "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0   !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [   ] ^ _ ` { | } ~")
#(Invalid_Chars "																			     								                 "                                           \			      ")
	
	dk_echo("     Valid_Chars = ${Valid_Chars}") 
	dk_toLower("${Valid_Chars}")
	dk_echo("dk_toLower = ${dk_toLower}")

endfunction()