# vccorlib

if(NOT WIN)
	dk_undepend(vccorlib)
	dk_return()
endif()

dk_findLibrary(vccorlib.lib)



# MSYS2 (-lvccorlib)
if(MSYSTEM)
	dk_set(VCCORLIB_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lvccorlib")
endif()
