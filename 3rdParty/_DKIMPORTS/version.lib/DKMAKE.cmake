# https://learn.microsoft.com/en-us/windows/win32/api/winver/nf-winver-getfileversioninfoa
if(NOT WIN)
	dk_undepend(version.lib)
	dk_return()
endif()

dk_findLibrary(version.lib)


# MSYS2 (-lversion)
if(MSYSTEM)
	dk_set(VERSION_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lversion")
endif()