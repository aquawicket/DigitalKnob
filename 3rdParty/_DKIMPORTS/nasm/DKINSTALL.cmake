#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ nasm ############
# https://www.nasm.us

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(ANDROID_HOST)
	return()
endif()

if(LINUX_X86_HOST)
	#dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.i686.rpm)
	#dk_depend(rpm)
	#dk_command(${SUDO_EXE} rpm -i $ENV{DKDOWNLOAD_DIR}/nasm-2.16.01-0.fc36.i686.rpm)
	
	dk_download(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.i686.rpm)
	dk_depend(sudo)
	dk_depend(alien)
	dk_command(${SUDO_EXE} ${ALIEN_EXE} -i $ENV{DKDOWNLOAD_DIR}/linux/nasm-2.16.01-0.fc36.i686.rpm)
	dk_set(NASM_EXE ${NASM_DIR}/nasm)
endif()

if(Linux_Host)
	#dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.x86_64.rpm)
	#dk_depend(rpm)
	#dk_command(${SUDO_EXE} rpm -i $ENV{DKDOWNLOAD_DIR}/nasm-2.16.01-0.fc36.x86_64.rpm)
	
	dk_download(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.x86_64.rpm)
	dk_depend(sudo)
	dk_depend(alien)
	dk_command(${SUDO_EXE} ${ALIEN_EXE} -i $ENV{DKDOWNLOAD_DIR}/nasm-2.16.01-0.fc36.x86_64.rpm)
	dk_set(NASM_EXE ${NASM_DIR}/nasm)
endif()

if(Mac_Host)
	dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/macosx/nasm-2.16.01-macosx.zip)
	dk_set(NASM_EXE ${NASM_DIR}/nasm)
endif()

if(WIN_X86_HOST)
	dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/win32/nasm-2.16.01-win32.zip)
	dk_set(NASM_EXE ${NASM_DIR}/nasm.exe)
	dk_appendEnvPath(${NASM_DIR})
endif()

if(WIN_X86_64_HOST)
	dk_import(https://github.com/microsoft/vcpkg/files/12073957/nasm-2.16.01-win64.zip)
	dk_set(NASM_EXE ${NASM_DIR}/nasm.exe)
	dk_appendEnvPath(${NASM_DIR})
endif()

