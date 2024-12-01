#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ sh ############
# https://www.gnu.org/software/sh
# https://packages.msys2.org/package/sh

#if(EXISTS "${SH_EXE}")
#	dk_undepend(sh)
#	dk_return()
#endif()

dk_validate(triple "dk_target_triple()")

### shell command sh ###
execute_process(COMMAND command -v sh OUTPUT_VARIABLE SHELL_SH)
if(EXISTS ${SHELL_SH})
	dk_printVar(SHELL_SH)
	dk_set(SH_EXE "${SHELL_SH}")
	dk_printVar(SH_EXE)
endif()

### environment variable sh ###
if(DEFINED ENV{SH})
	if(EXISTS "$ENV{SH}")
		dk_printVar(ENV{SH})
		if(NOT SH_EXE)
			dk_set(SH_EXE "$ENV{SH}")
			dk_printVar(SH_EXE)
		endif()
	endif()
endif()

### Msys2 sh ###
if(MSYSTEM)
	dk_depend(msys2)
	dk_findProgram(MSYS2_SH_EXE sh "${MSYS2_DIR}/usr/bin")
	if(EXISTS "${MSYS2_SH_EXE}")
		dk_printVar(MSYS2_SH_EXE)
		if(NOT SH_EXE)
			dk_set(SH_EXE ${MSYS2_SH_EXE})
			dk_printVar(SH_EXE)
		endif()
	endif()
endif()


## We should be able to find sh while inside a WSL instance
## Using sh outside of WSL will cause problems
### WSL sh ###
#dk_findProgram(WSL_SH_EXE sh.exe "C:/Windows/System32")
#if(EXISTS "${WSL_SH_EXE}")
#	dk_printVar(WSL_SH_EXE)
#	if(NOT SH_EXE)
#		dk_set(SH_EXE ${WSL_SH_EXE})
#		dk_printVar(SH_EXE)
#	endif()
#endif()


### Git sh ###
dk_depend(git)
dk_findProgram(GIT_SH_EXE sh "${GIT}/bin")
if(EXISTS "${GIT_SH_EXE}")
	dk_printVar(GIT_SH_EXE)
	if(NOT SH_EXE)
		dk_set(SH_EXE ${GIT_SH_EXE})
		dk_printVar(SH_EXE)
	endif()
endif()


if(NOT SH_EXE)
	dk_installPackage(sh)
endif()

if(NOT SH_EXE)
	set(SH_EXE sh CACHE INTERNAL "")
	dk_warning("SH_EXE is not found. setting SH_EXE to 'sh'")
endif()
