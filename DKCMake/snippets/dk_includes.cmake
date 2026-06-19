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


set(myString "There is a needle in this haystack")
set(mySubstring "needle")
if(myString MATCHES ${mySubstring})
	dk_echo("myString contains mySubstring")
else()
	dk_echo("myString does NOT contain mySubstring")
endif()
	
if(myString MATCHES "nonexistant")
	dk_echo("myString contains nonexistant")
else()
	dk_echo("myString does NOT contain nonexistant")
endif()

list(APPEND myList "one")
list(APPEND myList "two")
list(APPEND myList "three")
if(myList MATCHES "two")
	dk_echo("myList contains two")
else()
	dk_echo("myList does NOT contain two")
endif()
if(myList MATCHES "nonexistant")
	dk_echo("myList contains nonexistant")
else()
	dk_echo("myList does NOT contain nonexistant")
endif()
if(myList MATCHES "wo;th")
	dk_echo("myList contains wo;th")
else()
	dk_echo("myList does NOT contain wo;th")
endif()





list(APPEND lines "test")
#list(APPEND lines "if(some command)")
#list(APPEND lines "#if (")
list(APPEND lines "function(")
list(APPEND lines "function (")
 list(APPEND lines "function	(")
 list(APPEND lines "abc(")
list(APPEND lines "123 (")
 list(APPEND lines "456	(")

set(keepCommands "ZZZZZ;function;XXXXX")
foreach(line ${lines})
	foreach(keepCommand ${keepCommands})
		if(line MATCHES "${keepCommand}\\(") # trailing (
			dk_echo("'${line}' has 'function('")
		endif()
		if(line MATCHES "${keepCommand} ") # trailing (
			dk_echo("'${line}' has 'function ('")
		endif()
		if(line MATCHES "${keepCommand}	") # trailing (
			dk_echo("'${line}' has 'function	('")
		endif()
	endforeach()
endforeach()




