#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ iphlpapi ############
# https://learn.microsoft.com/en-us/windows/win32/api/iphlpapi/nf-iphlpapi-getadaptersinfo
dk_load(dk_builder)
if(NOT WIN)
	dk_undepend(iphlpapi)
	dk_return()
endif()

dk_findLibrary(Iphlpapi.lib)

# MSYS2 (-lIphlpapi)
if(MSYSTEM)
	dk_set(IPHLPAPI_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lIphlpapi")
endif()
