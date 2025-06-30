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


############ nasm ############
# https://www.nasm.us

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(Android_Host)
	return()
endif()

set(nasm_Import "${nasm_${Host_Tuple}_Import}")

if(Linux_X86_Host)
	#dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.i686.rpm)
	#dk_depend(rpm)
	#dk_exec(${SUDO_EXE} rpm -i $ENV{DKDOWNLOAD_DIR}/nasm-2.16.01-0.fc36.i686.rpm)
	
	dk_download(${nasm_Import})
	dk_depend(sudo)
	dk_depend(alien)
	dk_exec(${SUDO_EXE} ${ALIEN_EXE} -i $ENV{DKDOWNLOAD_DIR}/linux/nasm-2.16.01-0.fc36.i686.rpm)
	dk_set(NASM_EXE ${NASM_DIR}/nasm)
endif()

if(Linux_X86_64_Host)
	#dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.x86_64.rpm)
	#dk_depend(rpm)
	#dk_exec(${SUDO_EXE} rpm -i $ENV{DKDOWNLOAD_DIR}/nasm-2.16.01-0.fc36.x86_64.rpm)
	
	dk_download(${nasm_Import})
	dk_depend(sudo)
	dk_depend(alien)
	dk_exec(${SUDO_EXE} ${ALIEN_EXE} -i $ENV{DKDOWNLOAD_DIR}/nasm-2.16.01-0.fc36.x86_64.rpm)
	dk_set(NASM_EXE ${NASM_DIR}/nasm)
endif()

if(Mac_X86_64_Host)
	dk_import(${nasm_Import})
	dk_set(NASM_EXE ${NASM_DIR}/nasm)
endif()

if(Windows_X86_Host)
	dk_import(${nasm_Import})
	dk_set(NASM_EXE ${NASM_DIR}/nasm.exe)
	dk_appendEnvPath(${NASM_DIR})
endif()

if(Windows_X86_64_Host)
	dk_import(${nasm_Import})
	dk_set(NASM_EXE ${NASM_DIR}/nasm.exe)
	dk_appendEnvPath(${NASM_DIR})
endif()

