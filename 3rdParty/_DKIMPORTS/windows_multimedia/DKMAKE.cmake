# https://docs.microsoft.com/en-us/windows/win32/multimedia/windows-multimedia-start-page?redirectedfrom=MSDN

if(WIN)
	DKDEFINE(__WINDOWS_MM__)
	WIN_LIB(winmm.lib)
endif()
