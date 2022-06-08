# https://github.com/dtrebilco/glintercept
#
# https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe

DKIMPORT(https://github.com/dtrebilco/glintercept.git)

#DKIMPORT(https://github.com/dtrebilco/glintercept/archive/e204189eff4045c24d48b82c93d4f012ed44e166.zip)

#DKSET(GLINTERCEPT_MAJOR 1)
#DKSET(GLINTERCEPT_MINOR 3)
#DKSET(GLINTERCEPT_BUILD 4)
#DKSET(GLINTERCEPT_VERSION ${GLINTERCEPT_MAJOR}.${GLINTERCEPT_MINOR}.${GLINTERCEPT_BUILD})
#DKSET(GLINTERCEPT_NAME GLIntercept-${GLINTERCEPT_VERSION})
#DKSET(GLINTERCEPT_DL https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe)
#DKSET(GLINTERCEPT "C:/Program Files (x86)/GLIntercept_${GLINTERCEPT_MAJOR}_${GLINTERCEPT_MINOR}_${GLINTERCEPT_BUILD}")
#IF(NOT EXISTS "${GLINTERCEPT}")
#	MESSAGE(STATUS "Installing ${GLINTERCEPT_NAME}")
#	DOWNLOAD(${GLINTERCEPT_DL} ${DKDOWNLOAD}/${GLINTERCEPT_NAME})
#	DKCOMMAND(${DKDOWNLOAD}/${GLINTERCEPT_NAME})
#ENDIF()
