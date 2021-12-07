#https://github.com/dtrebilco/glintercept
#
#https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe

### VERSION ###
DKSET(GLINTERCEPT_VERSION 1_3_4)
DKSET(GLINTERCEPT_NAME GLIntercept_${GLINTERCEPT_VERSION}.exe)
DKSET(GLINTERCEPT_DL https://github.com/dtrebilco/glintercept/releases/download/1.3.4/${GLINTERCEPT_NAME})
DKSET(GLINTERCEPT "C:/Program Files (x86)/${GLINTERCEPT_VERSION}")

### INSTALL ###
IF(NOT EXISTS "${GLINTERCEPT}")
	MESSAGE(STATUS "Installing GLIntercept ${GLINTERCEPT_VERSION}")
	DOWNLOAD(${GLINTERCEPT_DL} ${DKDOWNLOAD}/${GLINTERCEPT_NAME})
	DKCOMMAND(${DKDOWNLOAD}/${GLINTERCEPT_NAME})
ENDIF()
