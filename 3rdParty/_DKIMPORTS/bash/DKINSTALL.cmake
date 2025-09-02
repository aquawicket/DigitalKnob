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


############ bash ############
# https://www.gnu.org/software/bash/
# https://packages.msys2.org/package/bash

#	HOST		SHELL		BASH	Target_Os
#	Android		termux		bash	Android
#	linux		tinycore	bash	Android, Linux
#	Linux		ubuntu		bash	Android, Linux
#	Mac     	osx			bash	Mac, Ios, Iossim
#	Raspbery	pi			bash	Raspbery
#	Windows 	clang32    	bash	Windows
#	Windows 	clang64 	bash	Windows
#	Windows 	clangarm64 	bash	Windows
#	Windows 	git     	bash	Android, Windows
#	Windows 	mingw32 	bash	Windows
#	Windows 	mingw64 	bash	Windows
#	Windows 	msys2  		bash	Android, Windows
#	Windows 	ucrt64		bash	Windows
#	Windows 	wsl_debian	bash	Linux
#	Windows 	wsl_ubuntu	bash	Linux

#if(EXISTS "${BASH_EXE}")
#	dk_undepend(bash)
#	dk_return()
#endif()

#dk_validate(Target_Tuple "dk_Target_Tuple()")

### shell command bash ###
#execute_process(COMMAND command -v bash OUTPUT_VARIABLE SHELL_BASH)
#if(EXISTS ${SHELL_BASH})
#	dk_printVar(SHELL_BASH)
#	dk_set(BASH_EXE "${SHELL_BASH}")
#	dk_printVar(BASH_EXE)
#endif()

### environment variable bash ###
#if(DEFINED ENV{BASH})
#	if(EXISTS "$ENV{BASH}")
#		dk_printVar(ENV{BASH})
#		if(NOT BASH_EXE)
#			dk_set(BASH_EXE "$ENV{BASH}")
#			dk_printVar(BASH_EXE)
#		endif()
#	endif()
#endif()

### Msys2 bash ###
#if(MSYSTEM)
#	dk_validate(MSYS2 "dk_depend(msys2)")
#	dk_findProgram(MSYS2_BASH_EXE bash.exe "${msys2}/usr/bin")
#	if(EXISTS "${msys2_BASH_EXE}")
#		dk_printVar(MSYS2_BASH_EXE)
#		if(NOT BASH_EXE)
#			dk_set(BASH_EXE ${msys2_BASH_EXE})
#			dk_printVar(BASH_EXE)
#		endif()
#	endif()
#endif()


## We should be able to find bash while inside a WSL instance
## Using bash outside of WSL will cause problems
### WSL bash ###
#dk_findProgram(WSL_BASH_EXE bash.exe "$ENV{SystemDrive}/Windows/System32")
#if(EXISTS "${WSL_BASH_EXE}")
#	dk_printVar(WSL_BASH_EXE)
#	if(NOT BASH_EXE)
#		dk_set(BASH_EXE ${WSL_BASH_EXE})
#		dk_printVar(BASH_EXE)
#	endif()
#endif()


### Git bash ###
dk_printVar(GIT)
dk_depend(git)
dk_printVar(GIT)
dk_assertVar(GIT)
dk_findProgram(GIT_BASH_EXE bash.exe "${GIT}/bin")
if(EXISTS "${GIT_BASH_EXE}")
	dk_printVar(GIT_BASH_EXE)
	if(NOT BASH_EXE)
		dk_set(BASH_EXE ${GIT_BASH_EXE})
		dk_printVar(BASH_EXE)
	endif()
endif()


#if(NOT BASH_EXE)
#	dk_installPackage(bash)
#endif()

#if(NOT BASH_EXE)
#	dk_set(BASH_EXE bash)
#	dk_warning("BASH_EXE is not found. setting BASH_EXE to 'bash'")
#endif()


#execute_process(COMMAND bash -c "command -v 'bash'" OUTPUT_VARIABLE BASH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)