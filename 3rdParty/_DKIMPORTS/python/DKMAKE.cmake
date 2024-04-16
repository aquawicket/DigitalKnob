# https://docs.python.org/3/using/windows.html
# Windows	https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi
# Mac		https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg
# Linux		https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
# https://silentinstallhq.com/python-2-7-silent-install-how-to-guide/

# Portable Python 2.7.17
# https://sourceforge.net/projects/portable-python/
# https://sourceforge.net/projects/portable-python/files/Portable%20Python%202.7/Portable%20Python-2.7.17%20x64.exe/download

# Uninstall
# https://stackoverflow.com/a/3819829


#WIN_HOST_dk_set	(PYTHON_DL https://sourceforge.net/projects/portable-python/files/Portable%20Python%202.7/Portable%20Python-2.7.17%20x64.exe)
WIN_HOST_dk_set		(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi)
MAC_HOST_dk_set		(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg)
LINUX_HOST_dk_set	(PYTHON_DL https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tar.xz)


## Get PYTHON_DL_FILE, PYTHON_FOLDER and PYTHON variables
if(PYTHON_DL)
	get_filename_component(PYTHON_DL_FILE ${PYTHON_DL} NAME)
	dk_removeExtension(${PYTHON_DL_FILE} PYTHON_FOLDER)
	string(MAKE_C_IDENTIFIER ${PYTHON_FOLDER} PYTHON_FOLDER)
	dk_set(PYTHON ${DK3RDPARTY_DIR}/${PYTHON_FOLDER})
endif()


###### PYTHON_EXE ######
if(ANDROID_HOST)
	dk_find_program(PYTHON_EXE python)
elseif(MAC_HOST)
	dk_find_program(PYTHON_EXE python /usr/local/bin)
else()
	dk_find_program(PYTHON_EXE python ${PYTHON})
endif()

### INSTALL ###
if(NOT EXISTS ${PYTHON_EXE})
	dk_debug(" Installing python . . . . ")
	if(WIN_HOST)
		#dk_makeDirectory(${PYTHON})
		dk_download(${PYTHON_DL} ${DKDOWNLOAD_DIR}/${PYTHON_DL_FILE})
		cmake_path(NATIVE_PATH DKDOWNLOAD_DIR NORMALIZE DKDOWNLOAD_DIR_WINPATH)
		cmake_path(NATIVE_PATH PYTHON NORMALIZE PYTHON_WINPATH)
		file(WRITE "${PYTHON}/python_install.cmd" "${DKDOWNLOAD_DIR_WINPATH}\\${PYTHON_DL_FILE} /passive PrependPath=1 TargetDir=${PYTHON_WINPATH}")
		dk_executeProcess(${PYTHON}/python_install.cmd)
		
		#dk_sleep(60)
		
		if(ANDROID_HOST)
			dk_find_program(PYTHON_EXE python)
		else()
			dk_find_program(PYTHON_EXE python ${PYTHON})
		endif()

		if(EXISTS ${PYTHON}/include)
			dk_set(Python_INCLUDE_DIRS ${PYTHON}/include)
		endif()
		if(EXISTS ${PYTHON}/libs)
			dk_set(Python_LIBRARIES 	${PYTHON}/libs)
		endif()
	elseif(MAC_HOST)
		dk_download(${PYTHON_DL} ${DKDOWNLOAD_DIR}/${PYTHON_DL_FILE})
		dk_command(sudo installer -pkg ${DKDOWNLOAD_DIR}/${PYTHON_DL_FILE} -target /)
		#dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
	elseif(ANDROID_HOST)
		dk_todo("python install for ANDROID_HOST")
		dk_command(pkg install python)
	elseif(RASPBERRY_HOST)
		dk_todo("python install for RASPBERRY_HOST")
	elseif(LINUX_HOST)
		#dk_import(${PYTHON_DL})
	else()
		dk_error("NONE OF THE HOST VARIABLES were found to install python")
	endif()
endif()

## Try to find it after the install
if(ANDROID_HOST)
	dk_find_program(PYTHON_EXE python)
elseif(MAC_HOST)
	dk_find_program(PYTHON_EXE python /usr/local/bin)
else ()
	dk_find_program(PYTHON_EXE python ${PYTHON})
endif ()

if(NOT EXISTS ${PYTHON_EXE})
	dk_error("COULD NOT FIND PYTHON_EXE:${PYTHON_EXE}")
	return()
endif()

if(EXISTS ${PYTHON})
	dk_prependEnvPath("${PYTHON}")
endif()
dk_debug(PYTHON_EXE)




