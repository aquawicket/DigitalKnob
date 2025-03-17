#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(TO_CMAKE_PATH "$ENV{USERPROFILE}$ENV{HOME}/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_test()
#
#
function(dk_test)
	#dk_debugFunc()   
    
    dk_echo( "################# Test/dk_test.cmake #################")
    dk_echo( "                ARGV0 = ${ARGV0}")
    dk_echo( "                ARGV1 = ${ARGV1}")
	dk_echo( "                ARGV2 = ${ARGV2}")
	dk_echo( "                ARGV3 = ${ARGV3}")
	dk_echo( "                ARGV4 = ${ARGV4}")
	dk_echo( "                ARGV5 = ${ARGV5}")
	dk_echo( "                ARGV6 = ${ARGV6}")
	dk_echo( "                ARGV7 = ${ARGV7}")
	dk_echo( "                ARGV8 = ${ARGV8}")
	dk_echo( "                ARGV9 = ${ARGV9}")
	dk_echo( "                ARGN0 = ${ARGN0}")
    dk_echo( "                ARGN1 = ${ARGN1}")
	dk_echo( "                ARGN2 = ${ARGN2}")
	dk_echo( "                ARGN3 = ${ARGN3}")
	dk_echo( "                ARGN4 = ${ARGN4}")
	dk_echo( "                ARGN5 = ${ARGN5}")
	dk_echo( "                ARGN6 = ${ARGN6}")
	dk_echo( "                ARGN7 = ${ARGN7}")
	dk_echo( "                ARGN8 = ${ARGN8}")
	dk_echo( "                ARGN9 = ${ARGN9}")
    dk_echo( "             __TIME__ = ${__TIME__}")
    dk_echo( "           __CALLER__ = ${__CALLER__}")
    dk_echo( "             __FILE__ = ${__FILE__}")
    dk_echo( "             __LINE__ = ${__LINE__}")
    dk_echo( "         __FUNCTION__ = ${__FUNCTION__}")
    dk_echo( "             __ARGC__ = ${__ARGC__}")
    dk_echo( "             __ARGV__ = ${__ARGV__}")
    dk_echo( "        DKSCRIPT_PATH = ${DKSCRIPT_PATH}")
    dk_echo( "         DKSCRIPT_DIR = ${DKSCRIPT_DIR}")
    dk_echo( "        DKSCRIPT_FILE = ${DKSCRIPT_FILE}")
    dk_echo( "        DKSCRIPT_NAME = ${DKSCRIPT_NAME}")
    dk_echo( "         DKSCRIPT_EXT = ${DKSCRIPT_EXT}")
    dk_echo( "        DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}")
    dk_echo( "           DKHOME_DIR = ${DKHOME_DIR}")
    dk_echo( "          DKCACHE_DIR = ${DKCACHE_DIR}")
    dk_echo( "        DKDESKTOP_DIR = ${DKDESKTOP_DIR}")
    dk_echo( "          DIGITALKNOB = ${DIGITALKNOB}")
    dk_echo( "      DIGITALKNOB_DIR = $ENV{DIGITALKNOB_DIR}")
    dk_echo( "       DKDOWNLOAD_DIR = $ENV{DKDOWNLOAD_DIR}")
    dk_echo( "          DKTOOLS_DIR = ${DKTOOLS_DIR}")
    dk_echo( "             DKBRANCH = ${DKBRANCH}")
    dk_echo( "         DKBRANCH_DIR = ${DKBRANCH_DIR}")
    dk_echo( "       DK3RDPARTY_DIR = ${DK3RDPARTY_DIR}")
    dk_echo( "           DKCPP_APPS_DIR = ${DKCPP_APPS_DIR}")
    dk_echo( "           DKBASH_DIR = ${DKCMAKE_DIR}")
    dk_echo( " DKBASH_FUNCTIONS_DIR = ${DKCMAKE_FUNCTIONS_DIR}")
    dk_echo( "DKBASH_FUNCTIONS_DIR_ = $ENV{DKCMAKE_FUNCTIONS_DIR_}")
    
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
	
	include("array/dk_copyWithin.cmake")
endfunction()