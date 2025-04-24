#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_fileIncludes(filepath find)
#
#	Check if a string contains a substring
#
#	@filepath			- The file to search
#	@find				- The substring to search for
#	${dk_fileIncludes}	- Returns index: Returns the index of the string if located
#
function(dk_fileIncludes)
	dk_debugFunc(2 99)
	
	### variable ###
#	if(DEFINED "${ARGV0}")
#		set(variable 	"${${ARGV0}}")
#	elseIF(DEFINED ARGV0)
#		set(variable 	"${ARGV0}")
#	else()
#		dk_fatal("dk_fileIncludes(${ARGV}): ARGV0:${ARGV0} is invalid.")
#	endif()
	dk_getArg(0 filepath)
	
	### find ###
#	if(DEFINED "${ARGV1}")
#		set(find 		"${${ARGV1}}")
#	elseif(DEFINED ARGV1)
#		set(find 		"${ARGV1}")
#	else()
#		dk_fatal("dk_fileIncludes(${ARGV}): ARGV1:${ARGV1} is invalid.")
#	endif()
	dk_getArg(1 find)

	file(READ ${filepath} variable)
	string(FIND "${variable}" "${find}" dk_fileIncludes)
	math(EXPR dk_fileIncludes "${dk_fileIncludes}+1")
	set(dk_fileIncludes ${dk_fileIncludes} PARENT_SCOPE)
	
#if(DEBUG_CMAKE)	
#	if(${dk_fileIncludes})
#		dk_debug("dk_fileIncludes(${ARGV}): RTN:${dk_fileIncludes}:isTrue")
#	else()
#		dk_debug("dk_fileIncludes(${ARGV}): RTN:${dk_fileIncludes}:isFalse")
#	endif()
#endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myFile "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	set(mySubstring "DKINIT")
	dk_fileIncludes("${myFile}" "${mySubstring}")
	if(dk_fileIncludes)
		dk_info("myFile:${myFile} contains mySubstring:${mySubstring}")
	else()
		dk_info("myFile:${myFile}  does NOT contain mySubstring:${mySubstring}")
	endif()
	
	
	set(myFile "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	set(mySubstring "NONEXISTENT")
	dk_fileIncludes("${myFile}" "${mySubstring}")
	if(dk_fileIncludes)
		dk_info("myFile:${myFile} contains mySubstring:${mySubstring}")
	else()
		dk_info("myFile:${myFile}  does NOT contain mySubstring:${mySubstring}")
	endif()
	
endfunction()
