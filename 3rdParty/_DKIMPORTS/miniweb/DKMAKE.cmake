#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# http://miniweb.sourceforge.net/
# https://sourceforge.net/projects/miniweb/files/miniweb/0.8/miniweb-win32-20130309.zip (binary)
# https://sourceforge.net/code-snapshots/svn/m/mi/miniweb/code/miniweb-code-r208.zip    (source code)


WIN_dk_import(https://sourceforge.net/projects/miniweb/files/miniweb/0.8/miniweb-win32-20130309.zip)
WIN_dk_set(MINIWEB_EXE "${MINIWEB}/miniweb.exe")
