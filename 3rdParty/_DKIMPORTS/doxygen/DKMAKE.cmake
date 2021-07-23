if(NOT CMAKE_HOST_WIN32)
	return()
endif()

### VERSION ###
DKSET(DOXYGEN_MAJOR 1)
DKSET(DOXYGEN_MINOR 8)
DKSET(DOXYGEN_BUILD 13)
DKSET(DOXYGEN_VERSION ${DOXYGEN_MAJOR}.${DOXYGEN_MINOR}.${DOXYGEN_BUILD})
DKSET(DOXYGEN C:/Program Files/doxygen/bin/doxygen.exe)

### INSTALL ###
IF(NOT EXISTS "C:/Program Files/doxygen/bin/doxygen.exe")
	DKSETPATH(${DIGITALKNOB}/Download)
	DKDOWNLOAD(https://sourceforge.net/projects/doxygen/files/rel-${DOXYGEN_VERSION}/doxygen-${DOXYGEN_VERSION}-setup.exe)
	DKSET(QUEUE_BUILD ON)
	WIN32_COMMAND(${DIGITALKNOB}/Download/doxygen-${DOXYGEN_VERSION}-setup.exe)
ENDIF()

