if(NOT CMAKE_HOST_WIN32)
	return()
endif()
# Information
# https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=msvc-160
# https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild?view=vs-2019
# MSBuild command-line reference  https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild-command-line-reference?view=vs-2019
# Common MSBuild project properties  https://docs.microsoft.com/en-us/visualstudio/msbuild/common-msbuild-project-properties?view=vs-2019
# CMake Visual Studio 17 2022  https://cmake.org/cmake/help/v3.21/generator/Visual%20Studio%2017%202022.html
# Create an Android Native Activity App  https://docs.microsoft.com/en-us/cpp/cross-platform/create-an-android-native-activity-app?view=msvc-160
#
# Downloads
# VS2019  https://aka.ms/vs/16/release/vs_community.exe
# VS2022  https://aka.ms/vs/17/release/vs_community.exe


### DEPENDS ###
if(ANDROID)
	DKDEPEND(jdk)
	DKDEPEND(apache-ant)
	DKDEPEND(android-sdk)
endif()
 
### VERSION ###
DKSET(VISUALSTUDIO_BUILD 17)
DKSET(VISUALSTUDIO_VERSION 2022)
DKSET(VISUALSTUDIO_PROGRAM_FILES "Program Files")
DKSET(VISUALSTUDIO_DL https://aka.ms/vs/${VISUALSTUDIO_BUILD}/release/vs_community.exe)
DKSET(VISUALSTUDIO_16 "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community")
DKSET(VISUALSTUDIO "C:/${VISUALSTUDIO_PROGRAM_FILES}/Microsoft Visual Studio/${VISUALSTUDIO_VERSION}/Community")
DKSET(MSBUILD "${VISUALSTUDIO}/MSBuild/Current/Bin/MSBuild.exe")
DKSET(VS_GENERATOR "Visual Studio ${VISUALSTUDIO_BUILD} ${VISUALSTUDIO_VERSION}")



### INSTALL ###
IF(NOT EXISTS "${VISUALSTUDIO}" AND NOT EXISTS "${VISUALSTUDIO_16}")
	MESSAGE(STATUS "Installing Visual Studio ${VISUALSTUDIO_VERSION}")
	if(EXISTS ${DKDOWNLOAD}/VisualStudio/vs_setup.exe)
		# offline installer
		DKCOMMAND(${3RDPARTY}/_DKIMPORTS/visualstudio/InstallVisualStudio.cmd)
	else()
		# online installer
		DOWNLOAD(${VISUALSTUDIO_DL} ${DKDOWNLOAD}/vs_Community.exe)
		DKCOMMAND(${DKDOWNLOAD}/vs_Community.exe)
	endif()
ENDIF()
