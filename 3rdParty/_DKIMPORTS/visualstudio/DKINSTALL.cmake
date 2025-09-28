#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#if(NOT Windows_Host)
#	dk_disable(visualstudio)
#	dk_return()
#endif()

###### visualstudio ######
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_assertVar(visualstudio_Year)
dk_assertVar(visualstudio_Major)

dk_firewallAllow("$ENV{ProgramFiles\(x86\)}/Microsoft Visual Studio/Installer/setup.exe") #visualstudio setup.exe

#############################################################################################################
# C:/Program Files (x86)/Microsoft Visual Studio    /2022      /BuildTools    /VC/Tools/MSVC   /14.42.34433
# 				${visualstudio_Install_Path}               ${visualstudio_Year}     ${visualstudio_Flavor}					   ${visualstudio_Version}
#
# https://learn.microsoft.com/en-us/visualstudio/releases/2022/release-history

#dk_set(visualstudio_Install_Path	"$ENV{DKTOOLS_DIR}/VS")
#dk_set(visualstudio_Cache_Path		"$ENV{DKDOWNLOAD_DIR}/VS")
#dk_set(visualstudio_Year 			2022)												# 2019, 2022
#dk_set(visualstudio_Flavor			"BuildTools") 										# BuildTools, Community			
#dk_set(visualstudio_Major 			17)													# 17
#dk_set(visualstudio_Import 		"https://aka.ms/vs/17/release/vs_BuildTools.exe")




###### visualstudio_Install_Path ######
if(NOT visualstudio_Install_Path)
	set(visualstudio_Install_Path		"$ENV{ProgramFiles\(x86\)}/Microsoft Visual Studio")
else()
	set(visualstudio_Install_Flag		--path install=${visualstudio_Install_Path})
endif()

###### visualstudio_Cache_Path ######
if(NOT visualstudio_Cache_Path)
	#dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	#set(visualstudio_Cache_Path	"$ENV{DKDOWNLOAD_DIR}/VS")
	set(visualstudio_Cache_Path		"$ENV{ProgramFiles\(x86\)}/Microsoft Visual Studio/DL")
endif()
set(visualstudio_Cache_Flag			--path cache=${visualstudio_Cache_Path})		

###### visualstudio_Flavor ######
if(NOT visualstudio_Flavor)
	dk_set(visualstudio_Flavor 		"BuildTools")
endif()

###### visualstudio_Import ######
if(NOT visualstudio_Import)
	dk_set(visualstudio_Import 		"https://aka.ms/vs/${visualstudio_Major}/release/vs_${visualstudio_Flavor}.exe")
endif()

###### visualstudio_Year ######
macro(visualstudio_Year)
	file(GLOB children RELATIVE "${visualstudio_Install_Path}" "${visualstudio_Install_Path}/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${visualstudio_Install_Path}/${child}")
			if(EXISTS "${visualstudio_Install_Path}/${child}/${visualstudio_Flavor}")
				set(visualstudio_Year ${child})
				dk_printVar(${visualstudio_Year})
			endif()
		endif()
	endforeach()
	if(NOT ${visualstudio_Year})
		dk_warning("visualstudio_Year(): Could not locate year.")
		dk_set(visualstudio_Year "2022") # DEFAULT
	endif()
	dk_printVar(${visualstudio_Year})
endmacro()
if(NOT visualstudio_Year)
	visualstudio_Year()
endif()


macro(visualstudio_Version)
	file(GLOB children RELATIVE "${visualstudio_Install_Path}/VC/Tools/MSVC" "${visualstudio_Install_Path}/VC/Tools/MSVC/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${visualstudio_Install_Path}/VC/Tools/MSVC/${child}")
			if(EXISTS "${visualstudio_Install_Path}/VC/Tools/MSVC/${child}/bin/Hostx86")
				set(visualstudio_Version ${child})
				dk_printVar(${visualstudio_Version})
			endif()
		endif()
	endforeach()
	if(NOT ${visualstudio_Version})
		dk_warning("visualstudio_Version(): Could not locate version.")
		#dk_set(visualstudio_Version "14.42.34433") # DEFAULT
	endif()
	dk_printVar(${visualstudio_Version})
endmacro()
if(NOT visualstudio_Version)
	visualstudio_Version()
endif()

###### VS ######
dk_set(VS	"${visualstudio_Install_Path}/${visualstudio_Year}/${visualstudio_Flavor}")




