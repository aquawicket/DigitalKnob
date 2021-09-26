# Information
# https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=msvc-160
# https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild?view=vs-2019
# https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild-command-line-reference?view=vs-2019
# https://docs.microsoft.com/en-us/visualstudio/msbuild/common-msbuild-project-properties?view=vs-2019
#
# Downloads
# https://download.visualstudio.microsoft.com/download/pr/5e397ebe-38b2-4e18-a187-ac313d07332a/169156e6e9a005d49b357c42240184dc1e3ccc28ebc777e70d49257c074f77e8/vs_Community.exe

### DEPENDS ###
if(ANDROID)
	DKDEPEND(jdk)
	DKDEPEND(apache-ant)
	DKDEPEND(android-sdk)
endif()
 
### VERSION ###
DKSET(VISUALSTUDIO_BUILD 16)
DKSET(VISUALSTUDIO_VERSION 2019)
DKSET(VISUALSTUDIO_NAME "Visual Studio ${VISUALSTUDIO_BUILD} ${VISUALSTUDIO_VERSION}")
DKSET(VISUALSTUDIO_DL https://download.visualstudio.microsoft.com/download/pr/5e397ebe-38b2-4e18-a187-ac313d07332a/169156e6e9a005d49b357c42240184dc1e3ccc28ebc777e70d49257c074f77e8/vs_Community.exe)
DKSET(VISUALSTUDIO "C:/Program Files (x86)/Microsoft Visual Studio/${VISUALSTUDIO_VERSION}/Community")
DKSET(MSBUILD "${VISUALSTUDIO}/MSBuild/Current/Bin/MSBuild.exe")

DKSET(GENERATOR "Visual Studio 16 ${VISUALSTUDIO_VERSION}")


### INSTALL ###
IF(NOT EXISTS "${VISUALSTUDIO}")
	MESSAGE(STATUS "Installing Visual Studio ${VISUALSTUDIO_VERSION}")
	DKSETPATH(${DIGITALKNOB}/Download)
	DOWNLOAD(${VISUALSTUDIO_DL})
	DKCOMMAND(${DIGITALKNOB}/Download/vs_Community.exe)
ENDIF()
