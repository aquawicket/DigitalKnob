#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ verysleepy ############
# https://github.com/VerySleepy/verysleepy.git
# http://www.codersnotes.com/sleepy/
# https://github.com/VerySleepy/verysleepy/releases/download/v0.91/verysleepy-0.91.exe
# https://github.com/VerySleepy/verysleepy/archive/refs/tags/v0.91.zip (source)
dk_load(dk_builder)

if(NOT WIN_HOST)
	return()
endif()

if(WIN_X86)
	dk_set(VERYSLEEPY "${ProgramFiles}/Very Sleepy/32")
elseif(WIN_X86_64)
	dk_set(VERYSLEEPY "${ProgramFiles}/Very Sleepy")
endif()
dk_set(VERYSLEEPY_EXE "${VERYSLEEPY}/sleepy.exe")
dk_import(https://github.com/VerySleepy/verysleepy/releases/download/v0.91/verysleepy-0.91.exe)
