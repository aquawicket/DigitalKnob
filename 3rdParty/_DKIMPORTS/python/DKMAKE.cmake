#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ python ############
# https://docs.python.org/3/using/windows.html
# https://silentinstallhq.com/python-2-7-silent-install-how-to-guide/
# Uninstall: https://stackoverflow.com/a/3819829
#
#   windows uninstall registry location
#	HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{A5F504DF-2ED9-4A2D-A2F3-9D2750DD42D6}
#

###### IMPORT ######
dk_validate(host_triple "dk_host_triple()")
if(LINUX_HOST)	
	dk_set(PYTHON_DL https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tar.xz)
elseif(MAC_HOST)
	dk_set(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg)
elseif(WIN_X86_HOST)
	dk_set(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18.msi)
elseif(WIN_X86_64_HOST)
	dk_set(PYTHON_DL https://www.python.org/ftp/python/2.7.18/python-2.7.18.amd64.msi)
endif()
###### PYTHON_VARIABLES ######
if(PYTHON_DL)
	dk_importVariables(${PYTHON_DL})
endif()

###### PYTHON_EXE (first check) ######
dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
if(EXISTS "${PYTHON_DIR}")
	dk_findProgram(PYTHON_EXE python "${PYTHON_DIR}")
elseif(EXISTS "/usr/local/bin")
	dk_findProgram(PYTHON_EXE python "/usr/local/bin")
elseif(NOT WIN_HOST)
	dk_findProgram(PYTHON_EXE python)
endif()
if(EXISTS "${PYTHON_DIR}/include")
	dk_set(Python_INCLUDE_DIRS "${PYTHON_DIR}/include")
endif()
if(EXISTS "${PYTHON_DIR}/libs")
	dk_set(Python_LIBRARIES    "${PYTHON_DIR}/libs")
endif()

###### INSTALL ######
if(NOT EXISTS "${PYTHON_EXE}")
	dk_info(" Installing python . . . . ")
	if(MAC_HOST)
		dk_download(${PYTHON_DL} ${DKDOWNLOAD_DIR}/${PYTHON_DL_FILE})
		dk_depend(sudo)
		dk_command(${SUDO_EXE} installer -pkg ${DKDOWNLOAD_DIR}/${PYTHON_DL_FILE} -target /)
		#dk_command(${BASH_EXE} -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NO_HALT)
	elseif(WIN_HOST)
		dk_download(${PYTHON_DL} ${DKDOWNLOAD_DIR}/${PYTHON_DL_FILE})
		#dk_getNativePath(${DKDOWNLOAD_DIR} DKDOWNLOAD_DIR_WINPATH)
		dk_replaceAll(${DKDOWNLOAD_DIR} "/" "\\" DKDOWNLOAD_DIR_WINPATH)
		#dk_getNativePath(${PYTHON_DIR} PYTHON_WINPATH)
		dk_replaceAll(${PYTHON_DIR} "/" "\\" PYTHON_WINPATH)
		dk_fileWrite("${PYTHON_DIR}\\python_install.cmd" "${DKDOWNLOAD_DIR_WINPATH}\\${PYTHON_DL_FILE} /passive PrependPath=1 TargetDir=${PYTHON_WINPATH}")
		dk_executeProcess(${PYTHON_DIR}/python_install.cmd)
	elseif(LINUX_HOST)
		dk_import(${PYTHON_DL})
		execute_process(COMMAND ./configure --enable-optimizations WORKING_DIRECTORY ${PYTHON_DIR})
		execute_process(COMMAND make WORKING_DIRECTORY ${PYTHON_DIR})
	else()
		dk_installPackage(python)
	endif()
endif()

###### PYTHON_EXE (second check) ######
if(EXISTS "${PYTHON_DIR}")
	dk_findProgram(PYTHON_EXE python "${PYTHON_DIR}")
elseif(EXISTS "/usr/local/bin")
	dk_findProgram(PYTHON_EXE python "/usr/local/bin")
elseif(NOT WIN_HOST)
	dk_findProgram(PYTHON_EXE python)
endif()
if(EXISTS "${PYTHON_DIR}/include")
	dk_set(Python_INCLUDE_DIRS "${PYTHON_DIR}/include")
endif()
if(EXISTS "${PYTHON_DIR}/libs")
	dk_set(Python_LIBRARIES 	"${PYTHON_DIR}/libs")
endif()

dk_assertPath(PYTHON)
if(NOT LINUX)
	dk_assertPath(PYTHON_EXE)
endif()

### FIXME: we can't have both python2 and python3 in the environment path 
#dk_prependEnvPath("${PYTHON_DIR}")

###### PIP_EXE ######
if(WIN_HOST)
	dk_findProgram(PIP_EXE pip ${PYTHON_DIR}/Scripts)
	if(NOT EXISTS ${PIP_EXE})
		dk_executeProcess(${PYTHON_EXE} -m ensurepip)
	endif()
	dk_findProgram(PIP_EXE pip ${PYTHON_DIR}/Scripts)
	
	dk_assertPath(PIP_EXE)
	dk_executeProcess(${PYTHON_EXE} -m pip install --upgrade pip)
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




