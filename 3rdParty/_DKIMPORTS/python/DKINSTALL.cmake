#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ python ############
# https://docs.python.org/3/using/windows.html
# https://silentinstallhq.com/python-2-7-silent-install-how-to-guide/
# Uninstall: https://stackoverflow.com/a/3819829
#
#   windows uninstall registry location
#	HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{A5F504DF-2ED9-4A2D-A2F3-9D2750DD42D6}

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
	dk_findProgram(python2_exe python "${python}")
	set(python_exe ${python2_exe})
elseif(EXISTS "/usr/local/bin")
	dk_findProgram(python2_exe python "/usr/local/bin")
	set(python_exe ${python2_exe})
elseif(NOT Windows_Host)
	dk_findProgram(python2_exe python)
	set(python_exe ${python2_exe})
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
	if(Linux_Host)
		dk_import(${python_Import})
		####   Code below used To run the command in a fresh environment    ####
		#### exec env -i HOME="$HOME" PATH="$PATH" bash -l -c '>>COMMAND<<' ####
		# './configure --enable-optimizations'
		#execute_process(COMMAND bash -l -c './configure' WORKING_DIRECTORY "${python}")
		execute_process(COMMAND exec env -i HOME="$ENV{HOME}" PATH="$ENV{PATH}" bash -l -c './configure' WORKING_DIRECTORY ${python})
		execute_process(COMMAND make WORKING_DIRECTORY ${python})
	elseif(Mac_Host)
		dk_download(${python_Import})
		dk_validate(sudo_exe "dk_depend(sudo_exe)")
		dk_exec(${sudo_exe} installer -pkg ${dk_download} -target /)
		#dk_exec(${bash_exe} -c "command -v python" OUTPUT_VARIABLE python_exe NO_HALT)
	elseif(Windows_Host)
		dk_import()
		#dk_download(${python_Import})
		dk_replaceAll(${dk_download} "/" "\\" dk_download_win)
		dk_replaceAll(${python} "--" "-" python)
		dk_replaceAll(${python} "/" "\\" python_WIN)
		dk_mkdir(${python})
		dk_validate(cmd.exe "dk_depend(cmd.exe)")
		dk_exec(${cmd.exe} /c ${dk_download_win} /passive PrependPath=1 TargetDir=${python_WIN})
	else()
		dk_installPackage(python)
	endif()
endif()

###### python_exe (second check) ######
if(EXISTS "${python}")
	dk_findProgram(python2_exe python "${python}")
	set(python_exe ${python2_exe})
elseif(EXISTS "/usr/local/bin")
	dk_findProgram(python2_exe python "/usr/local/bin")
	set(python_exe ${python2_exe})
elseif(NOT Windows_Host)
	dk_findProgram(python2_exe python)
	set(python_exe ${python2_exe})
endif()
if(EXISTS "${python}/include")
	dk_set(Python_INCLUDE_DIRS "${python}/include")
endif()
if(EXISTS "${python}/libs")
	dk_set(Python_LIBRARIES 	"${python}/libs")
endif()


if((NOT Linux_Host) AND (NOT Android_Host))
	dk_assertPath(python)
	dk_assertPath(python2_exe)
	dk_assertPath(python_exe)
endif()

if(Windows_Host)
	dk_firewallAllow("${python2_exe}")
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