###### PIP_EXE ######
if(WIN_HOST)
	dk_find_program(PIP_EXE pip ${PYTHON}/Scripts)
	if(NOT EXISTS ${PIP_EXE})
		dk_executeProcess(${PYTHON_EXE} -m ensurepip)
	endif()
	dk_find_program(PIP_EXE pip ${PYTHON}/Scripts)
	
	if(NOT EXISTS ${PIP_EXE})
		dk_error("COULD NOT FIND PIP_EXE:${PIP_EXE}")
		return()
	endif()
	dk_debug(PIP_EXE)
endif()



### MAC UNINTALL ###
# Remove the third-party Python 2.7 framework
# sudo rm -rf /Library/Frameworks/Python.framework/Versions/2.7
	
# Remove the Python 2.7 applications directory
# sudo rm -rf "/Applications/Python 2.7"

# Remove the symbolic links	
# ls -l /usr/local/bin | grep '../Library/Frameworks/Python.framework/Versions/2.7'
	
# remove all the links
# cd /usr/local/bin/
# ls -l /usr/local/bin | grep '../Library/Frameworks/Python.framework/Versions/2.7' | awk '{print $9}' | tr -d @ | xargs rm



### INSTALL ###
#if(WIN_HOST)
#	dk_set(PYTHON_EXE ${PYTHON}/python.exe)
#	
#	if(NOT EXISTS ${PYTHON_EXE})
#		dk_makeDirectory(${PYTHON})
#		dk_download(${PYTHON_DL} ${DKDOWNLOAD_DIR}/${PYTHON_DL_FILE})
#		cmake_path(NATIVE_PATH DKDOWNLOAD_DIR NORMALIZE DKDOWNLOAD_DIR_WINPATH)
#		cmake_path(NATIVE_PATH PYTHON NORMALIZE PYTHON_WINPATH)
#		file(WRITE "${PYTHON}/python_install.cmd" "${DKDOWNLOAD_DIR_WINPATH}\\${PYTHON_DL_FILE} /passive PrependPath=1 TargetDir=${PYTHON_WINPATH}")
#		dk_executeProcess(${PYTHON}/python_install.cmd)
#		#dk_executeProcess(${DKDOWNLOAD_DIR}/${PYTHON_DL_FILE})
#	endif()
#
#	if(NOT EXISTS ${PYTHON}/Scripts/pip.exe)
#		dk_executeProcess(${PYTHON_EXE} -m ensurepip)
#	endif()
#
#	dk_set(Python_INCLUDE_DIRS ${PYTHON}/include)
#	dk_debug(Python_INCLUDE_DIRS)
#	dk_set(Python_LIBRARIES 	${PYTHON}/libs)
#	dk_debug(Python_LIBRARIES)
#elseif(MAC_HOST)
#	dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
#	
#	if(NOT EXISTS "/Applications/Python\ 2.7")
#		dk_download(${PYTHON_DL} ${DKDOWNLOAD_DIR}/python-2.7.18-macosx10.9.pkg)
#		dk_executeProcess(sudo installer -verbose -pkg ${DKDOWNLOAD_DIR}/python-2.7.18-macosx10.9.pkg -target /)
#		dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
#	endif()
#elseif(ANDROID_HOST)
#	dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
#	
#	if(NOT EXISTS ${PYTHON_EXE})
#		dk_command(pkg install python)
#		dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
#	endif()
#	# https://stackoverflow.com/a/38121972
#	#d_k_commandToVariable(PYTHON_VERSION "python" "--version")
#	#d_k_commandToVariable(PYTHON_INCLUDE_DIR "python" -c "import sysconfig; print(sysconfig.get_path('include'))" )
#	#d_k_commandToVariable(PYTHON_LIBRARY $(python -c "import sysconfig; print(sysconfig.get_config_var('LIBDIR'))"))
#	#find_package(Python)
#	#find_package(Python COMPONENTS Development)
#
#	# /data/data/com.termux/files/usr/include/python3.11
#	dk_set(Python_INCLUDE_DIRS /data/data/com.termux/files/usr/include/python3.11)
#	dk_debug(Python_INCLUDE_DIRS)
#
#	# /data/data/com.termux/files/usr/lib
#	dk_set(Python_LIBRARIES /data/data/com.termux/files/usr/lib)
#	dk_debug(Python_LIBRARIES)
#
#	dk_set(PYTHON_CMAKE -DPython_EXECUTABLE=${PYTHON_EXE} -DPython_INCLUDE_DIRS=${Python_INCLUDE_DIRS} -DPython_LIBRARIES=${Python_LIBRARIES})
#elseif(RASPBERRY)
#	dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
#	
#	if(NOT EXISTS ${PYTHON_EXE})
#		dk_import(https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
#		dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
#	endif()
#elseif(LINUX)
#	dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
#	if(NOT EXISTS ${PYTHON_EXE})
#		dk_import(https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz)
#		dk_command(bash -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NOASSERT)
#	endif()
#endif()
