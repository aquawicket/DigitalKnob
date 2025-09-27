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

dk_import()

if(Linux_X86_Host)
	#dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.i686.rpm)
	#dk_depend(rpm)
	#dk_exec(${sudo_exe} rpm -i $ENV{DKDOWNLOAD_DIR}/nasm-2.16.01-0.fc36.i686.rpm)
	
	dk_download(${nasm_Import})
	dk_validate(sudo_exe "dk_depend(sudo_exe)")
	dk_depend(alien)
	dk_exec(${sudo_exe} ${alien_exe} -i ${dk_download})
	dk_set(nasm_exe ${nasm}/nasm)
	#dk_validate(nasm_exe "dk_depend(nasm_exe)")
endif()

if(Linux_X86_64_Host)
	#dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.x86_64.rpm)
	#dk_depend(rpm)
	#dk_exec(${sudo_exe} rpm -i $ENV{DKDOWNLOAD_DIR}/nasm-2.16.01-0.fc36.x86_64.rpm)
	
	dk_download(${nasm_Url})
	dk_validate(sudo_exe "dk_depend(sudo_exe)")
	dk_depend(alien)
	dk_exec(${sudo_exe} ${alien_exe} -i ${dk_download})
	dk_set(nasm_exe ${nasm}/nasm)
	dk_appendEnvPath(${nasm})
endif()

if(Mac_X86_64_Host)
	#dk_import(${nasm_Import} IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})
	dk_import()
	dk_set(nasm_exe ${nasm}/nasm)
	dk_appendEnvPath(${nasm})
endif()

if(Windows_X86_Host)
	#dk_import(${nasm_Url} IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})
	dk_import()
	dk_set(nasm_exe ${nasm}/nasm.exe)
	dk_appendEnvPath(${nasm})
endif()

if(Windows_X86_64_Host)
	#dk_import(${nasm_Url} IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})
	dk_import()
	dk_set(nasm_exe ${nasm}/nasm.exe)
	dk_appendEnvPath(${nasm})
endif()

