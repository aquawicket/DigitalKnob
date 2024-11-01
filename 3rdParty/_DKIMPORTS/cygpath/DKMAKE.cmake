#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ cygpath ############
#dk_load(dk_builder)
#if(NOT WIN_HOST)
#	dk_undepend(cygpath)
#	dk_return()
#endif()

if(EXISTS "${CYGPATH_EXE}")
	dk_return()
endif()

###### CYGPATH_EXE ######
dk_printVar(CYGPATH_EXE)
dk_pause()
dk_printVar(DKSHELL)
if(NOT EXISTS "${CYGPATH_EXE}")
	dk_validate(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
	dk_depend(msys2)
	dk_debug("Looking in ${MSYS2_DIR}/usr/bin/cygpath.exe")
	set(CYGPATH_EXE "${MSYS2_DIR}/usr/bin/cygpath.exe")
	dk_pause()
endif()

if(NOT EXISTS "${CYGPATH_EXE}")
	dk_depend(msys2)
	dk_findProgram(CYGPATH_EXE cygpath.exe "${MSYS2_DIR}/usr/bin")
	dk_pause()
endif()
if(NOT EXISTS "${CYGPATH_EXE}")
	dk_depend(git)
	dk_findProgram(CYGPATH_EXE cygpath.exe "${GIT_DIR_}/../../../")
	dk_pause()
endif()
dk_pause()
if(NOT EXISTS "${CYGPATH_EXE}")
	dk_findProgram(CYGPATH_EXE cygpath)
endif()
if(NOT EXISTS "${CYGPATH_EXE}")
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v cygpath" OUTPUT_VARIABLE CYGPATH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()
if(NOT EXISTS "${CYGPATH_EXE}")
	dk_warning("CYGPATH_EXE:${CYGPATH_EXE} not found")
else()
	dk_set(CYGPATH_EXE "${CYGPATH_EXE}")		# Globalize the variable
	dk_printVar(CYGPATH_EXE)
	set(ENV{CYGPATH_EXE} "${CYGPATH_EXE}")		# Set Environment Varible
	dk_printVar(ENV{CYGPATH_EXE})
endif()
	
	
dk_assertPath("${CYGPATH_EXE}")
