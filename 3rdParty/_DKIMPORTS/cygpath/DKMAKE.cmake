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

dk_depend(msys2)
dk_findProgram(CYGPATH_EXE cygpath "${MSYS2_DIR}/usr/bin")

dk_assertPath("${CYGPATH_EXE}")
