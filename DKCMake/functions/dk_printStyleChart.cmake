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
# dk_printStyleChart()
#
#	TODO
#
function(dk_printStyleChart)
	dk_debugFunc()
	
	dk_echo(" ")
	dk_echo(       "Style Chart")
	dk_echo(       "${ESC_0}     ESC_0         ${clr}")
	dk_echo(       "${ESC_1}     ESC_1         ${clr}")
	dk_echo(       "${ESC_2}     ESC_2         ${clr}")
	dk_echo(       "${ESC_3}     ESC_3         ${clr}")
	dk_echo(       "${ESC_4}     ESC_4         ${clr}")
	dk_echo(       "${ESC_5}     ESC_5         ${clr}")
	dk_echo(       "${ESC_6}     ESC_6         ${clr}")
	dk_echo(       "${ESC_7}     ESC_7         ${clr}")
	dk_echo(       "${ESC_8}     ESC_8         ${clr}")
	dk_echo(       "${ESC_9}     ESC_9         ${clr}")
	dk_echo(      "${ESC_10}     ESC_10        ${clr}")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
