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
	dk_set			(PYTHON_IMPORT ${Python_Linux_Import})
elseif(Mac_Host)
	dk_set			(PYTHON_IMPORT ${Python_Mac_Import})
elseif(Windows_X86_Host)
	dk_set			(PYTHON_IMPORT ${Python_Windows_X86_Import})
elseif(Windows_X86_64_Host)
	dk_set			(PYTHON_IMPORT ${Python_Windows_X86_64_Import})
endif()

if(NOT PYTHON_IMPORT)
	dk_fatal("PYTHON_IMPORT invalid.")
endif()
dk_importVariables(${PYTHON_IMPORT})
dk_assertVar(PYTHON)

if(Windows_Host)
	dk_exec(MsiExec.exe /uninstall {A5F504DF-2ED9-4A2D-A2F3-9D2750DD42D6} /quiet)
	dk_delete("${PYTHON}")
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




