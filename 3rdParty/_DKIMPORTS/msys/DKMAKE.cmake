if(NOT CMAKE_HOST_WIN32)
	return()
endif()

### VERSION ###
DKSET(MSYS ${3RDPARTY}/msys)

### INSTALL ###
## https://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/MSYS%20%2832-bit%29/MSYS-20111123.zip)
DKINSTALL(https://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/MSYS%20%2832-bit%29/MSYS-20111123.zip msys ${MSYS})


