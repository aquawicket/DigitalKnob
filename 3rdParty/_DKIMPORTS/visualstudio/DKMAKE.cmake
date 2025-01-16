#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ visualstudio ############
# Microsoft Visual Studio Comunity
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

dk_validate(host_triple "dk_host_triple()")
if(NOT WIN_HOST)
	dk_undepend(visualstudio)
	dk_return()
endif()


### VERSION ###
dk_set(VS_MAJOR 	17)
dk_set(VS_DL 		"https://aka.ms/vs/${VS_MAJOR}/release/vs_community.exe")
dk_set(VS 			"${ProgramFiles}/Microsoft Visual Studio")
dk_printVar(VS)

macro(vs_year result)
	file(GLOB children RELATIVE "${VS}" "${VS}/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${VS}/${child}")
			if(EXISTS "${VS}/${child}/Community")
				set(${result} ${child})
				dk_printVar(${result})
			endif()
		endif()
	endforeach()
	if(NOT ${result})
		dk_fatal("vs_year() Could not locate year.")
	endif()
endmacro()

macro(vs_version result)
	file(GLOB children RELATIVE "${VS}/VC/Tools/MSVC" "${VS}/VC/Tools/MSVC/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${VS}/VC/Tools/MSVC/${child}")
			if(EXISTS "${VS}/VC/Tools/MSVC/${child}/bin/Hostx86")
				set(${result} ${child})
				dk_printVar(${result})
			endif()
		endif()
	endforeach()
	if(NOT ${result})
		dk_fatal("vs_version() Could not locate version.")
	endif()
endmacro()

###### INSTALL Visual Studio ######	
if(NOT EXISTS ${VS})
	dk_info("Installing Visual Studio . . .")
	if(EXISTS ${DKDOWNLOAD_DIR}/VisualStudio/vs_setup.exe)
		dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
		dk_command(${DK3RDPARTY_DIR}/_DKIMPORTS/visualstudio/InstallVisualStudio.cmd)	# offline installer
	else()
		dk_download(${VS_DL} ${DKDOWNLOAD_DIR}/vs_Community.exe)						# online installer
		dk_command(${DKDOWNLOAD_DIR}/vs_Community.exe)
	endif()
else()
	dk_info("Visual Studio ${VS_MAJOR} ${VS_YEAR} already installed")
endif()

###### set VS variables ######
vs_year(VS_YEAR)
dk_set(VS 				"${VS}/${VS_YEAR}/Community")
VS_VERSION(VS_VERSION)
dk_set(VS_GENERATOR 				"Visual Studio ${VS_MAJOR} ${VS_YEAR}")
dk_set(VS_MAKE_PROGRAM				"${VS}/MSBuild/Current/Bin/amd64/MSBuild.exe")
dk_set(VS_X86_COMPILER 				"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx64/x86/cl.exe")
dk_set(VS_X64_COMPILER 				"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx64/x64/cl.exe")
dk_set(VS_X86_LINKER 				"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx64/x86/link.exe")
dk_set(VS_X64_LINKER 				"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx64/x64/link.exe")
dk_set(VS_X86_DUMPBIN 				"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx86/x86/dumpbin.exe")
dk_set(VS_X64_DUMPBIN 				"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx86/x64/dumpbin.exe")
if(ARM64)
	dk_set(VS_GENERATOR_PLATFORM	ARM64)
elseif(X86)
	dk_set(VS_GENERATOR_PLATFORM	Win32)
	dk_set(VS_C_COMPILER			"${VS_X86_COMPILER}")
	dk_set(VS_CXX_COMPILER			"${VS_X86_COMPILER}")
	dk_set(VS_LINKER				"${VS_X86_LINKER}")
	dk_set(VS_DUMPBIN				"${VS_X86_DUMPBIN}")
elseif(X86_64)
	dk_set(VS_GENERATOR_PLATFORM	x64)
	dk_set(VS_C_COMPILER			"${VS_X64_COMPILER}")
	dk_set(VS_CXX_COMPILER			"${VS_X64_COMPILER}")
	dk_set(VS_LINKER				"${VS_X64_LINKER}")
	dk_set(VS_DUMPBIN				"${VS_X64_DUMPBIN}")
else()
	dk_fatal("Could not determin TARGET_ARCH to set VS variables")
endif()

###### Patch Android Files ######
if(ANDROID)	
	if(EXISTS "${VS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets")
		dk_info("Patching Android.Common.targets. . .")
		dk_fileReplace("${VS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">ARM7</GradlePlatform>" "></GradlePlatform>")
		dk_fileReplace("${VS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">ARM8</GradlePlatform>" "></GradlePlatform>")
		dk_fileReplace("${VS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">x86-64</GradlePlatform>" "></GradlePlatform>")
	else()
		dk_fatal("${VS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets does not exist!")
	endif()
endif()




###### set GLOBAL CMAKE VARIABLES ######
if(NOT MSVC)
	dk_return()
endif()
dk_set(CMAKE_C_COMPILER				${VS_C_COMPILER})
dk_set(CMAKE_CXX_COMPILER			${VS_CXX_COMPILER})
dk_set(CMAKE_DUMPBIN				${VS_DUMPBIN})
dk_set(CMAKE_GENERATOR				${VS_GENERATOR})
dk_set(CMAKE_GENERATOR_PLATFORM		${VS_GENERATOR_PLATFORM})
dk_set(CMAKE_LINKER					${VS_LINKER})
dk_set(CMAKE_MAKE_PROGRAM 			${VS_MAKE_PROGRAM})
