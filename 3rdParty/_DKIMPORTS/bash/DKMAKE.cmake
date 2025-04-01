#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ bash ############
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

#if(EXISTS "${BASH_EXE}")
#	dk_undepend(bash)
#	dk_return()
#endif()

dk_validate(target_triple "dk_target_triple()")

### shell command bash ###
execute_process(COMMAND command -v bash OUTPUT_VARIABLE SHELL_BASH)
if(EXISTS ${SHELL_BASH})
	dk_printVar(SHELL_BASH)
	dk_set(BASH_EXE "${SHELL_BASH}")
	dk_printVar(BASH_EXE)
endif()

### environment variable bash ###
if(DEFINED ENV{BASH})
	if(EXISTS "$ENV{BASH}")
		dk_printVar(ENV{BASH})
		if(NOT BASH_EXE)
			dk_set(BASH_EXE "$ENV{BASH}")
			dk_printVar(BASH_EXE)
		endif()
	endif()
endif()

### Msys2 bash ###
if(MSYSTEM)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_findProgram(MSYS2_BASH_EXE bash "${MSYS2_DIR}/usr/bin")
	if(EXISTS "${MSYS2_BASH_EXE}")
		dk_printVar(MSYS2_BASH_EXE)
		if(NOT BASH_EXE)
			dk_set(BASH_EXE ${MSYS2_BASH_EXE})
			dk_printVar(BASH_EXE)
		endif()
	endif()
endif()


## We should be able to find bash while inside a WSL instance
## Using bash outside of WSL will cause problems
### WSL bash ###
#dk_findProgram(WSL_BASH_EXE bash.exe "C:/Windows/System32")
#if(EXISTS "${WSL_BASH_EXE}")
#	dk_printVar(WSL_BASH_EXE)
#	if(NOT BASH_EXE)
#		dk_set(BASH_EXE ${WSL_BASH_EXE})
#		dk_printVar(BASH_EXE)
#	endif()
#endif()


### Git bash ###
#dk_depend(git)
dk_findProgram(GIT_BASH_EXE bash.exe "${GIT}/bin")
if(EXISTS "${GIT_BASH_EXE}")
	dk_printVar(GIT_BASH_EXE)
	if(NOT BASH_EXE)
		dk_set(BASH_EXE ${GIT_BASH_EXE})
		dk_printVar(BASH_EXE)
	endif()
endif()


if(NOT BASH_EXE)
	dk_installPackage(bash)
endif()

if(NOT BASH_EXE)
	set(BASH_EXE bash CACHE INTERNAL "")
	dk_warning("BASH_EXE is not found. setting BASH_EXE to 'bash'")
endif()
