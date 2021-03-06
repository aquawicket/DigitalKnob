if(NOT CMAKE_HOST_WIN32)
	return()
endif()

### INSTALL ###
IF(NOT EXISTS ${3RDPARTY}/Python27)
	DKSETPATH(${DIGITALKNOB}/Download)
	DKDOWNLOAD(https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi)
	##DKDOWNLOAD(https://www.python.org/ftp/python/3.9.4/python-3.9.4.exe)
	DKSETPATH(C:/)
	string(REPLACE "/" "\\" PYTHON_PATH ${3RDPARTY})
	DKSET(QUEUE_BUILD ON)
	WIN32_COMMAND(${DIGITALKNOB}/Download/python-2.7.18.msi PrependPath=1 TargetDir=${PYTHON_PATH}\\Python27)
ENDIF()

DKSET(PYTHON ${3RDPARTY}/Python27)
DKSET(PYTHON_EXE ${PYTHON}/python.exe)