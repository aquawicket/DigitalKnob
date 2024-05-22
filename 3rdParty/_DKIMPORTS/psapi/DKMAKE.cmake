# https://learn.microsoft.com/en-us/windows/win32/psapi/psapi-functions

if(NOT WIN)
	dk_undepend(psapi)
	dk_return()
endif()

dk_findLibrary(Psapi.lib)



# MSYS2 (-lPsapi)
if(MSYSTEM)
	dk_set(PSAPI_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lPsapi")
endif()