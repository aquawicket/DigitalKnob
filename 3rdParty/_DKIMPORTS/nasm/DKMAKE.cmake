#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://www.nasm.us

dk_validate(HOST_TRIPLE "dk_HOST_TRIPLE()")
if(ANDROID_HOST)
	return()
endif()

dk_depend(rpm)


LINUX_X86_HOST_dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.i686.rpm)
LINUX_X86_HOST_dk_set(NASM_EXE ${NASM_DIR}/nasm)

if(LINUX_HOST)
#import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.x86_64.rpm)
dk_download(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.x86_64.rpm)
dk_command(${SUDO} rpm -i ${DKDOWNLOAD_DIR}/nasm-2.16.01-0.fc36.x86_64.rpm)
#dk_set(NASM_EXE ${NASM_DIR}/nasm)
endif()

MAC_HOST_dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/macosx/nasm-2.16.01-macosx.zip)
MAC_HOST_dk_set(NASM_EXE ${NASM_DIR}/nasm)

#WIN_HOST_dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/win32/nasm-2.16.01-win32.zip)
if(WIN_HOST)
	dk_import(https://github.com/microsoft/vcpkg/files/12073957/nasm-2.16.01-win64.zip)
	dk_set(NASM_EXE ${NASM_DIR}/nasm.exe)
endif()

#dk_setEnv("PATH" "${NASM_EXE}")
#dk_info("NASM = ${NASM}")
dk_appendEnvPath(${NASM_DIR})
