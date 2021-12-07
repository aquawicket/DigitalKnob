if(NOT CMAKE_HOST_WIN32)
	return()
endif()

# https://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/MSYS%20%2832-bit%29/MSYS-20111123.zip

### VERSION ###
DKSET(MSYS_VERSION 20111123)
DKSET(MSYS_NAME MSYS-${MSYS_VERSION})
DKSET(MSYS_DL https://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/MSYS%20%2832-bit%29/${MSYS_NAME}.zip)
DKSET(MSYS_DIR ${3RDPARTY}/${MSYS_NAME})
DKSET(MSYS ${3RDPARTY}/${MSYS_NAME})

### INSTALL ###
DKINSTALL(${MSYS_DL} msys ${MSYS_DIR})