###### INSTALL Visual Studio ######
if(NOT EXISTS "${VS}")
	dk_info("Installing Visual Studio ${visualstudio_Flavor} ${visualstudio_Year} ${visualstudio_Version}. . .")
	dk_download(${visualstudio_Import})
	#dk_download(${visualstudio_Import})
	
	# Visual Studio Installer Options
	# https://learn.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio?view=vs-2022
	#
	# --path install=<path> - the installation directory
	# --path cache=<path>	- location to download installation files
	# --cache				- packages will be kept after being installed
	# --passive				- Non interactive install
	# --norestart			- postpone system restart after install
	# --downloadThenInstall - Donwload packages before installing
	# --quiet				- Prevents any user interface from being displayed
	
	
	#execute_process(COMMAND cmd /c start /wait $ENV{DKDOWNLOAD_DIR}/${visualstudio_Import_File} ${visualstudio_Install_Flag} ${visualstudio_Cache_Flag} --cache --downloadThenInstall)
	execute_process(COMMAND ${dk_download} ${visualstudio_Install_Flag} ${visualstudio_Cache_Flag} --cache --downloadThenInstall TIMEOUT 1)

	### wait for vs_setup_bootstrapper.exe to exist in C:/windows/temp ###
	while(NOT vs_setup_bootstrapper_exe)
		dk_findProgram(vs_setup_bootstrapper_exe vs_setup_bootstrapper.exe "$ENV{windir}/Temp")
	endwhile()
	dk_printVar(vs_setup_bootstrapper_exe)
	dk_firewallAllow("${vs_setup_bootstrapper_exe}")
	
	while(NOT EXISTS "${visualstudio_setup_exe}")
		dk_findProgram(visualstudio_setup_exe setup.exe "$ENV{ProgramFiles\(x86\)}/Microsoft Visual Studio/Installer")
	endwhile()
	dk_printVar(visualstudio_setup_exe)
	dk_firewallAllow("${visualstudio_setup_exe}")

	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	while(NOT EXISTS "${visualstudio_Cache_Path}")
		dk_sleep(1)
	endwhile()
	dk_copy("${visualstudio_Cache_Path}" "$ENV{DKDOWNLOAD_DIR}/VS")
else()
	dk_info("Visual Studio ${visualstudio_Flavor} ${visualstudio_Major} ${visualstudio_Year} already installed")
endif()

###### set VS variables ######

dk_validate(visualstudio_Year 		"visualstudio_Year()")
dk_validate(visualstudio_Version 	"visualstudio_Version()")
dk_set(VS_GENERATOR 				"Visual Studio ${visualstudio_Major} ${visualstudio_Year}")
dk_set(VS_MAKE_PROGRAM				"${VS}/MSBuild/Current/Bin/amd64/MSBuild.exe")
dk_set(VS_MAKE_VCVARSALL			"${VS}/VC/Auxiliary/Build/vcvarsall.bat")

dk_set(VS_ARM64_GENERATOR_PLATFORM	ARM64)

dk_set(VS_X86_GENERATOR_PLATFORM	Win32)
dk_set(VS_X86_NMAKE 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/Hostx64/x86/nmake.exe")
dk_set(VS_X86_COMPILER 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/Hostx64/x86/cl.exe")
dk_set(VS_X86_LINKER 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/Hostx64/x86/link.exe")
dk_set(VS_X86_DUMPBIN 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/Hostx86/x86/dumpbin.exe")

dk_set(VS_X86_64_GENERATOR_PLATFORM	x64)
dk_set(VS_X86_64_NMAKE 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/Hostx64/x64/nmake.exe")
dk_set(VS_X86_64_COMPILER 			"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/Hostx64/x64/cl.exe")
dk_set(VS_X86_64_LINKER 			"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/Hostx64/x64/link.exe")
dk_set(VS_X86_64_DUMPBIN 			"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/Hostx86/x64/dumpbin.exe")



###### Patch Android Files ######
if(Android)	
	if(EXISTS "${VS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets")
		dk_info("Patching Android.Common.targets. . .")
		dk_fileReplace("${VS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">ARM7</GradlePlatform>" "></GradlePlatform>")
		dk_fileReplace("${VS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">ARM8</GradlePlatform>" "></GradlePlatform>")
		dk_fileReplace("${VS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets" ">x86-64</GradlePlatform>" "></GradlePlatform>")
	else()
		dk_fatal("${VS}/MSBuild/Microsoft/MDD/Android/V150/Android.Common.targets does not exist!")
	endif()
endif()
