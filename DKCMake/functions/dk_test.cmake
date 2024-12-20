#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_test()
#
#
function(dk_test)
	dk_debugFunc()   
    
    dk_echo( "################# dk_test.cmake #################")
    dk_echo( "                    0 = $0")
    dk_echo( "                    * = $*")
    dk_echo( "             __TIME__ = ${__TIME__}")
    dk_echo( "           __CALLER__ = ${__CALLER__}")
    dk_echo( "             __FILE__ = ${__FILE__}")
    dk_echo( "             __LINE__ = ${__LINE__}")
    dk_echo( "         __FUNCTION__ = ${__FUNCTION__}")
    dk_echo( "             __ARGC__ = ${__ARGC__}")
    dk_echo( "             __ARGV__ = ${__ARGV__}")
    dk_echo( "        DKSCRIPT_PATH = ${DKSCRIPT_PATH}")
    dk_echo( "         DKSCRIPT_DIR = ${DKSCRIPT_DIR}")
    dk_echo( "        DKSCRIPT_NAME = ${DKSCRIPT_NAME}")
    dk_echo( "         DKSCRIPT_EXT = ${DKSCRIPT_EXT}")
    dk_echo( "        DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}")
    dk_echo( "           DKHOME_DIR = ${DKHOME_DIR}")
    dk_echo( "          DKCACHE_DIR = ${DKCACHE_DIR}")
    dk_echo( "        DKDESKTOP_DIR = ${DKDESKTOP_DIR}")
    dk_echo( "          DIGITALKNOB = ${DIGITALKNOB}")
    dk_echo( "      DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}")
    dk_echo( "       DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR}")
    dk_echo( "          DKTOOLS_DIR = ${DKTOOLS_DIR}")
    dk_echo( "             DKBRANCH = ${DKBRANCH}")
    dk_echo( "         DKBRANCH_DIR = ${DKBRANCH_DIR}")
    dk_echo( "       DK3RDPARTY_DIR = ${DK3RDPARTY_DIR}")
    dk_echo( "           DKAPPS_DIR = ${DKAPPS_DIR}")
    dk_echo( "           DKBASH_DIR = ${DKCMAKE_DIR}")
    dk_echo( " DKBASH_FUNCTIONS_DIR = ${DKCMAKE_FUNCTIONS_DIR}")
    dk_echo( "DKBASH_FUNCTIONS_DIR_ = ${DKCMAKE_FUNCTIONS_DIR_}")
    
    set(return_value "return value from dk_test.cmake")
    execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${return_value}")
    #set(${rtn_var} "${return_value}" PARENT_SCOPE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_test("arg 1" "arg 2" rtn_var)
    dk_echo("rtn_var = ${rtn_var}")	
endfunction()