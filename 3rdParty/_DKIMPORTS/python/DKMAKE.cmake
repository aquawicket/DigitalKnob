# https://docs.python.org/3/using/windows.html
# Windows	https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi
# Mac		https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg
# Linux		https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
# https://silentinstallhq.com/python-2-7-silent-install-how-to-guide/


dk_set				(PYTHON_FOLDER python-2.7.18)
dk_set				(PYTHON ${DK3RDPARTY_DIR}/${PYTHON_FOLDER})
WIN_HOST_dk_set		(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi)
MAC_HOST_dk_set		(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg)
LINUX_HOST_dk_set	(PYTHON_DL https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tar.xz)
if(PYTHON_DL)
	get_filename_component(PYTHON_DL_FILE ${PYTHON_DL} NAME)
endif()


### INSTALL ###
if(WIN_HOST)
	dk_set(PYTHON_EXE ${PYTHON}/python.exe)
	
	if(NOT EXISTS ${PYTHON_EXE})
		dk_makeDirectory(${PYTHON})
		dk_download(${PYTHON_DL} ${DKDOWNLOAD_DIR}/${PYTHON_DL_FILE})
		#string(REPLACE "/" "\\" DKDOWNLOAD_DIR_WINPATH "${DKDOWNLOAD_DIR}")
		#string(REPLACE "/" "\\" PYTHON_WINPATH "${PYTHON}")
		#file(TO_NATIVE_PATH "${DKDOWNLOAD_DIR}" DKDOWNLOAD_DIR_WINPATH)
		#file(TO_NATIVE_PATH "${PYTHON}" PYTHON_WINPATH)
		cmake_path(NATIVE_PATH DKDOWNLOAD_DIR NORMALIZE DKDOWNLOAD_DIR_WINPATH)
		cmake_path(NATIVE_PATH PYTHON NORMALIZE PYTHON_WINPATH)
		file(WRITE "${PYTHON}/python_install.cmd" "${DKDOWNLOAD_DIR_WINPATH}\\${PYTHON_DL_FILE} /passive PrependPath=1 TargetDir=${PYTHON_WINPATH}")
		dk_executeProcess(${PYTHON}/python_install.cmd)
	endif()

	if(NOT EXISTS ${PYTHON}/Scripts/pip.exe)
		dk_executeProcess(${PYTHON_EXE} -m ensurepip)
	endif()

	dk_prependEnvPath("${PYTHON}")
	
	dk_set(Python_INCLUDE_DIRS ${PYTHON}/include)
	dk_debug(Python_INCLUDE_DIRS	PRINTVAR)
	
	dk_set(Python_LIBRARIES ${PYTHON}/libs)
	dk_debug(Python_LIBRARIES		PRINTVAR)
	dk_set(PYTHON_EXE ${PYTHON_EXE})	#cache the variable
elseif(MAC_HOST)
	dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
	
	if(NOT EXISTS "/Applications/Python\ 2.7")
		dk_download(${PYTHON_DL} ${DKDOWNLOAD_DIR}/python-2.7.18-macosx10.9.pkg)
		dk_executeProcess(sudo installer -verbose -pkg ${DKDOWNLOAD_DIR}/python-2.7.18-macosx10.9.pkg -target /)
		dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
	endif()
	dk_set(PYTHON_EXE ${PYTHON_EXE})	#cache the variable
elseif(ANDROID_HOST)
	dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
	
	if(NOT EXISTS ${PYTHON_EXE})
		dk_command(pkg install python)
		dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
	endif()
	DK_ASSERT_PATH(${PYTHON_EXE})
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

	dk_set(PYTHON_CMAKE -DPython_EXECUTABLE=${PYTHON_EXE} -DPython_INCLUDE_DIRS=${Python_INCLUDE_DIRS} -DPython_LIBRARIES=${Python_LIBRARIES})
	dk_set(PYTHON_EXE ${PYTHON_EXE})	#cache the variable
elseif(RASPBERRY)
	dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
	
	if(NOT EXISTS ${PYTHON_EXE})
		dk_import(https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
		dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
	endif()
	dk_set(PYTHON_EXE ${PYTHON_EXE})	#cache the variable
elseif(LINUX)
	dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
	if(NOT EXISTS ${PYTHON_EXE})
		dk_import(https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
		dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
	endif()
	dk_set(PYTHON_EXE ${PYTHON_EXE})	#cache the variable
endif()

#dk_debug(PYTHON_EXE		PRINTVAR)
#dk_command(${PYTHON_EXE} --version OUTPUT_VARIABLE PYTHON_VERSION ERROR_VARIABLE PYTHON_VERSION)
#dk_debug(PYTHON_VERSION	PRINTVAR)
DK_ASSERT_PATH(PYTHON_EXE)