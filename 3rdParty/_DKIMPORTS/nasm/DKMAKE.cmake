# https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/win32/nasm-2.15.05-win32.zip

### VERSION ###
DKSET(NASM_VERSION 2.15.05)
DKSET(NASM_NAME nasm-${NASM_VERSION}-win32)
DKSET(NASM_DL https://www.nasm.us/pub/nasm/releasebuilds/${NASM_VERSION}/win32/${NASM_NAME}.zip)
DKSET(NASM ${3RDPARTY}/${NASM_NAME})
DKSET(NASM_EXE ${NASM}/nasm.exe)

### INSTALL ###
DKINSTALL(${NASM_DL} nasm ${NASM})
DKSETENV("PATH" ${NASM_EXE})