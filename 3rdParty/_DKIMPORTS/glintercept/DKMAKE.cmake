if(NOT WIN_HOST)
	return()
endif()
# https://github.com/dtrebilco/glintercept
#
# https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe

dk_import(https://github.com/dtrebilco/glintercept.git)

#dk_import(https://github.com/dtrebilco/glintercept/archive/e204189eff4045c24d48b82c93d4f012ed44e166.zip)

#dk_set(GLINTERCEPT_MAJOR 1)
#dk_set(GLINTERCEPT_MINOR 3)
#dk_set(GLINTERCEPT_BUILD 4)
#dk_set(GLINTERCEPT_VERSION ${GLINTERCEPT_MAJOR}.${GLINTERCEPT_MINOR}.${GLINTERCEPT_BUILD})
#dk_set(GLINTERCEPT_NAME GLIntercept-${GLINTERCEPT_VERSION})
#dk_set(GLINTERCEPT_DL https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe)
#dk_set(GLINTERCEPT "C:/Program Files (x86)/GLIntercept_${GLINTERCEPT_MAJOR}_${GLINTERCEPT_MINOR}_${GLINTERCEPT_BUILD}")
#IF(NOT EXISTS "${GLINTERCEPT}")
#	MESSAGE(STATUS "Installing ${GLINTERCEPT_NAME}")
#	dk_download(${GLINTERCEPT_DL} ${DKDOWNLOAD}/${GLINTERCEPT_NAME})
#	dk_command(${DKDOWNLOAD}/${GLINTERCEPT_NAME})
#ENDIF()
