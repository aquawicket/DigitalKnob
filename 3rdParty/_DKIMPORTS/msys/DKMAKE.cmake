if(NOT CMAKE_HOST_WIN32)
	return()
endif()

### INSTALL ###
IF(NOT EXISTS ${3RDPARTY}/mingw/msys)
	DKSETPATH(${DIGITALKNOB}/Download)
	DKDOWNLOAD(https://sourceforge.net/projects/mingw-w64/files/External%20binary%20packages%20%28Win64%20hosted%29/MSYS%20%2832-bit%29/MSYS-20111123.zip)
	DKEXTRACT(${DIGITALKNOB}/Download/MSYS-20111123.zip ${3RDPARTY}/mingw)
ENDIF()

DKSET(MSYS ${3RDPARTY}/mingw/msys)
##string(REPLACE ":" "" MSYS ${MSYS})