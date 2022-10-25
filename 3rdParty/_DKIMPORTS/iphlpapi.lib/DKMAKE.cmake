# https://learn.microsoft.com/en-us/windows/win32/api/iphlpapi/nf-iphlpapi-getadaptersinfo
if(NOT WIN)
	return()
endif()

dk_findLibrary(Iphlpapi.lib)
