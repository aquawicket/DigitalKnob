# https://learn.microsoft.com/en-us/windows/win32/api/winver/nf-winver-getfileversioninfoa
if(NOT WIN)
	return()
endif()

dk_findLibrary(version.lib)
