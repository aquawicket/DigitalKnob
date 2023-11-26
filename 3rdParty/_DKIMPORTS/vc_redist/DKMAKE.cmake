# https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-160#visual-studio-2015-2017-2019-and-2022
#
# https://aka.ms/vs/16/release/vc_redist.x86.exe
# https://softmany.com/microsoft-visual-c-redistributable-package/download/
#
# VCRUNTIME140.dll

if(NOT WIN_HOST)
	dk_undepend(vc_redist)
	dk_return()
endif()
if(VISUALSTUDIO)
	#dk_undepend(vc_redist)
	#dk_return()
endif()


dk_set(VC_REDIST_VERSION 14.29.30133)
dk_set(VC_REDIST_PLATFORM x86)
dk_set(VC_REDIST_NAME vc_redist.${VC_REDIST_PLATFORM})
dk_set(VC_REDIST_DL https://aka.ms/vs/16/release/${VC_REDIST_NAME}.exe)
#dk_set(VC_REDIST "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Redist/MSVC/${VC_REDIST_VERSION}")
dk_set(VC_REDIST "C:/Windows/System32/vcruntime140.dll")

### INSTALL ###
IF(NOT EXISTS "${VC_REDIST}")
	MESSAGE(STATUS "Installing Visual Studio ${VC_REDIST_VERSION} ${VC_REDIST_PLATFORM} Redistributable")
	dk_download(${VC_REDIST_DL} ${DKDOWNLOAD}/${VC_REDIST_NAME}.exe)
	dk_command(${DKDOWNLOAD}/${VC_REDIST_NAME}.exe)
ENDIF()
