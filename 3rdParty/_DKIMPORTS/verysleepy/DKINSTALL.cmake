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


############ verysleepy ############
# https://github.com/VerySleepy/verysleepy.git
# http://www.codersnotes.com/sleepy/
# https://github.com/VerySleepy/verysleepy/archive/refs/tags/v0.91.zip (source)
# https://github.com/VerySleepy/verysleepy/releases/download/v0.91/verysleepy-0.91.exe

if(NOT Windows_Host)
	return()
endif()

if(Windows_X86)
	dk_set(VERYSLEEPY "${ProgramFiles}/Very Sleepy/32")
elseif(Windows_X86_64)
	dk_set(VERYSLEEPY "${ProgramFiles}/Very Sleepy")
endif()
dk_set(sleepy_exe "${VERYSLEEPY}/sleepy.exe")
dk_import()
dk_exec(${dk_download})
