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

############ tdm-gcc ############
# https://github.com/jmeubank/tdm-gcc

dk_validate(Host_Tuple "dk_Host_Tuple()")
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")


### DOWNLOAD ###
if(Windows_X86_Host)
	set(TDM-GCC_DL https://github.com/jmeubank/tdm-gcc/releases/download/v10.3.0-tdm-1/tdm-gcc-10.3.0.exe)
endif()
if(Windows_X86_64_Host)
	set(TDM-GCC_DL https://github.com/jmeubank/tdm-gcc/releases/download/v10.3.0-tdm64-2/tdm64-gcc-10.3.0-2.exe)
	#set(TDM-GCC_DL https://github.com/jmeubank/tdm-gcc-src/releases/download/v10.3.0-tdm64-1/gcc-10.3.0-tdm64-1-c++.zip)
endif()
if(Windows_Host AND NOT TDM-GCC_DL)
	dk_fatal("TDM-GCC_DL is invalid!")
endif()


### TDM-GCC variables ###
if(TDM-GCC_DL)
	dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
	dk_importVariables(${TDM-GCC_DL})
	#dk_import(${TDM-GCC_DL})
endif()


### First Check ###
set(MINGWVARS_BAT "${TDM-GCC}/mingwvars.bat")

### INSTALL ###
if(NOT EXISTS "${MINGWVARS_BAT}")
	dk_debug(" Installing tdm-gcc . . . . ")
	dk_download(${TDM-GCC_DL} $ENV{DKDOWNLOAD_DIR})			
	dk_nativePath("$ENV{DKDOWNLOAD_DIR}/${TDM-GCC_IMPORT_FILE}" TDM-GCC_INSTALL_FILE)
	dk_nativePath("${TDM-GCC}" TDM-GCC_INSTALL_PATH)
	execute_process(COMMAND ${TDM-GCC_INSTALL_FILE} COMMAND_ECHO STDOUT)
endif()


## Second Check ###
dk_assertPath(MINGWVARS_BAT)
