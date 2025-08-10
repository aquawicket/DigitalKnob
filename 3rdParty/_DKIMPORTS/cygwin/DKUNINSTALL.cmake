#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ cgywin ############
# https://www.cygwin.com
# https://cygwin.com/faq/faq.html#faq.setup.cli

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT Windows_Host)
	dk_undepend(cygwin)
	return()
endif()

dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_importVariables("${cygwin_${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})
dk_assertVar(CYGWIN)
dk_set(CYGWIN_EXE "${CYGWIN}/Cygwin.bat")


if(NOT EXISTS "${CYGWIN}")
	dk_notice("cygwin not installed")
	dk_return()
endif()	

dk_echo("Uninstalling cygwin . . .")
dk_delete("${CYGWIN}")

if(NOT EXISTS "${CYGWIN}")
	dk_success("cygwin uninstall complete")
else()
	dk_error("cygwin uninstall failed")
endif()	


