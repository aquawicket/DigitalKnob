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
# dk_fileContains(filepath find)
#
#	Check if a string contains a substring
#
#	@filepath			- The file to search
#	@find				- The substring to search for
#	${dk_fileContains}	- Returns index: Returns the index of the string if located
#
function(dk_fileContains)
	dk_debugFunc(2 99)
	
	### variable ###
#	if(DEFINED "${ARGV0}")
#		set(variable 	"${${ARGV0}}")
#	elseIF(DEFINED ARGV0)
#		set(variable 	"${ARGV0}")
#	else()
#		dk_fatal("dk_fileContains(${ARGV}): ARGV0:${ARGV0} is invalid.")
#	endif()
	set(filepath ${ARGV0})
	
	### find ###
#	if(DEFINED "${ARGV1}")
#		set(find 		"${${ARGV1}}")
#	elseif(DEFINED ARGV1)
#		set(find 		"${ARGV1}")
#	else()
#		dk_fatal("dk_fileContains(${ARGV}): ARGV1:${ARGV1} is invalid.")
#	endif()
	set(find ${ARGV1})

	if(EXISTS ${filepath})
		file(READ ${filepath} variable)
	endif()
	string(FIND "${variable}" "${find}" dk_fileContains)
	math(EXPR dk_fileContains "${dk_fileContains}+1")
	set(dk_fileContains ${dk_fileContains} PARENT_SCOPE)
#	message("${dk_fileContains}")
	
#if(DEBUG_CMAKE)	
#	if(${dk_fileContains})
#		dk_debug("dk_fileContains(${ARGV}): RTN:${dk_fileContains}:isTrue")
#	else()
#		dk_debug("dk_fileContains(${ARGV}): RTN:${dk_fileContains}:isFalse")
#	endif()
#endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myFile "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	set(mySubstring "DKINIT")
	dk_fileContains("${myFile}" "${mySubstring}")
	if(dk_fileContains)
		dk_info("myFile:${myFile} contains mySubstring:${mySubstring}")
	else()
		dk_info("myFile:${myFile}  does NOT contain mySubstring:${mySubstring}")
	endif()
	
	
	set(myFile "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	set(mySubstring "NONEXISTENT")
	dk_fileContains("${myFile}" "${mySubstring}")
	if(dk_fileContains)
		dk_info("myFile:${myFile} contains mySubstring:${mySubstring}")
	else()
		dk_info("myFile:${myFile}  does NOT contain mySubstring:${mySubstring}")
	endif()
	
endfunction()
