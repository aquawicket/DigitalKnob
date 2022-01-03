# https://docs.python.org/3/using/windows.html

# Windows ttps://www.python.org/ftp/python/2.7.18/python-2.7.18.msi
# Mac      https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg
# Linux    https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz

### VERSION ###
DKSET(PYTHON_VERSION 2.7.18)
DKSET(PYTHON_NAME python-${PYTHON_VERSION})
WIN_DKSET(PYTHON_DL https://www.python.org/ftp/python/${PYTHON_VERSION}/${PYTHON_NAME}.msi)
MAC_DKSET(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg)
LINUX_DKSET(PYTHON_DL https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
RASPBERRY_DKSET(PYTHON_DL https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
DKSET(PYTHON ${3RDPARTY}/${PYTHON_NAME})
WIN_DKSET(PYTHON_EXE ${PYTHON}/python.exe)
MAC_DKSET(PYTHON_APP ${PYTHON}/python.app)
LINUX_DKSET(PYTHON ${PYTHON}/python)
RASPBERRY_DKSET(PYTHON ${PYTHON}/python)

### INSTALL ###
IF(WIN AND NOT EXISTS ${PYTHON_EXE})
	DOWNLOAD(${PYTHON_DL} ${DKDOWNLOAD}/${PYTHON_NAME}.msi)
	#string(REPLACE "/" "\\" PYTHON_PATH ${PYTHON})
	DKCOMMAND(cmd /c ${DKDOWNLOAD}/${PYTHON_NAME}.msi /passive PrependPath=1 TargetDir=${PYTHON})
	string(REPLACE "/" "\\" PYTHON_PATH ${PYTHON})
	DKSETENV("PATH" "${PYTHON}")
ENDIF()

IF(MAC AND NOT EXISTS ${PYTHON_MAC})
	DOWNLOAD(${PYTHON_DL} ${DKDOWNLOAD}/python-2.7.18-macosx10.9.pkg)
	#TODO
ENDIF()

IF(LINUX AND NOT EXISTS ${PYTHON})
	DOWNLOAD(${PYTHON_DL} ${DKDOWNLOAD}/Python-2.7.18.tgz)
	#TODO
ENDIF()

IF(RASPBERRY AND NOT EXISTS ${PYTHON})
	DOWNLOAD(${PYTHON_DL} ${DKDOWNLOAD}/Python-2.7.18.tgz)
	#TODO
ENDIF()
