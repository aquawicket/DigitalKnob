# https://learn.microsoft.com/en-us/windows/win32/api/setupapi

if(NOT WIN)
	dk_undepend(setupapi.lib)
	dk_return()
endif()

dk_findLibrary(Setupapi.lib)

# MSYS2 (-lsetupapi)
#"-DCMAKE_EXE_LINKER_FLAGS=-lsetupapi"
