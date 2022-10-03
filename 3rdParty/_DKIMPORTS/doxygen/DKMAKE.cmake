# https://github.com/doxygen/doxygen
# https://github.com/doxygen/doxygen.git

if(NOT WIN_HOST)
	return()
endif()

### VERSION ###
dk_set(DOXYGEN_MAJOR 1)
dk_set(DOXYGEN_MINOR 8)
dk_set(DOXYGEN_BUILD 13)
dk_set(DOXYGEN_VERSION ${DOXYGEN_MAJOR}.${DOXYGEN_MINOR}.${DOXYGEN_BUILD})
dk_set(DOXYGEN_NAME doxygen-${DOXYGEN_VERSION})
dk_set(DOXYGEN_DL https://sourceforge.net/projects/doxygen/files/rel-${DOXYGEN_VERSION}/${DOXYGEN_NAME}-setup.exe)
dk_set(DOXYGEN "C:/Program Files/doxygen/bin")
dk_set(DOXYGEN_EXE ${DOXYGEN}/doxygen.exe)

### INSTALL ###
IF(NOT EXISTS ${DOXYGEN_EXE})
	dk_download(${DOXYGEN_DL} ${DKDOWNLOAD}/${DOXYGEN_NAME}-setup.exe)
	dk_set(QUEUE_BUILD ON)
	WIN32_dk_queueCommand(${DKDOWNLOAD}/${DOXYGEN_NAME}-setup.exe)
ENDIF()

