include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://learn.microsoft.com/en-us/windows/win32/api/userenv/

if(NOT WIN)
	dk_undepend(userenv)
	dk_return()
endif()

dk_findLibrary(Userenv.lib)



# MSYS2 (-lUserenv)
if(MSYSTEM)
	dk_set(USERENV_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lUserenv")
endif()