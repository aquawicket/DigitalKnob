if(NOT WIN_HOST)
	return()
endif()

dk_set(MSYS_VERSION 20111123)
dk_set(MSYS_DL https://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/MSYS%20%2832-bit%29/MSYS-20111123.zip)
dk_set(MSYS_NAME msys2-${MSYS_VERSION})
dk_set(MSYS ${3RDPARTY}/${MSYS_NAME})
DKINSTALL(${MSYS_DL} msys ${MSYS})

