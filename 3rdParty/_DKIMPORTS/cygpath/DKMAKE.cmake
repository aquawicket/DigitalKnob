include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
################### TODO


if(EXISTS ${CYGPATH_EXE})
	dk_return()
endif()




dk_validate(HOST_TRIPLE "dk_getHostTriple()")
if(NOT WIN_HOST)
	dk_undepend(cygpath)
	dk_return()
endif()


dk_validate(MSYS2 "dk_depend(msys2)")
dk_findProgram(CYGPATH_EXE cygpath "${MSYS2}/usr/bin")

	
dk_assert(CYGPATH_EXE)  # change to assertPath