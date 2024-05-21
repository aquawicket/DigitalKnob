# https://learn.microsoft.com/en-us/windows/win32/api/iphlpapi/nf-iphlpapi-getadaptersinfo
if(NOT WIN)
	dk_undepend(iphlpapi)
	dk_return()
endif()

dk_findLibrary(Iphlpapi.lib)


# MSYS2 (-lIphlpapi)
if(MSYSTEM)
	dk_set(WINMM_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lIphlpapi")
endif()