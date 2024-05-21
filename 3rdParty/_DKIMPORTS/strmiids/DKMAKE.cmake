# strmiids

if(NOT WIN)
	dk_undepend(strmiids)
	dk_return()
endif()

dk_findLibrary(strmiids.lib)



# MSYS2 (-lstrmiids)
if(MSYSTEM)
	dk_set(VERSION_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lstrmiids")
endif()