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


dk_validate(Target_Config  "dk_Target_Config()")
# http://miniweb.sourceforge.net/
# https://sourceforge.net/projects/miniweb/files/miniweb/0.8/miniweb-win32-20130309.zip (binary)
# https://sourceforge.net/code-snapshots/svn/m/mi/miniweb/code/miniweb-code-r208.zip    (source code)


Windows_dk_import(https://sourceforge.net/projects/miniweb/files/miniweb/0.8/miniweb-win32-20130309.zip)
Windows_dk_set(miniweb_exe "${MINIWEB}/miniweb.exe")
