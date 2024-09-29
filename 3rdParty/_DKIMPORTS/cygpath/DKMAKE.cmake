#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#dk_load(dk_builder)
################### TODO


if(EXISTS "${CYGPATH_EXE}")
	dk_return()
endif()

#if(NOT WIN_HOST)
#	dk_undepend(cygpath)
#	dk_return()
#endif()


dk_depend(msys2)
dk_findProgram(CYGPATH_EXE cygpath "${MSYS2_DIR}/usr/bin")

	
dk_assertPath("${CYGPATH_EXE}")
