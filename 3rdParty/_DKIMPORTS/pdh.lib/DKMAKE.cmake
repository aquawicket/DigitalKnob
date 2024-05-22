if(NOT WIN)
	dk_undepend(pdh.lib)
	dk_return()
endif()

dk_findLibrary(pdh.lib)



# MSYS2 (-lpdh)
if(MSYSTEM)
	dk_set(PDH_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lpdh")
endif()