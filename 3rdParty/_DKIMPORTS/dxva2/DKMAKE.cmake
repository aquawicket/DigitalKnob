include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://learn.microsoft.com/en-us/windows/win32/medfound/about-dxva-2-0
# https://dll.website/dxva2-dll

if(NOT WIN)
	dk_undepend(dxva2)
	dk_return()
endif()

dk_findLibrary(Dxva2.dll)
