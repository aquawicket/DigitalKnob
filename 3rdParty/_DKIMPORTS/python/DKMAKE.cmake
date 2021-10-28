# https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi
# https://docs.python.org/3/using/windows.html

### VERSION ###
DKSET(PYTHON_VERSION 2.7.18)
DKSET(PYTHON_NAME python-${PYTHON_VERSION})
WIN_DKSET(PYTHON_DL https://www.python.org/ftp/python/${PYTHON_VERSION}/${PYTHON_NAME}.msi)
DKSET(PYTHON ${3RDPARTY}/${PYTHON_NAME})
WIN_DKSET(PYTHON_EXE ${PYTHON}/python.exe)


### INSTALL ###
IF(NOT EXISTS ${PYTHON_EXE})
	DOWNLOAD(${PYTHON_DL} ${DKDOWNLOAD}/${PYTHON_NAME}.msi)
	string(REPLACE "/" "\\" PYTHON_PATH ${PYTHON})
	DKCOMMAND(${DKDOWNLOAD}/${PYTHON_NAME}.msi /passive PrependPath=1 TargetDir=${PYTHON_PATH})
	DKSETENV("PATH" "${PYTHON}")
ENDIF()
