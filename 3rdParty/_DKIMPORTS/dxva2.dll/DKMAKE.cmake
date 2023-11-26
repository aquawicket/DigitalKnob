# https://dll.website/dxva2-dll

if(NOT WIN)
	dk_undepend(dxva2.dll)
	dk_return()
endif()

dk_findLibrary(Dxva2.dll)
