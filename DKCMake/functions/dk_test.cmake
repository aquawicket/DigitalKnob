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
# dk_test()
#
#
function(dk_test)
	#dk_debugFunc()   
    
	dk_echo("################# dk_test.cmake #################")
	dk_echo("                 CMAKE_ARGC = '${CMAKE_ARGC}'")
	foreach(n RANGE 0 9)
		if(CMAKE_ARGV${n})
			dk_echo("                CMAKE_ARGV${n} = '${CMAKE_ARGV${n}}'")
		endif()
	endforeach()
	dk_echo("                       ARGC = '${ARGC}'")
	dk_echo("                       ARGV = '${ARGV}'")
	foreach(n RANGE 0 9)
		if(ARGV${n})
			dk_echo("                      ARGV${n} = '${ARGV${n}}'")
		endif()
	endforeach()
	foreach(n RANGE 0 9)
		if(ARGN${n})
			dk_echo("                      ARGN${n} = '${ARGN${n}}'")
		endif()
	endforeach()
    dk_echo( "                   __TIME__ = '${__TIME__}'")
    dk_echo( "                 __CALLER__ = '${__CALLER__}'")
    dk_echo( "                   __FILE__ = '${__FILE__}'")
    dk_echo( "                   __LINE__ = '${__LINE__}'")
    dk_echo( "               __FUNCTION__ = '${__FUNCTION__}'")
    dk_echo( "                   __ARGC__ = '${__ARGC__}'")
    dk_echo( "                   __ARGV__ = '${__ARGV__}'")
	dk_echo( "         ENV{DKSCRIPT_PATH} = '$ENV{DKSCRIPT_PATH}'")
	dk_echo( "          ENV{DKSCRIPT_DIR} = '$ENV{DKSCRIPT_DIR}'")
	dk_echo( "         ENV{DKSCRIPT_FILE} = '$ENV{DKSCRIPT_FILE}'")
	dk_echo( "         ENV{DKSCRIPT_NAME} = '$ENV{DKSCRIPT_NAME}'")
	dk_echo( "          ENV{DKSCRIPT_EXT} = '$ENV{DKSCRIPT_EXT}'")
	dk_echo( "         ENV{DKSCRIPT_ARGS} = '$ENV{DKSCRIPT_ARGS}'")

	dk_echo( "            ENV{DKHOME_DIR} = '$ENV{DKHOME_DIR}'")
	dk_echo( "           ENV{DKCACHE_DIR} = '$ENV{DKCACHE_DIR}'")
	dk_echo( "         ENV{DKDESKTOP_DIR} = '$ENV{DKDESKTOP_DIR}'")
	dk_echo( "           ENV{DIGITALKNOB} = '$ENV{DIGITALKNOB}'")
	dk_echo( "       ENV{DIGITALKNOB_DIR} = '$ENV{DIGITALKNOB_DIR}'")
	dk_echo( "        ENV{DKDOWNLOAD_DIR} = '$ENV{DKDOWNLOAD_DIR}'")
	dk_echo( "           ENV{DKTOOLS_DIR} = '$ENV{DKTOOLS_DIR}'")

	dk_echo( "              ENV{DKBRANCH} = '$ENV{DKBRANCH}'")
	dk_echo( "          ENV{DKBRANCH_DIR} = '$ENV{DKBRANCH_DIR}'")
	dk_echo( "        ENV{DK3RDPARTY_DIR} = '$ENV{DK3RDPARTY_DIR}'")
	dk_echo( "         ENV{DKIMPORTS_DIR} = '$ENV{DKIMPORTS_DIR}'")
	dk_echo( "           ENV{DKCMAKE_DIR} = '$ENV{DKCMAKE_DIR}'")
	dk_echo( " ENV{DKCMAKE_FUNCTIONS_DIR} = '$ENV{DKCMAKE_FUNCTIONS_DIR}'")
	dk_echo( "ENV{DKCMAKE_FUNCTIONS_DIR_} = '$ENV{DKCMAKE_FUNCTIONS_DIR_}'")
	dk_echo( "        ENV{DKCPP_APPS_DIR} = '$ENV{DKCPP_APPS_DIR}'")

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