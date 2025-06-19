#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ python ############
# https://docs.python.org/3/using/windows.html
# https://silentinstallhq.com/python-2-7-silent-install-how-to-guide/
# Uninstall: https://stackoverflow.com/a/3819829
#
#   windows uninstall registry location
#	HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{A5F504DF-2ED9-4A2D-A2F3-9D2750DD42D6}
#

###### IMPORT ######
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_validate			(Host_Tuple "dk_Host_Tuple()")
if(Linux_Host)	
	dk_set(PYTHON_IMPORT ${Python_Linux_Import})
elseif(Mac_Host)
	dk_set(PYTHON_IMPORT ${Python_Mac_Import})
elseif(Windows_X86_Host)
	dk_set(PYTHON_IMPORT ${Python_Windows_X86_Import})
elseif(Windows_X86_64_Host)
	dk_set(PYTHON_IMPORT ${Python_Windows_X86_64_Import})
endif()
###### PYTHON_VARIABLES ######
if(PYTHON_IMPORT)
	dk_importVariables(${PYTHON_IMPORT})
endif()

###### PYTHON_EXE (first check) ######
dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
if(EXISTS "${PYTHON_DIR}")
	dk_findProgram(PYTHON_EXE python "${PYTHON_DIR}")
elseif(EXISTS "/usr/local/bin")
	dk_findProgram(PYTHON_EXE python "/usr/local/bin")
elseif(NOT Windows_Host)
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
	if(Mac_Host)
		dk_download(${PYTHON_IMPORT} $ENV{DKDOWNLOAD_DIR}/${PYTHON_IMPORT_FILE})
		dk_validate(SUDO_EXE "dk_depend(sudo)")
		dk_command(${SUDO_EXE} installer -pkg $ENV{DKDOWNLOAD_DIR}/${PYTHON_IMPORT_FILE} -target /)
		#dk_command(${BASH_EXE} -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NO_HALT)
	elseif(Windows_Host)
		dk_download(${PYTHON_IMPORT} $ENV{DKDOWNLOAD_DIR}/${PYTHON_IMPORT_FILE})
		#dk_nativePath($ENV{DKDOWNLOAD_DIR} DKDOWNLOAD_DIR_WINPATH)
		dk_replaceAll($ENV{DKDOWNLOAD_DIR} "/" "\\" DKDOWNLOAD_DIR_WINPATH)
		#dk_nativePath(${PYTHON_DIR} PYTHON_WINPATH)
		dk_replaceAll(${PYTHON_DIR} "/" "\\" PYTHON_WINPATH)
		dk_fileWrite("${PYTHON_DIR}\\python_install.cmd" "${DKDOWNLOAD_DIR_WINPATH}\\${PYTHON_IMPORT_FILE} /passive PrependPath=1 TargetDir=${PYTHON_WINPATH}")
		dk_exec(${PYTHON_DIR}/python_install.cmd)
	elseif(Linux_Host)
		dk_import(${PYTHON_IMPORT})
		####   Code below used To run the command in a fresh environment    ####
		#### exec env -i HOME="$HOME" PATH="$PATH" bash -l -c '>>COMMAND<<' ####
		# './configure --enable-optimizations'
		#execute_process(COMMAND bash -l -c './configure' WORKING_DIRECTORY "${PYTHON_DIR}")
		execute_process(COMMAND exec env -i HOME="$ENV{HOME}" PATH="$ENV{PATH}" bash -l -c './configure' WORKING_DIRECTORY ${PYTHON_DIR})
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
elseif(NOT Windows_Host)
	dk_findProgram(PYTHON_EXE python)
endif()
if(EXISTS "${PYTHON_DIR}/include")
	dk_set(Python_INCLUDE_DIRS "${PYTHON_DIR}/include")
endif()
if(EXISTS "${PYTHON_DIR}/libs")
	dk_set(Python_LIBRARIES 	"${PYTHON_DIR}/libs")
endif()


if((NOT Linux_Host) AND (NOT Android_Host))
	dk_assertPath(PYTHON)
	dk_assertPath(PYTHON_EXE)
endif()

if(Windows_Host)
	dk_firewallAllow("Python" "${PYTHON_EXE}")
endif()

### FIXME: we can't have both python2 and python3 in the environment path 
#dk_prependEnvPath("${PYTHON_DIR}")

###### PIP_EXE ######
if(Windows_Host)
	dk_findProgram(PIP_EXE pip ${PYTHON_DIR}/Scripts)
	if(NOT EXISTS ${PIP_EXE})
		dk_exec(${PYTHON_EXE} -m ensurepip)
	endif()
	dk_findProgram(PIP_EXE pip ${PYTHON_DIR}/Scripts)
	
	dk_assertPath(PIP_EXE)
	dk_exec(${PYTHON_EXE} -m pip install --upgrade pip)
endif()



### Mac UNINTALL ###
# Remove the third-party Python 2.7 framework
# sudo rm -rf /Library/Frameworks/Python.framework/Versions/2.7
	
# Remove the Python 2.7 applications directory
# sudo rm -rf "/Applications/Python 2.7"

# Remove the symbolic links	
# ls -l /usr/local/bin | grep '../Library/Frameworks/Python.framework/Versions/2.7'
	
# remove all the links
# cd /usr/local/bin/
# ls -l /usr/local/bin | grep '../Library/Frameworks/Python.framework/Versions/2.7' | awk '{print $9}' | tr -d @ | xargs rm




