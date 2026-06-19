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


############ cgywin ############
# https://www.cygwin.com
# https://cygwin.com/faq/faq.html#faq.setup.cli

if(NOT Windows_Host)
	dk_disable(cygwin)
	return()
endif()

dk_importVariables("${cygwin_${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})
dk_assertVar(cygwin)
dk_set(cygwin_exe "${cygwin}/Cygwin.bat")

if(NOT EXISTS "${cygwin}")
	dk_notice("cygwin not installed")
	dk_return()
endif()	

dk_echo("Uninstalling cygwin . . .")
dk_delete("${cygwin}")

if(NOT EXISTS "${cygwin}")
	dk_success("cygwin uninstall complete")
else()
	dk_error("cygwin uninstall failed")
endif()	


