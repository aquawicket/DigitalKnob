if(NOT CMAKE_HOST_WIN32)
	return()
endif()

# https://docs.microsoft.com/en-us/windows/win32/multimedia/windows-multimedia-start-page?redirectedfrom=MSDN

DKDEFINE(__WINDOWS_MM__)
WIN_LIB(winmm.lib)
