include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
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

dk_validate(HOST_TRIPLE     "dk_HOST_TRIPLE()")
if(NOT WIN_HOST)
	dk_undepend(visualstudio)
	dk_return()
endif()
dk_validate(TARGET_TRIPLE "dk_TARGET_TRIPLE()")


### VERSION ###
dk_set(VISUALSTUDIO_VERSION 	17)
dk_set(VISUALSTUDIO_DL 			"https://aka.ms/vs/${VISUALSTUDIO_VERSION}/release/vs_community.exe")
dk_set(VISUALSTUDIO 			"${ProgramFiles}/Microsoft Visual Studio")
dk_printVar(VISUALSTUDIO)

macro(get_visualstudio_year result)
	file(GLOB children RELATIVE "${VISUALSTUDIO}" "${VISUALSTUDIO}/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${VISUALSTUDIO}/${child}")
			if(EXISTS "${VISUALSTUDIO}/${child}/Community")
				set(${result} ${child})
				dk_printVar(${result})
			endif()
		endif()
	endforeach()
	if(NOT ${result})
		dk_fatal("get_visualstudio_year() Could not locate year.")
	endif()
endmacro()

macro(get_visualstudio_edition result)
	file(GLOB children RELATIVE "${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC" "${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC/${child}")
			if(EXISTS "${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC/${child}/bin/Hostx86")
				set(${result} ${child})
				dk_printVar(${result})
			endif()
		endif()
	endforeach()
	if(NOT ${result})
		dk_fatal("get_visualstudio_edition() Could not locate edition.")
	endif()
endmacro()

###### INSTALL Visual Studio ######	
if(NOT EXISTS ${VISUALSTUDIO})
	dk_info("Installing Visual Studio . . .")
	if(EXISTS ${DKDOWNLOAD_DIR}/VisualStudio/vs_setup.exe)
		dk_command(${DK3RDPARTY_DIR}/_DKIMPORTS/visualstudio/InstallVisualStudio.cmd)	# offline installer
	else()
		dk_download(${VISUALSTUDIO_DL} ${DKDOWNLOAD_DIR}/vs_Community.exe)				# online installer
		dk_command(${DKDOWNLOAD_DIR}/vs_Community.exe)
	endif()
else()
	dk_info("Visual Studio ${VISUALSTUDIO_VERSION} ${VISUALSTUDIO_YEAR} already installed")
endif()

###### set VISUALSTUDIO variables ######
get_visualstudio_year(VISUALSTUDIO_YEAR)
dk_set(VISUALSTUDIO_COMMUNITY 				"${VISUALSTUDIO}/${VISUALSTUDIO_YEAR}/Community")
get_visualstudio_edition(VISUALSTUDIO_EDITION)
dk_set(VISUALSTUDIO_GENERATOR 				"Visual Studio ${VISUALSTUDIO_VERSION} ${VISUALSTUDIO_YEAR}")
dk_set(VISUALSTUDIO_MAKE_PROGRAM			"${VISUALSTUDIO_COMMUNITY}/MSBuild/Current/Bin/amd64/MSBuild.exe")
dk_set(VISUALSTUDIO_X86_COMPILER 			"${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC/${VISUALSTUDIO_EDITION}/bin/Hostx64/x86/cl.exe")
dk_set(VISUALSTUDIO_X64_COMPILER 			"${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC/${VISUALSTUDIO_EDITION}/bin/Hostx64/x64/cl.exe")
dk_set(VISUALSTUDIO_X86_LINKER 				"${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC/${VISUALSTUDIO_EDITION}/bin/Hostx64/x86/link.exe")
dk_set(VISUALSTUDIO_X64_LINKER 				"${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC/${VISUALSTUDIO_EDITION}/bin/Hostx64/x64/link.exe")
dk_set(VISUALSTUDIO_X86_DUMPBIN 			"${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC/${VISUALSTUDIO_EDITION}/bin/Hostx86/x86/dumpbin.exe")
dk_set(VISUALSTUDIO_X64_DUMPBIN 			"${VISUALSTUDIO_COMMUNITY}/VC/Tools/MSVC/${VISUALSTUDIO_EDITION}/bin/Hostx86/x64/dumpbin.exe")
if(ARM64)
	dk_set(VISUALSTUDIO_GENERATOR_PLATFORM	ARM64)
elseif(X86)
	dk_set(VISUALSTUDIO_GENERATOR_PLATFORM	Win32)
	dk_set(VISUALSTUDIO_C_COMPILER			"${VISUALSTUDIO_X86_COMPILER}")
	dk_set(VISUALSTUDIO_CXX_COMPILER		"${VISUALSTUDIO_X86_COMPILER}")
	dk_set(VISUALSTUDIO_LINKER				"${VISUALSTUDIO_X86_LINKER}")
	dk_set(VISUALSTUDIO_DUMPBIN				"${VISUALSTUDIO_X86_DUMPBIN}")
elseif(X86_64)
	dk_set(VISUALSTUDIO_GENERATOR_PLATFORM	x64)
	dk_set(VISUALSTUDIO_C_COMPILER			"${VISUALSTUDIO_X64_COMPILER}")
	dk_set(VISUALSTUDIO_CXX_COMPILER		"${VISUALSTUDIO_X64_COMPILER}")
	dk_set(VISUALSTUDIO_LINKER				"${VISUALSTUDIO_X64_LINKER}")
	dk_set(VISUALSTUDIO_DUMPBIN				"${VISUALSTUDIO_X64_DUMPBIN}")
else()
	dk_fatal("Could not determin TARGET_ARCH to set VISUALSTUDIO variables")
endif()

###### Patch Android Files ######
if(ANDROID)	
	if(EXISTS "${VISUALSTUDIO_COMMUNITY}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets")
		dk_info("Patching Android.Common.targets. . .")
		dk_fileReplace("${VISUALSTUDIO_COMMUNITY}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">ARM7</GradlePlatform>" "></GradlePlatform>")
		dk_fileReplace("${VISUALSTUDIO_COMMUNITY}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">ARM8</GradlePlatform>" "></GradlePlatform>")
		dk_fileReplace("${VISUALSTUDIO_COMMUNITY}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">x86-64</GradlePlatform>" "></GradlePlatform>")
	else()
		dk_fatal("${VISUALSTUDIO_COMMUNITY}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets does not exist!")
	endif()
endif()




###### set GLOBAL CMAKE VARIABLES ######
dk_set(CMAKE_C_COMPILER				${VISUALSTUDIO_C_COMPILER})
dk_set(CMAKE_CXX_COMPILER			${VISUALSTUDIO_CXX_COMPILER})
dk_set(CMAKE_DUMPBIN				${VISUALSTUDIO_DUMPBIN})
dk_set(CMAKE_GENERATOR				${VISUALSTUDIO_GENERATOR})
dk_set(CMAKE_GENERATOR_PLATFORM		${VISUALSTUDIO_GENERATOR_PLATFORM})
dk_set(CMAKE_LINKER					${VISUALSTUDIO_LINKER})
dk_set(CMAKE_MAKE_PROGRAM 			${VISUALSTUDIO_MAKE_PROGRAM})
