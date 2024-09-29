#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://learn.microsoft.com/en-us/windows/win32/api/iphlpapi/nf-iphlpapi-getadaptersinfo
if(NOT WIN)
	dk_undepend(iphlpapi)
	dk_return()
endif()

dk_findLibrary(Iphlpapi.lib)


# MSYS2 (-lIphlpapi)
if(MSYSTEM)
	dk_set(IPHLPAPI_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lIphlpapi")
endif()