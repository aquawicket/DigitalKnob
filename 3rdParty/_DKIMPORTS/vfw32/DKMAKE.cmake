# vfw32

if(NOT WIN)
	dk_undepend(vfw32)
	dk_return()
endif()

dk_findLibrary(vfw32.lib)



# MSYS2 (-lvfw32)
if(MSYSTEM)
	dk_set(VFW32_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=--lvfw32")
endif()