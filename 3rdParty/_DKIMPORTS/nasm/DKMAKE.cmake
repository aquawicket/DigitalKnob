if(NOT WIN_HOST)
	return()
endif()

# https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/win32/nasm-2.15.05-win32.zip

### VERSION ###
dk_set(NASM_VERSION 2.15.05)
dk_set(NASM_NAME nasm-${NASM_VERSION}-win32)
dk_set(NASM_DL https://www.nasm.us/pub/nasm/releasebuilds/${NASM_VERSION}/win32/${NASM_NAME}.zip)
dk_set(NASM ${3RDPARTY}/${NASM_NAME})
dk_set(NASM_EXE ${NASM}/nasm.exe)

### INSTALL ###
#dk_import(${NASM_DL} ${NASM})
dk_import(${NASM_DL} ${NASM})
dk_setEnv("PATH" "${NASM_EXE}")
