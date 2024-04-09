# https://docs.microsoft.com/en-us/windows/win32/multimedia/windows-multimedia-start-page?redirectedfrom=MSDN

if(NOT WIN)
	dk_undepend(winmm.lib)
	dk_return()
endif()

dk_define(__WINDOWS_MM__)
dk_findLibrary(winmm.lib)

# MSYS2 (-lWinmm)
#"-DCMAKE_EXE_LINKER_FLAGS=-lWinmm"
