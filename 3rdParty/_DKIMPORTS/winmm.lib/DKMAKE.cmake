# https://docs.microsoft.com/en-us/windows/win32/multimedia/windows-multimedia-start-page?redirectedfrom=MSDN
if(NOT WIN_HOST)
	return()
endif()


DKDEFINE(__WINDOWS_MM__)
WIN_DKLIB(winmm.lib)
