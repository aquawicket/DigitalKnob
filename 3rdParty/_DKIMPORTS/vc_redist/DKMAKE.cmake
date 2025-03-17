#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")




# https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-160#visual-studio-2015-2017-2019-and-2022
# https://aka.ms/vs/16/release/vc_redist.x86.exe
# https://softmany.com/microsoft-visual-c-redistributable-package/download/
#
# VCRUNTIME140.dll

dk_validate(host_triple "dk_host_triple()")
if(NOT WIN_HOST)
	dk_undepend(vc_redist)
	dk_return()
endif()


### 32Bit ###
dk_set(VC_REDIST_X86_DL https://aka.ms/vs/16/release/vc_redist.x86.exe)
dk_set(VCCOMP140_X86_DLL "C:/Windows/SysWOW64/vcomp140.dll")
dk_set(VCCOMP140_X86_DEBUG_DLL "C:/Windows/SysWOW64/vcomp140d.dll")
dk_set(VCRUNTIME140_X86_DLL "C:/Windows/SysWOW64/vcruntime140.dll")
dk_set(VCRUNTIME140_X86_DEBUG_DLL "C:/Windows/SysWOW64/vcruntime140d.dll")
### INSTALL ###
if((NOT EXISTS "${VCCOMP140_X86_DLL}") AND (NOT EXISTS "${VCCOMP140_X86_DEBUG_DLL}"))
	dk_basename(${VC_REDIST_X86_DL} VC_REDIST_X86_DL_FILE)
	dk_info("Installing Visual C Redistributable - ${VC_REDIST_X86_DL_FILE}")
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	dk_download(${VC_REDIST_X86_DL} $ENV{DKDOWNLOAD_DIR}/${VC_REDIST_X86_DL_FILE})
	dk_command($ENV{DKDOWNLOAD_DIR}/${VC_REDIST_X86_DL_FILE} /install /quiet /norestart) #/log ${DK3RDPARTY_DIR}/vc_redist_install_log.txt
endif()
#dk_assertPath(VCCOMP140_X86_DLL)


### 64Bit ###
dk_set(VC_REDIST_X86_64_DL https://aka.ms/vs/16/release/vc_redist.x64.exe)
dk_set(VCCOMP140_X86_64_DLL "C:/Windows/System32/vcomp140.dll")
dk_set(VCCOMP140_X86_64_DEBUG_DLL "C:/Windows/System32/vcomp140d.dll")
dk_set(VCRUNTIME140_X86_64_DLL "C:/Windows/System32/vcruntime140.dll")
dk_set(VCRUNTIME140_X86_64_DEBUG_DLL "C:/Windows/System32/vcruntime140d.dll")
### INSTALL ###
if((NOT EXISTS "${VCCOMP140_X86_64_DLL}") AND (NOT EXISTS "${VCCOMP140_X86_64_DEBUG_DLL}"))
	dk_basename(${VC_REDIST_X86_64_DL} VC_REDIST_X86_64_DL_FILE)
	dk_info("Installing Visual C Redistributable - ${VC_REDIST_X86_64_DL_FILE}")
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	dk_download(${VC_REDIST_X86_64_DL} $ENV{DKDOWNLOAD_DIR}/${VC_REDIST_X86_64_DL_FILE})
	dk_command($ENV{DKDOWNLOAD_DIR}/${VC_REDIST_X86_64_DL_FILE} /install /quiet /norestart) #/log ${DK3RDPARTY_DIR}/vc_redist_install_log.txt
endif()
#dk_assertPath(VCCOMP140_X86_64_DLL)

