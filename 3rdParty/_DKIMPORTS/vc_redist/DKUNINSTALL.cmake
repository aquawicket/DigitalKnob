#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


###### vc_redist ######
# https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-160#visual-studio-2015-2017-2019-and-2022
# https://aka.ms/vs/16/release/vc_redist.x86.exe
# https://softmany.com/microsoft-visual-c-redistributable-package/download/


if(NOT Windows_Host)
	dk_disable(vc_redist)
	dk_return()
endif()

###### 32Bit ######
#dk_set(VCCOMP140_X86_DLL "$ENV{SystemDrive}/Windows/SysWOW64/vcomp140.dll")
#dk_set(VCCOMP140_X86_DEBUG_DLL "$ENV{SystemDrive}/Windows/SysWOW64/vcomp140d.dll")
#dk_set(VCRUNTIME140_X86_DLL "$ENV{SystemDrive}/Windows/SysWOW64/vcruntime140.dll")
#dk_set(VCRUNTIME140_X86_DEBUG_DLL "$ENV{SystemDrive}/Windows/SysWOW64/vcruntime140d.dll")
#if((EXISTS "${VCCOMP140_X86_DLL}") OR (EXISTS "${VCCOMP140_X86_DEBUG_DLL}"))
	dk_basename(${vc_redist_X86_Import} vc_redist_X86_Import_Basename)
	dk_info("Uninstalling Visual C++ Redistributable - ${vc_redist_X86_Import_Basename}")
	dk_download(${vc_redist_X86_Import})
	dk_exec("${dk_download}" /uninstall /quiet /norestart)
#endif()


###### 64Bit ######
#dk_fileVariables("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_set(VCCOMP140_X86_64_DLL "$ENV{SystemDrive}/Windows/System32/vcomp140.dll")
#dk_set(VCCOMP140_X86_64_DEBUG_DLL "$ENV{SystemDrive}/Windows/System32/vcomp140d.dll")
#dk_set(VCRUNTIME140_X86_64_DLL "$ENV{SystemDrive}/Windows/System32/vcruntime140.dll")
#dk_set(VCRUNTIME140_X86_64_DEBUG_DLL "$ENV{SystemDrive}/Windows/System32/vcruntime140d.dll")
#if((EXISTS "${VCCOMP140_X86_64_DLL}") OR (EXISTS "${VCCOMP140_X86_64_DEBUG_DLL}"))
	dk_basename(${vc_redist_X86_64_Import} vc_redist_X86_64_Import_Basename)
	dk_info("Uninstalling Visual C Redistributable - ${vc_redist_X86_64_Import_Basename}")
	dk_download(${vc_redist_X86_64_Import})
	dk_exec("${dk_download}" /uninstall /quiet /norestart)
#endif()
