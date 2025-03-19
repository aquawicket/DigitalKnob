#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")

############ tdm-gcc ############
# https://github.com/jmeubank/tdm-gcc

dk_validate(host_triple "dk_host_triple()")
dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
#dk_getFileParam("$ENV{DKIMPORTS_DIR}/tdm-gcc/dkconfig.txt" VERSION)


### DOWNLOAD ###
if(WIN_X86_HOST)
	set(TDM-GCC_DL https://github.com/jmeubank/tdm-gcc/releases/download/v10.3.0-tdm-1/tdm-gcc-10.3.0.exe)
endif()
if(WIN_X86_64_HOST)
	set(TDM-GCC_DL https://github.com/jmeubank/tdm-gcc/releases/download/v10.3.0-tdm64-2/tdm64-gcc-10.3.0-2.exe)
	#set(TDM-GCC_DL https://github.com/jmeubank/tdm-gcc-src/releases/download/v10.3.0-tdm64-1/gcc-10.3.0-tdm64-1-c++.zip)
endif()
if(WIN_HOST AND NOT TDM-GCC_DL)
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
	dk_nativePath("$ENV{DKDOWNLOAD_DIR}/${TDM-GCC_DL_FILE}" TDM-GCC_INSTALL_FILE)
	dk_nativePath("${TDM-GCC}" TDM-GCC_INSTALL_PATH)
	execute_process(COMMAND ${TDM-GCC_INSTALL_FILE} COMMAND_ECHO STDOUT)
endif()


## Second Check ###
dk_assertPath(MINGWVARS_BAT)
