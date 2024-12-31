#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### visual-cpp-build-tools ######
dk_validate(host_triple "dk_host_triple()")
#if(NOT WIN_HOST)
#	dk_undepend(visual-cpp-build-tools)
#	dk_return()
#endif()


### VERSION ###
dk_set(VS_BUILDTOOLS_VERSION 	17)
dk_set(VS_BUILDTOOLS_DL 		"https://aka.ms/vs/17/release/vs_BuildTools.exe")
dk_set(VS		 				"C:/Program Files (x86)/Microsoft Visual Studio")
#dk_assertPath(VS_BUILDTOOLS)

# C:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools/VC/Tools/MSVC
macro(vs_buildtools_year result)
	file(GLOB children RELATIVE "${VS}" "${VS}/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${VS}/${child}")
			if(EXISTS "${VS}/${child}/BuildTools")
				set(${result} ${child})
				dk_printVar(${result})
			endif()
		endif()
	endforeach()
	if(NOT ${result})
		dk_warning("vs_buildtools_year() Could not locate year.")
	endif()
	dk_printVar(${result})
endmacro()


macro(vs_buildtools_edition result)
	file(GLOB children RELATIVE "${VS_BUILDTOOLS}/VC/Tools/MSVC" "${VS_BUILDTOOLS}/VC/Tools/MSVC/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${VS_BUILDTOOLS}/VC/Tools/MSVC/${child}")
			if(EXISTS "${VS_BUILDTOOLS}/VC/Tools/MSVC/${child}/bin/Hostx86")
				set(${result} ${child})
				dk_printVar(${result})
			endif()
		endif()
	endforeach()
	if(NOT ${result})
		dk_fatal("get_vs_buildtools_edition() Could not locate edition.")
	endif()
	dk_printVar(${result})
endmacro()

###### INSTALL Visual Studio ######
vs_buildtools_year(VS_BUILDTOOLS_YEAR)
dk_assertVar(VS_BUILDTOOLS_YEAR)
if(NOT VS_BUILDTOOLS_YEAR)
	dk_info("Installing Visual Studio BuildTools . . .")
	dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
	dk_download(${VS_BUILDTOOLS_DL} ${DKDOWNLOAD_DIR}/vs_BuildTools.exe)	# online installer
	dk_command(${DKDOWNLOAD_DIR}/vs_BuildTools.exe)
else()
	dk_info("Visual Studio ${VS_BUILDTOOLS_VERSION} ${VS_BUILDTOOLS_YEAR} already installed")
endif()

###### set VS_BUILDTOOLS variables ######
vs_buildtools_year(VS_BUILDTOOLS_YEAR)
dk_set(VS_BUILDTOOLS 							"${VS}/${VS_BUILDTOOLS_YEAR}/BuildTools")
vs_buildtools_edition(VS_BUILDTOOLS_EDITION)

dk_set(VS_BUILDTOOLS_GENERATOR 					"Visual Studio ${VS_BUILDTOOLS_VERSION} ${VS_BUILDTOOLS_YEAR}")
dk_set(VS_BUILDTOOLS_MAKE_PROGRAM				"${VS_BUILDTOOLS}/MSBuild/Current/Bin/amd64/MSBuild.exe")
dk_set(VS_BUILDTOOLS_MAKE_VCVARSALL				"${VS_BUILDTOOLS}/VC/Auxiliary/Build/vcvarsall.bat")

dk_set(VS_BUILDTOOLS_ARM64_GENERATOR_PLATFORM	ARM64)

dk_set(VS_BUILDTOOLS_X86_GENERATOR_PLATFORM		Win32)
dk_set(VS_BUILDTOOLS_X86_NMAKE 					"${VS_BUILDTOOLS}/VC/Tools/MSVC/${VS_BUILDTOOLS_EDITION}/bin/Hostx64/x86/nmake.exe")
dk_set(VS_BUILDTOOLS_X86_COMPILER 				"${VS_BUILDTOOLS}/VC/Tools/MSVC/${VS_BUILDTOOLS_EDITION}/bin/Hostx64/x86/cl.exe")
dk_set(VS_BUILDTOOLS_X86_LINKER 				"${VS_BUILDTOOLS}/VC/Tools/MSVC/${VS_BUILDTOOLS_EDITION}/bin/Hostx64/x86/link.exe")
dk_set(VS_BUILDTOOLS_X86_DUMPBIN 				"${VS_BUILDTOOLS}/VC/Tools/MSVC/${VS_BUILDTOOLS_EDITION}/bin/Hostx86/x86/dumpbin.exe")

dk_set(VS_BUILDTOOLS_X64_GENERATOR_PLATFORM		x64)
dk_set(VS_BUILDTOOLS_X64_NMAKE 					"${VS_BUILDTOOLS}/VC/Tools/MSVC/${VS_BUILDTOOLS_EDITION}/bin/Hostx64/x64/nmake.exe")
dk_set(VS_BUILDTOOLS_X64_COMPILER 				"${VS_BUILDTOOLS}/VC/Tools/MSVC/${VS_BUILDTOOLS_EDITION}/bin/Hostx64/x64/cl.exe")
dk_set(VS_BUILDTOOLS_X64_LINKER 				"${VS_BUILDTOOLS}/VC/Tools/MSVC/${VS_BUILDTOOLS_EDITION}/bin/Hostx64/x64/link.exe")
dk_set(VS_BUILDTOOLS_X64_DUMPBIN 				"${VS_BUILDTOOLS}/VC/Tools/MSVC/${VS_BUILDTOOLS_EDITION}/bin/Hostx86/x64/dumpbin.exe")



###### Patch Android Files ######
if(ANDROID)	
	if(EXISTS "${VS_BUILDTOOLS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets")
		dk_info("Patching Android.Common.targets. . .")
		dk_fileReplace("${VS_BUILDTOOLS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">ARM7</GradlePlatform>" "></GradlePlatform>")
		dk_fileReplace("${VS_BUILDTOOLS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">ARM8</GradlePlatform>" "></GradlePlatform>")
		dk_fileReplace("${VS_BUILDTOOLS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">x86-64</GradlePlatform>" "></GradlePlatform>")
	else()
		dk_fatal("${VS_BUILDTOOLS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets does not exist!")
	endif()
endif()
