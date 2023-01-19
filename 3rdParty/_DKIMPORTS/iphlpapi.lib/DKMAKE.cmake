# https://learn.microsoft.com/en-us/windows/win32/api/iphlpapi/nf-iphlpapi-getadaptersinfo
if(NOT WIN)
	dk_return()
endif()

dk_findLibrary(Iphlpapi.lib)
