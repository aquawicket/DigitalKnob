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


############ tdm-gcc ############
# https://github.com/jmeubank/tdm-gcc
# https://github.com/jmeubank/tdm-gcc/releases/download/v10.3.0-tdm-1/tdm-gcc-10.3.0.exe
# https://github.com/jmeubank/tdm-gcc/releases/download/v10.3.0-tdm64-2/tdm64-gcc-10.3.0-2.exe

if(Windows_X86_Host)
	set(tdm-gcc_Import https://github.com/jmeubank/tdm-gcc/releases/download/v10.3.0-tdm-1/tdm-gcc-10.3.0.exe)
elseif(Windows_X86_64_Host)
	#set(tdm-gcc_Import https://github.com/jmeubank/tdm-gcc-src/releases/download/v10.3.0-tdm64-1/gcc-10.3.0-tdm64-1-c++.zip)
	set(tdm-gcc_Import https://github.com/jmeubank/tdm-gcc/releases/download/v10.3.0-tdm64-2/tdm64-gcc-10.3.0-2.exe)
else()
	dk_fatal("tdm-gcc_Import is invalid!")
endif()

if(tdm-gcc_Import)
	dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
	dk_importVariables(${tdm-gcc_Import})
endif()

set(mingwvars_bat "${tdm-gcc}/mingwvars.bat")

if(NOT EXISTS "${mingwvars_bat}")
	dk_debug("Installing tdm-gcc . . . . ")
	dk_download(${tdm-gcc_Import} ${DKDOWNLOAD_DIR})			
	dk_pathToNative("${DKDOWNLOAD_DIR}/${tdm-gcc_IMPORT_FILE}" tdm-gcc_INSTALL_FILE)
	dk_pathToNative("${tdm-gcc}" tdm-gcc_INSTALL_PATH)
	execute_process(COMMAND ${tdm-gcc_INSTALL_FILE} COMMAND_ECHO STDOUT)
endif()

dk_assertPath(mingwvars_bat)
