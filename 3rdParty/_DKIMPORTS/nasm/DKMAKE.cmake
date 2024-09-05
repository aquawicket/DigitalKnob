include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://www.nasm.us

if(ANDROID_HOST)
	return()
endif()

dk_depend(rpm)


LINUX_X86_HOST_dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.i686.rpm)
LINUX_X86_HOST_dk_set(NASM_EXE ${NASM}/nasm)

if(LINUX_HOST)
#import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.x86_64.rpm)
dk_download(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/linux/nasm-2.16.01-0.fc36.x86_64.rpm)
dk_command(${SUDO} rpm -i ${DKDOWNLOAD_DIR}/nasm-2.16.01-0.fc36.x86_64.rpm)
#dk_set(NASM_EXE ${NASM}/nasm)
endif()

MAC_HOST_dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/macosx/nasm-2.16.01-macosx.zip)
MAC_HOST_dk_set(NASM_EXE ${NASM}/nasm)

#WIN_HOST_dk_import(https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/win32/nasm-2.16.01-win32.zip)
WIN_HOST_dk_import(https://github.com/microsoft/vcpkg/files/12073957/nasm-2.16.01-win64.zip)
WIN_HOST_dk_set(NASM_EXE ${NASM}/nasm.exe)

#dk_setEnv("PATH" "${NASM_EXE}")
#dk_info("NASM = ${NASM}")
dk_appendEnvPath(${NASM})
