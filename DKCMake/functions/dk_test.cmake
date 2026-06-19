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
# dk_test()
#
#
function(dk_test VAR1)
	#dk_debugFunc()   
    
	dk_echo("################# dk_test.cmake #################")
	dk_echo("                 CMAKE_ARGC = '${CMAKE_ARGC}'")
	foreach(n RANGE 0 9)
		if(CMAKE_ARGV${n})
	dk_echo("              CMAKE_ARGV${n} = '${CMAKE_ARGV${n}}'")
		endif()
	endforeach()
	dk_echo("                        ARGC = '${ARGC}'")
	dk_echo("                        ARGV = '${ARGV}'")
	foreach(n RANGE 0 9)
		if(ARGV${n})
	dk_echo("                    ARGV${n} = '${ARGV${n}}'")
		endif()
	endforeach()
	foreach(n RANGE 0 9)
		if(ARGN${n})
	dk_echo("                    ARGN${n} = '${ARGN${n}}'")
		endif()
	endforeach()
    dk_echo( "                   __TIME__ = '${__TIME__}'")
    dk_echo( "                 __CALLER__ = '${__CALLER__}'")
    dk_echo( "                   __FILE__ = '${__FILE__}'")
    dk_echo( "                   __LINE__ = '${__LINE__}'")
    dk_echo( "               __FUNCTION__ = '${__FUNCTION__}'")
    dk_echo( "                   __ARGC__ = '${__ARGC__}'")
    dk_echo( "                   __ARGV__ = '${__ARGV__}'")
	dk_echo( "              DKSCRIPT_PATH = '${DKSCRIPT_PATH}'")
	dk_echo( "               DKSCRIPT_DIR = '${DKSCRIPT_DIR}'")
	dk_echo( "              DKSCRIPT_FILE = '${DKSCRIPT_FILE}'")
	dk_echo( "              DKSCRIPT_NAME = '${DKSCRIPT_NAME}'")
	dk_echo( "               DKSCRIPT_EXT = '${DKSCRIPT_EXT}'")
	dk_echo( "              DKSCRIPT_ARGS = '${DKSCRIPT_ARGS}'")
	dk_echo( "                 DKHOME_DIR = '${DKHOME_DIR}'")
	dk_echo( "                DKCACHE_DIR = '${DKCACHE_DIR}'")
	dk_echo( "              DKDESKTOP_DIR = '${DKDESKTOP_DIR}'")
	dk_echo( "                DIGITALKNOB = '${DIGITALKNOB}'")
	dk_echo( "            DIGITALKNOB_DIR = '${DIGITALKNOB_DIR}'")
	dk_echo( "             DKDOWNLOAD_DIR = '${DKDOWNLOAD_DIR}'")
	dk_echo( "                DKTOOLS_DIR = '${DKTOOLS_DIR}'")
	dk_echo( "                   DKBRANCH = '${DKBRANCH}'")
	dk_echo( "               DKBRANCH_DIR = '${DKBRANCH_DIR}'")
	dk_echo( "             DK3RDPARTY_DIR = '${DK3RDPARTY_DIR}'")
	dk_echo( "              DKIMPORTS_DIR = '${DKIMPORTS_DIR}'")
	dk_echo( "                DKCMAKE_DIR = '${DKCMAKE_DIR}'")
	dk_echo( "      DKCMAKE_FUNCTIONS_DIR = '${DKCMAKE_FUNCTIONS_DIR}'")
	dk_echo( "     DKCMAKE_FUNCTIONS_DIR_ = '${DKCMAKE_FUNCTIONS_DIR_}'")
	dk_echo( "             DKCPP_APPS_DIR = '${DKCPP_APPS_DIR}'")
	dk_BREAKPOINT()
	set(return_valueA "return_valueA from dk_test.cmake")
	set(return_valueB "return_valueB from dk_test.cmake")
	execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${return_valueA}")
	execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${return_valueB}")
	dk_set(return_valueA "${return_valueA}")
	dk_set(return_valueB "${return_valueB}")
	#set(dk_test "return_valueA;${return_valueA};return_valueB;${return_valueB}" PARENT_SCOPE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	#dk_debugFunc(0)
	
	dk_test("arg 1" "arg 2" rtn_var)
    dk_echo("rtn_var = ${rtn_var}")
	
	#include("array/dk_copyWithin.cmake")
	dk_load("array/dk_copyWithin.cmake")
endfunction()