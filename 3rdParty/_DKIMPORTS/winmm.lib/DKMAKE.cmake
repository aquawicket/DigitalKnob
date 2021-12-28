if(NOT WIN_HOST)
	return()
endif()

# https://docs.microsoft.com/en-us/windows/win32/multimedia/windows-multimedia-start-page?redirectedfrom=MSDN

DKDEFINE(__WINDOWS_MM__)
WIN_DKLIB(winmm.lib)
