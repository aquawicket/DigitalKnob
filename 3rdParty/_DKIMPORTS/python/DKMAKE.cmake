# https://docs.python.org/3/using/windows.html
# Windows	https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi
# Mac		https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg
# Linux		https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
# https://silentinstallhq.com/python-2-7-silent-install-how-to-guide/


dk_set			(PYTHON_FOLDER python-2.7.18)
dk_set			(PYTHON ${3RDPARTY}/${PYTHON_FOLDER})
WIN_dk_set		(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi)
APPLE_dk_set	(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg)
WIN_dk_set		(PYTHON_APP ${PYTHON}/python.exe)
APPLE_dk_set	(PYTHON_APP python)
LINUX_dk_set	(PYTHON_APP python)
RASPBERRY_dk_set(PYTHON_APP python)


### INSTALL ###
if(WIN)
	dk_makeDirectory(${PYTHON})
	dk_setEnv("PATH" "${PYTHON}")
	if(NOT EXISTS ${PYTHON_APP})
		dk_download(${PYTHON_DL} ${DKDOWNLOAD}/python-2.7.18.msi)
		#string(REPLACE "/" "\\" PYTHON_PATH "${PYTHON}")
		#dk_executeProcess(${DKDOWNLOAD}/python-2.7.18.msi /passive PrependPath=1 TargetDir=${PYTHON_PATH})
		
		#NOTE:	TargetDir requires the path to use backslashes, yet I cannot figure out how to send this command
		#		from cmake successfully. So, the command is placed in 'python/install.cmd' and called instead.
		dk_executeProcess(${DKIMPORTS}/python/install.cmd)
	endif()
	if(EXISTS ${PYTHON_APP})
		if(NOT EXISTS ${PYTHON}/Scripts/pip.exe)
			#dk_executeProcess(cmd /c ${PYTHON_APP} -m ensurepip)
			dk_executeProcess(${PYTHON_APP} -m ensurepip)
		endif()
	endif()
endif()
if(MAC AND NOT EXISTS "/Applications/Python\ 2.7")
	dk_download(${PYTHON_DL} ${DKDOWNLOAD}/python-2.7.18-macosx10.9.pkg)
	dk_executeProcess(sudo installer -verbose -pkg ${DKDOWNLOAD}/python-2.7.18-macosx10.9.pkg -target /)
endif()
if(LINUX AND NOT EXISTS ${PYTHON_APP}) #FIXME
	dk_import(https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
endif()
if(RASPBERRY AND NOT EXISTS ${PYTHON_APP}) #FIXME
	dk_import(https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
endif()
