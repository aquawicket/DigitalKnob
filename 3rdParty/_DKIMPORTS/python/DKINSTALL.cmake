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
#set(PLUGIN_Import_Path "${CMAKE_CURRENT_LIST_DIR}")
#dk_getFileParams("${PLUGIN_Import_Path}/dkconfig.txt")
dk_validate(Host_Tuple "dk_Host_Tuple()")
#dk_basename(${PLUGIN_Import_Path} PLUGIN_Import_Name)
#if(${PLUGIN_Import_Name}_${Host_Tuple}_Import)
#	set(python_Import "${PLUGIN_Import_Name}_${Host_Tuple}_Import")
#elseif(${PLUGIN_Import_Name}_Import)
#	set(python_Import "${PLUGIN_Import_Name}_Import")
#endif()
#dk_importVariables(${${python_Import}})
dk_import()	

###### python_exe (first check) ######
if(EXISTS "${python}")
	dk_findProgram(python_exe python "${python}")
elseif(EXISTS "/usr/local/bin")
	dk_findProgram(python_exe python "/usr/local/bin")
elseif(NOT Windows_Host)
	dk_findProgram(python_exe python)
endif()
if(EXISTS "${python}/include")
	dk_set(Python_INCLUDE_DIRS "${python}/include")
endif()
if(EXISTS "${python}/libs")
	dk_set(Python_LIBRARIES    "${python}/libs")
endif()

###### INSTALL ######
if(NOT EXISTS "${python_exe}")
	dk_info(" Installing python . . . . ")
	if(Mac_Host)
		dk_download(${python_Url})
		dk_depend(sudo)
		dk_exec(${sudo_exe} installer -pkg ${dk_download} -target /)
		#dk_exec(${bash_exe} -c "command -v python" OUTPUT_VARIABLE python_exe NO_HALT)
	elseif(Windows_Host)
		dk_download(${python_Url})
		dk_replaceAll(${dk_download} "/" "\\" dk_download_win)
		dk_replaceAll(${python} "--" "-" python)
		dk_replaceAll(${python} "/" "\\" python_WIN)
		dk_mkdir(${python})
		dk_exec($ENV{ComSpec} /c ${dk_download_win} /passive PrependPath=1 TargetDir=${python_WIN})
	elseif(Linux_Host)
		dk_import(${python_Url})
		####   Code below used To run the command in a fresh environment    ####
		#### exec env -i HOME="$HOME" PATH="$PATH" bash -l -c '>>COMMAND<<' ####
		# './configure --enable-optimizations'
		#execute_process(COMMAND bash -l -c './configure' WORKING_DIRECTORY "${python}")
		execute_process(COMMAND exec env -i HOME="$ENV{HOME}" PATH="$ENV{PATH}" bash -l -c './configure' WORKING_DIRECTORY ${python})
		execute_process(COMMAND make WORKING_DIRECTORY ${python})
	else()
		dk_installPackage(python)
	endif()
endif()

###### python_exe (second check) ######
if(EXISTS "${python}")
	dk_findProgram(python_exe python "${python}")
elseif(EXISTS "/usr/local/bin")
	dk_findProgram(python_exe python "/usr/local/bin")
elseif(NOT Windows_Host)
	dk_findProgram(python_exe python)
endif()
if(EXISTS "${python}/include")
	dk_set(Python_INCLUDE_DIRS "${python}/include")
endif()
if(EXISTS "${python}/libs")
	dk_set(Python_LIBRARIES 	"${python}/libs")
endif()


if((NOT Linux_Host) AND (NOT Android_Host))
	dk_assertPath(python)
	dk_assertPath(python_exe)
endif()

if(Windows_Host)
	dk_firewallAllow("${python_exe}")
endif()

### FIXME: we can't have both python2 and python3 in the environment path 
#dk_prependEnvPath("${python}")

###### pip_exe ######
if(Windows_Host)
	dk_findProgram(pip_exe pip ${python}/Scripts)
	if(NOT EXISTS ${pip_exe})
		dk_exec(${python_exe} -m ensurepip)
	endif()
	dk_findProgram(pip_exe pip ${python}/Scripts)
	
	dk_assertPath(pip_exe)
	dk_exec(${python_exe} -m pip install --upgrade pip)
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




