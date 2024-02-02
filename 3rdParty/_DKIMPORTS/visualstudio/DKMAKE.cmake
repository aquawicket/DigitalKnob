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
	dk_undepend(visualstudio)
	dk_return()
endif()


### VERSION ###
dk_set(VISUALSTUDIO_BUILD 				17)
dk_set(VISUALSTUDIO_YEAR 				2022)
dk_set(VISUALSTUDIO_VERSION 			14.36.32532)
dk_set(VISUALSTUDIO_DL 					"https://aka.ms/vs/${VISUALSTUDIO_BUILD}/release/vs_community.exe")
dk_set(VISUALSTUDIO 					"${ProgramFiles}/Microsoft Visual Studio/${VISUALSTUDIO_YEAR}/Community")
dk_set(VISUALSTUDIO_GENERATOR 			"Visual Studio ${VISUALSTUDIO_BUILD} ${VISUALSTUDIO_YEAR}")
dk_set(VISUALSTUDIO_X86_C_COMPILER 		"${VISUALSTUDIO}/VC/Tools/MSVC/${VISUALSTUDIO_VERSION}/bin/Hostx64/x86/cl.exe")
dk_set(VISUALSTUDIO_X86_CXX_COMPILER 	"${VISUALSTUDIO}/VC/Tools/MSVC/${VISUALSTUDIO_VERSION}/bin/Hostx64/x86/cl.exe")
dk_set(VISUALSTUDIO_X64_C_COMPILER 		"${VISUALSTUDIO}/VC/Tools/MSVC/${VISUALSTUDIO_VERSION}/bin/Hostx64/x64/cl.exe")
dk_set(VISUALSTUDIO_X64_CXX_COMPILER 	"${VISUALSTUDIO}/VC/Tools/MSVC/${VISUALSTUDIO_VERSION}/bin/Hostx64/x64/cl.exe")
dk_set(VISUALSTUDIO_X86_LINKER 			"${VISUALSTUDIO}/VC/Tools/MSVC/${VISUALSTUDIO_VERSION}/bin/Hostx64/x86/link.exe")
dk_set(VISUALSTUDIO_X64_LINKER 			"${VISUALSTUDIO}/VC/Tools/MSVC/${VISUALSTUDIO_VERSION}/bin/Hostx64/x64/link.exe")
dk_set(VISUALSTUDIO_X86_DUMPBIN 		"${VISUALSTUDIO}/VC/Tools/MSVC/${VISUALSTUDIO_VERSION}/bin/Hostx86/x86/dumpbin.exe")
dk_set(VISUALSTUDIO_X64_DUMPBIN 		"${VISUALSTUDIO}/VC/Tools/MSVC/${VISUALSTUDIO_VERSION}/bin/Hostx86/x64/dumpbin.exe")
dk_set(VISUALSTUDIO_MAKE_PROGRAM		"${VISUALSTUDIO}/MSBuild/Current/Bin/amd64/MSBuild.exe")

if(EXISTS ${VISUALSTUDIO})
	dk_info("Visual Studio ${VISUALSTUDIO_BUILD} ${VISUALSTUDIO_YEAR} already installed")
elseif(EXISTS "${ProgramFiles_x86}/Microsoft Visual Studio/2019/Community") #fall back to older version
	dk_set(VISUALSTUDIO "${ProgramFiles_x86}/Microsoft Visual Studio/2019/Community")
	dk_set(MSBUILD "${VISUALSTUDIO}/MSBuild/Current/Bin/MSBuild.exe")
	dk_set(VS_GENERATOR "Visual Studio 16 2019")
else()  #install
	dk_info("Installing Visual Studio ${VISUALSTUDIO_YEAR}")
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
	if(NOT EXISTS "${ProgramFiles}/Microsoft Visual Studio/2022/Community/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets")
		dk_error("${ProgramFiles}/Microsoft Visual Studio/2022/Community/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets does not exist!")
	else()
		dk_info("Patching Android.Common.targets. . .")
		dkFileReplace("${ProgramFiles}/Microsoft Visual Studio/2022/Community/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">ARM7</GradlePlatform>" "></GradlePlatform>")
		dkFileReplace("${ProgramFiles}/Microsoft Visual Studio/2022/Community/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">ARM8</GradlePlatform>" "></GradlePlatform>")
		dkFileReplace("${ProgramFiles}/Microsoft Visual Studio/2022/Community/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">x86-64</GradlePlatform>" "></GradlePlatform>")
	endif()
endif()
