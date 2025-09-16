#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ iphlpapi ############
# https://learn.microsoft.com/en-us/windows/win32/api/iphlpapi/nf-iphlpapi-getadaptersinfo
dk_validate(Target_Tuple "dk_Target_Tuple()")
if(NOT Windows)
	dk_disable(iphlpapi)
	dk_return()
endif()

dk_findLibrary(Iphlpapi.lib)

# MSYS2 (-lIphlpapi)
if(MSYSTEM)
	dk_set(IPHLPAPI_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-lIphlpapi")
endif()
