# https://docs.python.org/3/using/windows.html
# Windows	https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi
# Mac		https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg
# Linux		https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
# https://silentinstallhq.com/python-2-7-silent-install-how-to-guide/


dk_set				(PYTHON_FOLDER python-2.7.18)
dk_set				(PYTHON ${DK3RDPARTY_DIR}/${PYTHON_FOLDER})
WIN_HOST_dk_set		(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi)
APPLE_dk_set		(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg)
WIN_HOST_dk_set		(PYTHON_APP ${PYTHON}/python.exe)
UNIX_HOST_dk_set	(PYTHON_APP python)

## TODO: change all PYTHON_APP occurences to PYTHON_EXE
dk_set				(PYTHON_EXE ${PYTHON_APP})

#PYTHON_CFLAGS
#PYTHON_LIBS
#${PYTHON}/include


### INSTALL ###
if(WIN_HOST)
	dk_makeDirectory(${PYTHON})
	if(NOT EXISTS ${PYTHON_APP})
		dk_download(${PYTHON_DL} ${DKDOWNLOAD_DIR}/python-2.7.18.msi)
		#string(REPLACE "/" "\\" PYTHON_PATH "${PYTHON}")
		#dk_executeProcess(${DKDOWNLOAD_DIR}/python-2.7.18.msi /passive PrependPath=1 TargetDir=${PYTHON_PATH})
		
		#NOTE:	TargetDir requires the path to use backslashes, yet I cannot figure out how to send this command
		#		from cmake successfully. So, the command is placed in 'python/install.cmd' and called instead.
		dk_executeProcess(${DKIMPORTS_DIR}/python/install.cmd)
		dk_setEnv("PATH" "${PYTHON}") # BE CAREFUL WITH THIS. It can make the shell unresponsive to commands
	endif()
	if(EXISTS ${PYTHON_APP})
		if(NOT EXISTS ${PYTHON}/Scripts/pip.exe)
			#dk_executeProcess(cmd /c ${PYTHON_APP} -m ensurepip)
			dk_executeProcess(${PYTHON_APP} -m ensurepip)
		endif()
	endif()
endif()
if(MAC AND NOT EXISTS "/Applications/Python\ 2.7")
	dk_download(${PYTHON_DL} ${DKDOWNLOAD_DIR}/python-2.7.18-macosx10.9.pkg)
	dk_executeProcess(sudo installer -verbose -pkg ${DKDOWNLOAD_DIR}/python-2.7.18-macosx10.9.pkg -target /)
endif()
if(LINUX AND NOT EXISTS ${PYTHON_APP}) #FIXME
	dk_import(https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
endif()
if(RASPBERRY AND NOT EXISTS ${PYTHON_APP}) #FIXME
	dk_import(https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
endif()

ANDROID_HOST_dk_command(pkg install python)

if(ANDROID_HOST)
	# https://stackoverflow.com/a/38121972
	#d_k_commandToVariable(PYTHON_VERSION "python" "--version")
	#d_k_commandToVariable(PYTHON_INCLUDE_DIR "python" -c "import sysconfig; print(sysconfig.get_path('include'))" )
	#d_k_commandToVariable(PYTHON_LIBRARY $(python -c "import sysconfig; print(sysconfig.get_config_var('LIBDIR'))"))
	#find_package(Python)
	#find_package(Python COMPONENTS Development)

	# /data/data/com.termux/files/usr/include/python3.11
	dk_set(Python_INCLUDE_DIRS /data/data/com.termux/files/usr/include/python3.11)
	dk_debug(Python_INCLUDE_DIRS	PRINTVAR)

	# /data/data/com.termux/files/usr/lib
	dk_set(Python_LIBRARIES /data/data/com.termux/files/usr/lib)
	dk_debug(Python_LIBRARIES		PRINTVAR)

	dk_set(PYTHON_CMAKE -DPython_EXECUTABLE=${PYTHON_APP} -DPython_INCLUDE_DIRS=${Python_INCLUDE_DIRS} -DPython_LIBRARIES=${Python_LIBRARIES})
endif ()


dk_debug(PYTHON_APP		PRINTVAR)
dk_command(${PYTHON_APP} --version)
