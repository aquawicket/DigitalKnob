# https://docs.microsoft.com/en-us/windows/win32/multimedia/windows-multimedia-start-page?redirectedfrom=MSDN
if(NOT WIN_HOST)
	return()
endif()

find_library(winmm_LIBRARY winmm.lib)
if(NOT winmm_LIBRARY)
	dk_assert("Could not locate winmm libraries") 
endif()
dk_info(winmm_LIBRARY)

#WIN_dk_lib(winmm.lib)
dk_lib(${winmm_LIBRARY})

dk_define(__WINDOWS_MM__)
