# https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi

### VERSION ###
DKSET(PYTHON_VERSION 2.7.18)
DKSET(PYTHON_NAME python-${PYTHON_VERSION})
WIN_DKSET(PYTHON_DL https://www.python.org/ftp/python/${PYTHON_VERSION}/${PYTHON_NAME}.msi)
DKSET(PYTHON ${3RDPARTY}/${PYTHON_NAME})
WIN_DKSET(PYTHON_EXE ${PYTHON}/python.exe)


### INSTALL ###
IF(NOT EXISTS ${PYTHON_EXE})
	DKDOWNLOAD(${PYTHON_DL} ${DKDOWNLOAD}/${PYTHON_NAME}.msi)
	string(REPLACE "/" "\\" PYTHON_PATH ${PYTHON})
	DKCOMMAND(${DKDOWNLOAD}/${PYTHON_NAME}.msi PrependPath=1 TargetDir=${PYTHON_PATH})
	#DKSETENV("PATH" "%PATH%;${PYTHON}") #ERROR: Invalid syntax. Default option is not allowed more than '2' time(s)
	DKSETENV("PATH=%PATH%;${PYTHON}")
ENDIF()
