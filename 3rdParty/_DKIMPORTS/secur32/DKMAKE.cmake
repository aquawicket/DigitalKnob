# Secur32

if(NOT WIN)
	dk_undepend(secur32)
	dk_return()
endif()

dk_findLibrary(Secur32.Lib)



# MSYS2 (-lsecur32)
if(MSYSTEM)
	dk_set(SETUPAPI_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lsecur32")
endif()