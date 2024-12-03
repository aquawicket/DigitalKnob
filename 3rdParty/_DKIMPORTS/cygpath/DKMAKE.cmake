#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ cygpath ############
if(NOT WIN_HOST)
	dk_undepend(cygpath)
	dk_return()
endif()

if(EXISTS "${CYGPATH_EXE}")
	dk_return()
endif()

###### GET CYGPATH_EXE ######
if(NOT EXISTS "${CYGPATH_EXE}")
	dk_depend(msys2)
	dk_findProgram(CYGPATH_EXE cygpath.exe "${MSYS2_DIR}/usr/bin")
endif()

if(NOT EXISTS "${CYGPATH_EXE}")
	dk_depend(git)
	dk_findProgram(CYGPATH_EXE cygpath.exe "${GIT}/usr/bin")
endif()

#if(NOT EXISTS "${CYGPATH_EXE}")
#	dk_depend(git)
#	dk_findProgram(CYGPATH_EXE cygpath.exe "${GIT_DIR_}/../../../")
#endif()
if(NOT EXISTS "${CYGPATH_EXE}")
	dk_findProgram(CYGPATH_EXE cygpath)
endif()
#if(NOT EXISTS "${CYGPATH_EXE}")
#	dk_printVar(DKSHELL)
#	execute_process(COMMAND $ENV{DKSHELL} -c "command -v cygpath" OUTPUT_VARIABLE CYGPATH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
#endif()

####### CHECK CYGPATH_EXE ######
if(EXISTS "${CYGPATH_EXE}")
	dk_set(CYGPATH_EXE "${CYGPATH_EXE}")
else()
	dk_fatal("CYGPATH_EXE:${CYGPATH_EXE} not found")
endif()
