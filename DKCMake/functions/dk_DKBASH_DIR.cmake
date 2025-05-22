#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_DKBASH_DIR()
#
#
function(dk_DKBASH_DIR)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(DKBASH_DIR "${ARGV}")

	###### GET ######
	else()
		dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
		dk_set(DKBASH_DIR "${DKBRANCH_DIR}/DKBash")
	endif()

	dk_set(DKBASH_FUNCTIONS_DIR "${DKBASH_DIR}/functions")
	dk_set(DKBASH_FUNCTIONS_DIR_ "${DKBASH_DIR}/functions/")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_echo()
	dk_echo("Test Getting DKBASH_DIR . . .")
	dk_DKBASH_DIR()
	dk_printVar(DKBASH_DIR)

	dk_echo()
	dk_echo("Test Setting DKBASH_DIR . . .")
	dk_DKBASH_DIR("C:/DK/DKBash")
	dk_printVar(DKBASH_DIR)
endfunction()
