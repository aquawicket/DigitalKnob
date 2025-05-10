#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### vc_redist ######
# https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-160#visual-studio-2015-2017-2019-and-2022
# https://aka.ms/vs/16/release/vc_redist.x86.exe
# https://softmany.com/microsoft-visual-c-redistributable-package/download/
#
dk_validate(Host_Tuple "dk_Host_Tuple()")
if(NOT WIN_HOST)
	dk_undepend(vc_redist)
	dk_return()
endif()


###### 32Bit ######
dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/vc_redist/dkconfig.txt")
dk_set(VCCOMP140_X86_DLL "$ENV{SystemDrive}/Windows/SysWOW64/vcomp140.dll")
dk_set(VCCOMP140_X86_DEBUG_DLL "$ENV{SystemDrive}/Windows/SysWOW64/vcomp140d.dll")
dk_set(VCRUNTIME140_X86_DLL "$ENV{SystemDrive}/Windows/SysWOW64/vcruntime140.dll")
dk_set(VCRUNTIME140_X86_DEBUG_DLL "$ENV{SystemDrive}/Windows/SysWOW64/vcruntime140d.dll")
### INSTALL ###
if((NOT EXISTS "${VCCOMP140_X86_DLL}") AND (NOT EXISTS "${VCCOMP140_X86_DEBUG_DLL}"))
	dk_basename(${VC_REDIST_X86_IMPORT} VC_REDIST_X86_IMPORT_FILE)
	dk_info("Installing Visual C Redistributable - ${VC_REDIST_X86_IMPORT_FILE}")
	dk_download(${VC_REDIST_X86_IMPORT})
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	dk_command($ENV{DKDOWNLOAD_DIR}/${VC_REDIST_X86_IMPORT_FILE} /install /quiet /norestart)
endif()


###### 64Bit ######
dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/vc_redist/dkconfig.txt")
dk_set(VCCOMP140_X86_64_DLL "$ENV{SystemDrive}/Windows/System32/vcomp140.dll")
dk_set(VCCOMP140_X86_64_DEBUG_DLL "$ENV{SystemDrive}/Windows/System32/vcomp140d.dll")
dk_set(VCRUNTIME140_X86_64_DLL "$ENV{SystemDrive}/Windows/System32/vcruntime140.dll")
dk_set(VCRUNTIME140_X86_64_DEBUG_DLL "$ENV{SystemDrive}/Windows/System32/vcruntime140d.dll")
### INSTALL ###
if((NOT EXISTS "${VCCOMP140_X86_64_DLL}") AND (NOT EXISTS "${VCCOMP140_X86_64_DEBUG_DLL}"))
	dk_basename(${VC_REDIST_X86_64_IMPORT} VC_REDIST_X86_64_IMPORT_FILE)
	dk_info("Installing Visual C Redistributable - ${VC_REDIST_X86_64_IMPORT_FILE}")
	dk_download(${VC_REDIST_X86_64_IMPORT})
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	dk_command($ENV{DKDOWNLOAD_DIR}/${VC_REDIST_X86_64_IMPORT_FILE} /install /quiet /norestart)
endif()

