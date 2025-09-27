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


############ sh ############
# https://www.gnu.org/software/sh
# https://packages.msys2.org/package/sh

if(EXISTS "${sh_exe}")
	dk_return()
endif()

#dk_validate(Target_Tuple "dk_Target_Tuple()")

### shell command sh ###
execute_process(COMMAND command -v sh OUTPUT_VARIABLE SHELL_SH)
if(EXISTS ${SHELL_SH})
	dk_printVar(SHELL_SH)
	dk_set(sh_exe "${SHELL_SH}")
	dk_printVar(sh_exe)
endif()

### environment variable sh ###
if(DEFINED ENV{SH})
	if(EXISTS "$ENV{SH}")
		dk_printVar(ENV{SH})
		if(NOT sh_exe)
			dk_set(sh_exe "$ENV{SH}")
			dk_printVar(sh_exe)
		endif()
	endif()
endif()

### Msys2 sh ###
#if(MSYSTEM)
	dk_depend(msys2)
	dk_findProgram(msys2_sh_exe sh "${msys2}/usr/bin")
	if(EXISTS "${msys2_sh_exe}")
		dk_debug("msys2_sh_exe = ${msys2_sh_exe}")
		if(NOT sh_exe)
			dk_set(sh_exe ${msys2_sh_exe})
			dk_debug("sh_exe = ${sh_exe}")
		endif()
	endif()
#endif()


## We should be able to find sh while inside a WSL instance
## Using sh outside of WSL will cause problems
### WSL sh ###
#dk_findProgram(WSL_sh_exe sh.exe "$ENV{SystemDrive}/Windows/System32")
#if(EXISTS "${WSL_sh_exe}")
#	dk_printVar(WSL_sh_exe)
#	if(NOT sh_exe)
#		dk_set(sh_exe ${WSL_sh_exe})
#		dk_printVar(sh_exe)
#	endif()
#endif()


### Git sh ###
dk_depend(git)
dk_findProgram(GIT_sh_exe sh "${git}/bin")
if(EXISTS "${GIT_sh_exe}")
	dk_printVar(GIT_sh_exe)
	if(NOT sh_exe)
		dk_set(sh_exe ${GIT_sh_exe})
		dk_printVar(sh_exe)
	endif()
endif()


if(NOT sh_exe)
	dk_installPackage(sh)
endif()

if(NOT sh_exe)
	set(sh_exe sh CACHE INTERNAL "")
	dk_warning("sh_exe is not found. setting sh_exe to 'sh'")
endif()



#execute_process(COMMAND sh -c "command -v 'sh'" OUTPUT_VARIABLE sh_exe OUTPUT_STRIP_TRAILING_WHITESPACE)