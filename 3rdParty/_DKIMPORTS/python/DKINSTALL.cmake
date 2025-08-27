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
dk_assertPath("${PLUGIN_Import_Path}/dkconfig.txt")
dk_getFileParams("${PLUGIN_Import_Path}/dkconfig.txt")
dk_validate(Host_Tuple "dk_Host_Tuple()")
dk_basename(${PLUGIN_Import_Path} PLUGIN_Import_Path)
	
#dk_assertVar(${PLUGIN_Import_Path}_${Host_Tuple}_Import)
if(${PLUGIN_Import_Path}_${Host_Tuple}_Import)
	set(PLUGIN_IMPORT "${PLUGIN_Import_Path}_${Host_Tuple}_Import")
elseif(${PLUGIN_Import_Path}_Import)
	set(PLUGIN_IMPORT "${PLUGIN_Import_Path}_Import")
else()
	dk_assertVar(${PLUGIN_Import_Path}_Import)
endif()
dk_importVariables(${${PLUGIN_IMPORT}})
	
	
	
	
	
	
#dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_validate			(Host_Tuple "dk_Host_Tuple()")
#dk_importVariables(${python_${Host_Tuple}_Import} IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})
dk_assertVar(PYTHON)

###### PYTHON_EXE (first check) ######
#dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
if(EXISTS "${PYTHON}")
	dk_findProgram(PYTHON_EXE python "${PYTHON}")
elseif(EXISTS "/usr/local/bin")
	dk_findProgram(PYTHON_EXE python "/usr/local/bin")
elseif(NOT Windows_Host)
	dk_findProgram(PYTHON_EXE python)
endif()
if(EXISTS "${PYTHON}/include")
	dk_set(Python_INCLUDE_DIRS "${PYTHON}/include")
endif()
if(EXISTS "${PYTHON}/libs")
	dk_set(Python_LIBRARIES    "${PYTHON}/libs")
endif()

###### INSTALL ######
if(NOT EXISTS "${PYTHON_EXE}")
	dk_info(" Installing python . . . . ")
	if(Mac_Host)
		dk_download(${PYTHON_Url})
		dk_validate(SUDO_EXE "dk_depend(sudo)")
		dk_exec(${SUDO_EXE} installer -pkg ${dk_download} -target /)
		#dk_exec(${BASH_EXE} -c "command -v python" OUTPUT_VARIABLE PYTHON_EXE NO_HALT)
	elseif(Windows_Host)
		dk_download(${PYTHON_Url})
		#dk_nativePath($ENV{DKDOWNLOAD_DIR} DKDOWNLOAD_DIR_WINPATH)
		#dk_nativePath(${PYTHON} PYTHON_WIN)
		dk_replaceAll(${dk_download} "/" "\\" dk_download_win)
		dk_replaceAll(${PYTHON} "--" "-" PYTHON)
		dk_replaceAll(${PYTHON} "/" "\\" PYTHON_WIN)
		dk_mkdir(${PYTHON})
		dk_exec($ENV{ComSpec} /c ${dk_download_win} /passive PrependPath=1 TargetDir=${PYTHON_WIN})
	elseif(Linux_Host)
		dk_import(${PYTHON_Url})
		####   Code below used To run the command in a fresh environment    ####
		#### exec env -i HOME="$HOME" PATH="$PATH" bash -l -c '>>COMMAND<<' ####
		# './configure --enable-optimizations'
		#execute_process(COMMAND bash -l -c './configure' WORKING_DIRECTORY "${PYTHON}")
		execute_process(COMMAND exec env -i HOME="$ENV{HOME}" PATH="$ENV{PATH}" bash -l -c './configure' WORKING_DIRECTORY ${PYTHON})
		execute_process(COMMAND make WORKING_DIRECTORY ${PYTHON})
	else()
		dk_installPackage(python)
	endif()
endif()

###### PYTHON_EXE (second check) ######
if(EXISTS "${PYTHON}")
	dk_findProgram(PYTHON_EXE python "${PYTHON}")
elseif(EXISTS "/usr/local/bin")
	dk_findProgram(PYTHON_EXE python "/usr/local/bin")
elseif(NOT Windows_Host)
	dk_findProgram(PYTHON_EXE python)
endif()
if(EXISTS "${PYTHON}/include")
	dk_set(Python_INCLUDE_DIRS "${PYTHON}/include")
endif()
if(EXISTS "${PYTHON}/libs")
	dk_set(Python_LIBRARIES 	"${PYTHON}/libs")
endif()


if((NOT Linux_Host) AND (NOT Android_Host))
	dk_assertPath(PYTHON)
	dk_assertPath(PYTHON_EXE)
endif()

if(Windows_Host)
	dk_firewallAllow("Python" "${PYTHON_EXE}")
endif()

### FIXME: we can't have both python2 and python3 in the environment path 
#dk_prependEnvPath("${PYTHON}")

###### PIP_EXE ######
if(Windows_Host)
	dk_findProgram(PIP_EXE pip ${PYTHON}/Scripts)
	if(NOT EXISTS ${PIP_EXE})
		dk_exec(${PYTHON_EXE} -m ensurepip)
	endif()
	dk_findProgram(PIP_EXE pip ${PYTHON}/Scripts)
	
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




