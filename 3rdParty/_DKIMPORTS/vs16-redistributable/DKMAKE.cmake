# https://docs.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-160#visual-studio-2015-2017-2019-and-2022
#
# https://aka.ms/vs/16/release/vc_redist.x86.exe
# https://softmany.com/microsoft-visual-c-redistributable-package/download/

### VERSION ###
DKSET(VS16REDIST_VERSION 14.29.30133)
DKSET(VS16REDIST_PLATFORM x86)
DKSET(VS16REDIST_NAME vc_redist.${VS16REDIST_PLATFORM}.exe)
DKSET(VS16REDIST_DL https://aka.ms/vs/16/release/${VS16REDIST_NAME})
DKSET(VS16REDIST "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Redist/MSVC/${VS16REDIST_VERSION}")

### INSTALL ###
IF(NOT EXISTS "${VS16REDIST}")
	MESSAGE(STATUS "Installing Visual Studio ${VS16REDIST_VERSION} ${VS16REDIST_PLATFORM} Redistributable")
	DOWNLOAD(${VS16REDIST_DL} ${DKDOWNLOAD}/${VS16REDIST_NAME})
	DKCOMMAND(${DKDOWNLOAD}/${VS16REDIST_NAME})
ENDIF()
