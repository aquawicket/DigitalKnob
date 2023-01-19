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

if(NOT WIN_HOST)
	dk_return()
endif()


#ANDROID_dk_depend(ant)
#ANDROID_dk_depend(android-sdk)
 
### VERSION ###
dk_set(VISUALSTUDIO_BUILD 17)
dk_set(VISUALSTUDIO_VERSION 2022)
dk_set(VISUALSTUDIO_PROGRAM_FILES "Program Files")
dk_set(VISUALSTUDIO_DL https://aka.ms/vs/${VISUALSTUDIO_BUILD}/release/vs_community.exe)
dk_set(VISUALSTUDIO "C:/${VISUALSTUDIO_PROGRAM_FILES}/Microsoft Visual Studio/${VISUALSTUDIO_VERSION}/Community")
dk_set(MSBUILD "${VISUALSTUDIO}/MSBuild/Current/Bin/MSBuild.exe")
dk_set(DUMPBIN "${VISUALSTUDIO}/VC/Tools/MSVC/14.30.30705/bin/Hostx86/x86/dumpbin.exe")
dk_set(VS_GENERATOR "Visual Studio ${VISUALSTUDIO_BUILD} ${VISUALSTUDIO_VERSION}")

if(EXISTS ${VISUALSTUDIO})
	#already have newest version
elseif(EXISTS "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community") #fall back to older version
	dk_set(VISUALSTUDIO "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community")
	dk_set(MSBUILD "${VISUALSTUDIO}/MSBuild/Current/Bin/MSBuild.exe")
	dk_set(VS_GENERATOR "Visual Studio 16 2019")
else()  #install
	MESSAGE(STATUS "Installing Visual Studio ${VISUALSTUDIO_VERSION}")
	if(EXISTS ${DKDOWNLOAD}/VisualStudio/vs_setup.exe)
		# offline installer
		dk_command(${3RDPARTY}/_DKIMPORTS/visualstudio/InstallVisualStudio.cmd)
	else()
		# online installer
		dk_download(${VISUALSTUDIO_DL} ${DKDOWNLOAD}/vs_Community.exe)
		dk_command(${DKDOWNLOAD}/vs_Community.exe)
	endif()
ENDIF()

if(ANDROID)
	if(NOT EXISTS "C:/Program Files/Microsoft Visual Studio/2022/Community/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets")
		dk_error("C:/Program Files/Microsoft Visual Studio/2022/Community/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets does not exist!")
	else()
		dk_info("Patching Android.Common.targets. . .")
		dkFileReplace("C:/Program Files/Microsoft Visual Studio/2022/Community/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">ARM7</GradlePlatform>" "></GradlePlatform>")
		dkFileReplace("C:/Program Files/Microsoft Visual Studio/2022/Community/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">ARM8</GradlePlatform>" "></GradlePlatform>")
		dkFileReplace("C:/Program Files/Microsoft Visual Studio/2022/Community/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">x86-64</GradlePlatform>" "></GradlePlatform>")
	endif()
endif()
