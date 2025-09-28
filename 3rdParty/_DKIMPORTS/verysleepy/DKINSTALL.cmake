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


############ verysleepy ############
# https://github.com/VerySleepy/verysleepy.git
# http://www.codersnotes.com/sleepy/
# https://github.com/VerySleepy/verysleepy/releases/download/v0.91/verysleepy-0.91.exe
# https://github.com/VerySleepy/verysleepy/archive/refs/tags/v0.91.zip (source)
dk_validate(Target_Config  "dk_Target_Config()")

if(NOT Windows_Host)
	return()
endif()

if(Windows_X86)
	dk_set(VERYSLEEPY "${ProgramFiles}/Very Sleepy/32")
elseif(Windows_X86_64)
	dk_set(VERYSLEEPY "${ProgramFiles}/Very Sleepy")
endif()
dk_set(sleepy_exe "${VERYSLEEPY}/sleepy.exe")
dk_import(https://github.com/VerySleepy/verysleepy/releases/download/v0.91/verysleepy-0.91.exe)
