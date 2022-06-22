# https://docs.microsoft.com/en-us/windows/win32/multimedia/windows-multimedia-start-page?redirectedfrom=MSDN

if(NOT WIN_HOST)
	return()
endif()


WIN_dk_lib(winmm.lib)
dk_define(__WINDOWS_MM__)
