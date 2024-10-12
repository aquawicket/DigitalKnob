#!/usr/bin/cmake -P
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




### Default bash ###
dk_findProgram(BASH_EXE bash.exe "C:/Windows/System32")
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
