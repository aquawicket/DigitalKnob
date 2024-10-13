#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)

# https://www.gnu.org/software/bash/
# https://packages.msys2.org/package/bash

#	HOST		SHELL		BASH	TARGET_OS
#	android		termux		bash	android
#	linux		tinycore	bash	android, linux
#	linux		ubuntu		bash	android, linux
#	mac     	osx			bash	mac, ios, iossim
#	raspberry	pi			bash	raspberry
#	windows 	clang32    	bash	windows
#	windows 	clang64 	bash	windows
#	windows 	clangarm64 	bash	windows
#	windows 	git     	bash	android, windows
#	windows 	mingw32 	bash	windows
#	windows 	mingw64 	bash	windows
#	windows 	msys2  		bash	android, windows
#	windows 	ucrt64		bash	windows
#	windows 	wsl_debian	bash	linux
#	windows 	wsl_ubuntu	bash	linux

if(EXISTS ${BASH_EXE})
	return()
endif()


## We are looking for a good way to determin the path type we should use at any given moment in CMake.
## Say for example we are on a Windows box, using cmd, calling wsl.  Cmake will need /mnt/c/ type paths
## Or if Wsl invokes cmd.exe /c, that instance will require C:\ type paths. 
## The path type should corrolate to the current shell type. And when we are in CMake, we will 
## need to test the default shell type of execute_process to get the CMake subshell type.
## Another path problem then needs to be delt with is, when we are in a bash shell, how to translate 
## the home path properly at any location, and or be able to convert sais path to the desired type.
##
##    I.E. 
##
##		      UNIX =                          ${HOME}
##		   WINDOWS =					%USERPROFILE%
##			   cmd =				C:\Users\username 
##		  git bash =				/c/Users/username
##		msys2 bash =				/c/Users/username
##		  wsl bash =			/mnt/c/Users/username
##	   	linux bash =				   /home/username
##		MacOS bash =				  /Users/username
##	   termux bash = /data/data/com.termux/files/home
## 
## TEST: lets make a quick test the can be called from any shell, at any subshell level, and gets the correct path.
## Eventually we can expand on this class and add support for url's, xpaths, php, etc.
## Side note: maybe we can expand on dk_realpath to additionallu meet these requirements.
execute_process(COMMAND VER OUTPUT_VARIABLE CMDVER)
dk_printVar(DKSHELL)
if(CMDVER)
	if("${CMDVER}" MATCHES "*Microsoft*")
		dk_debug("CMDVER = ${CMDVER}")
	else()
		dk_debug("CMDVER = IS NOT MICROSOFT")
	endif()
endif()
dk_pause()


### Default bash ###
dk_findProgram(BASH_EXE bash.exe)# "C:/Windows/System32")
if(EXISTS ${BASH_EXE})
	set(BASH_EXE ${BASH_EXE} CACHE INTERNAL "")
	return()
endif()


### Git bash ###
dk_depend(git)
dk_findProgram(BASH_EXE bash "${GIT}/bin")
if(EXISTS ${BASH_EXE})
	set(BASH_EXE ${BASH_EXE} CACHE INTERNAL "")
	return()
endif()

### Msys2 bash ###
dk_depend(msys2)
dk_findProgram(BASH_EXE bash "${MSYS2_DIR}/usr/bin")
if(EXISTS ${BASH_EXE})
	set(BASH_EXE ${BASH_EXE} CACHE INTERNAL "")
	return()
endif()

### Tiny Core Linux ###
if(TINYCORE)
	### TODO ###
	#dk_command(tce-load -wi bash)
	dk_installPackage(bash)
endif()


if(NOT BASH_EXE)
	set(BASH_EXE bash CACHE INTERNAL "")
	dk_warning("BASH_EXE is not found. BASH_EXE set to 'bash'")
endif()

#if(NOT EXISTS ${BASH_EXE})
#	dk_error("BASH_EXE is not found")
#endif()
