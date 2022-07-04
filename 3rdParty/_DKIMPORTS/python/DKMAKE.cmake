# https://docs.python.org/3/using/windows.html
# Windows	https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi
# Mac		https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg
# Linux		https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
# https://silentinstallhq.com/python-2-7-silent-install-how-to-guide/


dk_set(PYTHON_NAME python-2.7.18)
dk_set(PYTHON ${3RDPARTY}/${PYTHON_NAME})
WIN_dk_set			(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi)
MAC_dk_set			(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg)
LINUX_dk_set		(PYTHON_DL https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
RASPBERRY_dk_set	(PYTHON_DL https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
WIN_dk_set			(PYTHON_APP ${PYTHON}/python.exe)
MAC_dk_set			(PYTHON_APP ${PYTHON}/python.app)
LINUX_dk_set		(PYTHON_APP ${PYTHON}/python)
RASPBERRY_dk_set	(PYTHON_APP ${PYTHON}/python)


### INSTALL ###
IF(WIN AND NOT EXISTS ${PYTHON_APP})
	dk_download(${PYTHON_DL} ${DKDOWNLOAD}/python-2.7.18.msi)
	#dk_executeProcess(cmd /c ${DKDOWNLOAD}/python-2.7.18.msi /passive PrependPath=1 TargetDir=${PYTHON})
	dk_executeProcess(MsiExec.exe /i "${DKDOWNLOAD}/python-2.7.18.msi" ALLUSERS=1 ADDLOCAL=ALL TARGETDIR="${PYTHON}" /qn)
	# string(REPLACE "/" "\\" PYTHON_PATH ${PYTHON})
	dk_setEnv("PATH" "${PYTHON}")
ENDIF()
IF(MAC AND NOT EXISTS ${PYTHON_APP})
	dk_download(${PYTHON_DL} ${DKDOWNLOAD}/python-2.7.18-macosx10.9.pkg)
	dk_executeProcess(${DKDOWNLOAD}/python-2.7.18-macosx10.9.pkg)
	#TODO
ENDIF()
IF(LINUX AND NOT EXISTS ${PYTHON_APP})
	dk_download(${PYTHON_DL} ${DKDOWNLOAD}/Python-2.7.18.tgz)
	dk_executeProcess(${DKDOWNLOAD}/Python-2.7.18.tgz)
	#TODO
ENDIF()
IF(RASPBERRY AND NOT EXISTS ${PYTHON_APP})
	dk_download(${PYTHON_DL} ${DKDOWNLOAD}/Python-2.7.18.tgz)
	dk_executeProcess(${DKDOWNLOAD}/Python-2.7.18.tgz)
	#TODO
ENDIF()
#WIN_HOST_dk_import			(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi)
#MAC_HOST_dk_import			(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg)
#LINUX_HOST_dk_import		(PYTHON_DL https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
#RASPBERRY_HOST_dk_import	(PYTHON_DL https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
