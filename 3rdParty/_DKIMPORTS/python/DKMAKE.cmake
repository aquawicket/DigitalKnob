# https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi

### VERSION ###
DKSET(PYTHON_VERSION 2.7.18)
DKSET(PYTHON_NAME python-${PYTHON_VERSION})
DKSET(PYTHON_DL https://www.python.org/ftp/python/${PYTHON_VERSION}/${PYTHON_NAME}.msi)
DKSET(PYTHON ${3RDPARTY}/${PYTHON_NAME})
DKSET(PYTHON_EXE ${PYTHON}/python.exe)

### INSTALL ###
IF(NOT EXISTS ${PYTHON})
	DKSETPATH(${DIGITALKNOB}/Download)
	DKDOWNLOAD(${PYTHON_DL})
	string(REPLACE "/" "\\" PYTHON_PATH ${PYTHON})
	DKCOMMAND(${DIGITALKNOB}/Download/${PYTHON_NAME}.msi PrependPath=1 TargetDir=${PYTHON_PATH})
ENDIF()

