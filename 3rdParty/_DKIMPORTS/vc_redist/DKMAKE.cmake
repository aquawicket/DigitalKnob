#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)

# https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-160#visual-studio-2015-2017-2019-and-2022
# https://aka.ms/vs/16/release/vc_redist.x86.exe
# https://softmany.com/microsoft-visual-c-redistributable-package/download/
#
# VCRUNTIME140.dll


if(NOT WIN_HOST)
	dk_undepend(vc_redist)
	dk_return()
endif()
#if(VISUALSTUDIO)
	#dk_undepend(vc_redist)
	#dk_return()
#endif()

WIN_X86_HOST_dk_set		(VC_REDIST_DL https://aka.ms/vs/16/release/vc_redist.x86.exe)
WIN_X86_64_HOST_dk_set	(VC_REDIST_DL https://aka.ms/vs/16/release/vc_redist.x64.exe)
if(NOT VC_REDIST_DL)
	dk_fatal("VC_REDIST_DL is invalid")
	return()
endif()

WIN_X86_HOST_dk_set		(VCCOMP140_DLL "C:/Windows/SysWOW64/vcomp140.dll")
WIN_X86_64_HOST_dk_set	(VCCOMP140_DLL "C:/Windows/System32/vcomp140.dll")
if(NOT VCCOMP140_DLL)
	dk_fatal("VCCOMP140_DLL is invalid")
	return()
endif()

### INSTALL ###
if(NOT EXISTS "${VCCOMP140_DLL}")
	dk_basename(${VC_REDIST_DL} VC_REDIST_DL_FILE)
	dk_info("Installing Visual C Redistributable - ${VC_REDIST_DL_FILE}")
	dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
	dk_download(${VC_REDIST_DL} ${DKDOWNLOAD_DIR}/${VC_REDIST_DL_FILE})
	#dk_validate(DK3RDPARTY_DIR "dk_DKBRANCH_DIR()")
	dk_command(${DKDOWNLOAD_DIR}/${VC_REDIST_DL_FILE} /install /quiet /norestart) #/log ${DK3RDPARTY_DIR}/vc_redist_install_log.txt
endif()


if(NOT EXISTS "${VCCOMP140_DLL}")
	dk_fatal("Unable to locate VCCOMP140_DLL:${VCCOMP140_DLL}")
endif()
