# https://docs.microsoft.com/en-us/windows/win32/winsock/creating-a-basic-winsock-application

if(NOT WIN)
	dk_undepend(ws2_32)
	dk_return()
endif()

dk_findLibrary(ws2_32.lib)


# MSYS2 (-lws2_32)
if(MSYSTEM)
	dk_set(WS2_32_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lws2_32")
endif()