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


###### vc_redist ######
# https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-160#visual-studio-2015-2017-2019-and-2022
# https://aka.ms/vs/16/release/vc_redist.x86.exe
# https://softmany.com/microsoft-visual-c-redistributable-package/download/
#
dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT Windows_Host)
	dk_disable(vc_redist)
	dk_return()
endif()


###### 32Bit ######
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_set(VCCOMP140_X86_DLL "$ENV{SystemDrive}/Windows/SysWOW64/vcomp140.dll")
dk_set(VCCOMP140_X86_DEBUG_DLL "$ENV{SystemDrive}/Windows/SysWOW64/vcomp140d.dll")
dk_set(VCRUNTIME140_X86_DLL "$ENV{SystemDrive}/Windows/SysWOW64/vcruntime140.dll")
dk_set(VCRUNTIME140_X86_DEBUG_DLL "$ENV{SystemDrive}/Windows/SysWOW64/vcruntime140d.dll")
### INSTALL ###
if((NOT EXISTS "${VCCOMP140_X86_DLL}") AND (NOT EXISTS "${VCCOMP140_X86_DEBUG_DLL}"))
	dk_basename(${vc_redist_Windows_X86_Import} vc_redist_Windows_X86_Import_FILE)
	dk_info("Installing Visual C Redistributable - ${vc_redist_Windows_X86_Import_FILE}")
	dk_download(${vc_redist_Windows_X86_Import})
	dk_exec(${dk_download} /install /quiet /norestart)
endif()


###### 64Bit ######
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_set(VCCOMP140_X86_64_DLL "$ENV{SystemDrive}/Windows/System32/vcomp140.dll")
dk_set(VCCOMP140_X86_64_DEBUG_DLL "$ENV{SystemDrive}/Windows/System32/vcomp140d.dll")
dk_set(VCRUNTIME140_X86_64_DLL "$ENV{SystemDrive}/Windows/System32/vcruntime140.dll")
dk_set(VCRUNTIME140_X86_64_DEBUG_DLL "$ENV{SystemDrive}/Windows/System32/vcruntime140d.dll")
### INSTALL ###
if((NOT EXISTS "${VCCOMP140_X86_64_DLL}") AND (NOT EXISTS "${VCCOMP140_X86_64_DEBUG_DLL}"))
	dk_basename(${vc_redist_Windows_X86_64_Import} vc_redist_Windows_X86_64_Import_FILE)
	dk_info("Installing Visual C Redistributable - ${vc_redist_Windows_X86_64_Import_FILE}")
	dk_download(${vc_redist_Windows_X86_64_Import})
	dk_exec(${dk_download} /install /quiet /norestart)
endif()

