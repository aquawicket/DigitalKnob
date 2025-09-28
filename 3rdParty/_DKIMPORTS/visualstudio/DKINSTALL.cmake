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
# https://learn.microsoft.com/en-us/answers/questions/192162/visual-studio-build-tools-silent-install
#

#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_unset(visualstudio_Install_Path)


dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
set(vs_setup_bootstrapper_exe "${DKDOWNLOAD_DIR}/vs_bootstrapper_d15/vs_setup_bootstrapper.exe")
dk_firewallAllow("${vs_setup_bootstrapper_exe}")
set(visualstudio_setup_exe "C:/Program Files \(x86\)/Microsoft Visual Studio/Installer/setup.exe")
dk_firewallAllow("${visualstudio_setup_exe}") 

#############################################################################################################
# C:/Program Files (x86)/Microsoft Visual Studio    /2022      /BuildTools    /VC/Tools/MSVC   /14.42.34433
# 				${visualstudio_Install_Path}               ${visualstudio_Year}     ${visualstudio_Flavor}					   ${visualstudio_Version}
#
# https://learn.microsoft.com/en-us/visualstudio/releases/2022/release-history

#dk_set(visualstudio_Install_Path	"C:/Program Files \(x86\)/Microsoft Visual Studio")
#dk_set(visualstudio_Cache_Path		"$ENV{DKDOWNLOAD_DIR}/VS")
#dk_set(visualstudio_Year 			2022)												# 2019, 2022
#dk_set(visualstudio_Flavor			"BuildTools") 										# BuildTools, Community			
#dk_set(visualstudio_Major 			17)													# 17
#dk_set(visualstudio_Import 		"https://aka.ms/vs/17/release/vs_BuildTools.exe")



###### visualstudio_Major ######
if(NOT visualstudio_Major)
	set(visualstudio_Major		17)
endif()
dk_debug("visualstudio_Major = ${visualstudio_Major}")


###### visualstudio_Install_Path ######
if(NOT visualstudio_Install_Path)
	set(visualstudio_Install_Path		"C:/Program Files \(x86\)/Microsoft Visual Studio")
endif()
dk_debug("visualstudio_Install_Path = ${visualstudio_Install_Path}")
set(visualstudio_Install_Flag		--path install=${visualstudio_Install_Path})


###### visualstudio_Cache_Path ######
if(NOT visualstudio_Cache_Path)
	#set(visualstudio_Cache_Path	"$ENV{DKDOWNLOAD_DIR}/VS")
	set(visualstudio_Cache_Path		"C:/Program Files \(x86\)/Microsoft Visual Studio/DL")
endif()
#dk_assertPath("${visualstudio_Cache_Path}")
dk_debug("visualstudio_Cache_Path = ${visualstudio_Cache_Path}")
set(visualstudio_Cache_Flag			--path cache=${visualstudio_Cache_Path})		


###### visualstudio_Year ######
macro(visualstudio_Year)
	file(GLOB children RELATIVE "${visualstudio_Install_Path}" "${visualstudio_Install_Path}/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${visualstudio_Install_Path}/${child}")
			#dk_isNumber("${child}")
			#if(dk_isNumber)
				set(visualstudio_Year ${child})
				break()
			#endif()
		endif()
	endforeach()
	if(NOT ${visualstudio_Year})
		dk_warning("visualstudio_Year(): Could not locate year. Defaulting to 2022")
		dk_set(visualstudio_Year "2022") # DEFAULT
	endif()
endmacro()
if(NOT visualstudio_Year)
	visualstudio_Year()
endif()
dk_debug("visualstudio_Year = ${visualstudio_Year}")
set(visualstudio_Year_Dir "${visualstudio_Install_Path}/${visualstudio_Year}")
dk_debug("visualstudio_Year_Dir = ${visualstudio_Year_Dir}")


###### visualstudio_Flavor ######
macro(visualstudio_Flavor)
	dk_assertPath("${visualstudio_Year_Dir}")
	file(GLOB children RELATIVE "${visualstudio_Year_Dir}" "${visualstudio_Year_Dir}/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${visualstudio_Year_Dir}/${child}")
			#if(child IN_LIST Flavors)
				set(visualstudio_Flavor ${child})
				break()
			#endif()
		endif()
	endforeach()
	if(NOT ${visualstudio_Flavor})
		dk_warning("visualstudio_Flavor(): Could not locate flavor. Defaulting to BuildTools")
		dk_set(visualstudio_Flavor "BuildTools") # DEFAULT
	endif()
endmacro()
if(NOT visualstudio_Flavor)
	visualstudio_Flavor()
endif()
dk_debug("visualstudio_Flavor = ${visualstudio_Flavor}")
set(visualstudio_Flavor_Dir "${visualstudio_Year_Dir}/${visualstudio_Flavor}")


###### visualstudio_Import ######
macro(visualstudio_Import)
	dk_set(visualstudio_Import 	"https://aka.ms/vs/${visualstudio_Major}/release/vs_${visualstudio_Flavor}.exe")
endmacro()
if(NOT visualstudio_Import)
	visualstudio_Import()
endif()
dk_debug("visualstudio_Import = ${visualstudio_Import}")


###### visualstudio_Version ######
macro(visualstudio_Version)
	dk_assertPath("${visualstudio_Flavor_Dir}/VC/Tools/MSVC")
	file(GLOB children RELATIVE "${visualstudio_Flavor_Dir}/VC/Tools/MSVC" "${visualstudio_Flavor_Dir}/VC/Tools/MSVC/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${visualstudio_Flavor_Dir}/VC/Tools/MSVC/${child}")
			#dk_isNumber("${child}")
			#if(dk_isNumber)
				set(visualstudio_Version ${child})
				break()
			#endif()
		endif()
	endforeach()
	if(NOT ${visualstudio_Version})
		dk_warning("visualstudio_Version(): Could not locate version. Defaulting to 14.44.35207")
		dk_set(visualstudio_Version "14.44.35207") # DEFAULT
	endif()
endmacro()
if(NOT visualstudio_Version)
	visualstudio_Version()
endif()
dk_debug("visualstudio_Version = ${visualstudio_Version}")


###### VS ######
dk_set(VS	"${visualstudio_Flavor_Dir}")




###### INSTALL Visual Studio ######
if(NOT EXISTS "${VS}")
	dk_info("Installing Visual Studio ${visualstudio_Flavor} ${visualstudio_Year} ${visualstudio_Version}. . .")
	dk_download(${visualstudio_Import})
	
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
	dk_validate(7za_exe "dk_depend(7z)")
	dk_delete("${DKDOWNLOAD_DIR}/vs_bootstrapper_d15")
	execute_process(COMMAND ${7za_exe} x ${dk_download} WORKING_DIRECTORY ${DKDOWNLOAD_DIR})
	execute_process(COMMAND ${vs_setup_bootstrapper_exe} ${visualstudio_Install_Flag} ${visualstudio_Cache_Flag} --cache --downloadThenInstall)

	#execute_process(COMMAND cmd /c start /wait $ENV{DKDOWNLOAD_DIR}/${visualstudio_Import_File} ${visualstudio_Install_Flag} ${visualstudio_Cache_Flag} --cache --downloadThenInstall)
	#execute_process(COMMAND ${dk_download} ${visualstudio_Install_Flag} ${visualstudio_Cache_Flag} --cache --downloadThenInstall TIMEOUT 1)

	while(NOT EXISTS "${visualstudio_Cache_Path}")
		dk_sleep(1)
	endwhile()
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	dk_copy("${visualstudio_Cache_Path}" "$ENV{DKDOWNLOAD_DIR}/VS")
else()
	dk_info("Visual Studio ${visualstudio_Flavor} ${visualstudio_Major} ${visualstudio_Year} already installed")
endif()

###### set VS variables ######
if("${Host_Arch}" STREQUAL "X86")
	set(VS_HOST "Hostx86")
elseif("${Host_Arch}" STREQUAL "X86_64")
	set(VS_HOST "Hostx64")
elseif("${Host_Arch}" STREQUAL "Arm32")
	set(VS_HOST "HostARM")	# NOTE: HostARM is probobly not available
elseif("${Host_Arch}" STREQUAL "Arm64")
	set(VS_HOST "HostARM64")
else()
	dk_error("unable to set VS_HOST")
endif()

dk_set(VS_GENERATOR 				"Visual Studio ${visualstudio_Major} ${visualstudio_Year}")
dk_set(VS_MAKE_PROGRAM				"${VS}/MSBuild/Current/Bin/amd64/MSBuild.exe")
dk_set(VS_MAKE_VCVARSALL			"${VS}/VC/Auxiliary/Build/vcvarsall.bat")

### Arm32 ###
dk_set(VS_ARM32_GENERATOR_PLATFORM	ARM)
dk_set(VS_ARM32_NMAKE 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/arm/nmake.exe")
dk_set(VS_ARM32_COMPILER 			"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/arm/cl.exe")
dk_set(VS_ARM32_LINKER 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/arm/link.exe")
dk_set(VS_ARM32_DUMPBIN 			"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/arm/dumpbin.exe")

### Arm64 ###
dk_set(VS_ARM64_GENERATOR_PLATFORM	ARM64)
dk_set(VS_ARM64_NMAKE 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/arm64/nmake.exe")
dk_set(VS_ARM64_COMPILER 			"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/arm64/cl.exe")
dk_set(VS_ARM64_LINKER 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/arm64/link.exe")
dk_set(VS_ARM64_DUMPBIN 			"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/arm64/dumpbin.exe")

### X86 ###
dk_set(VS_X86_GENERATOR_PLATFORM	Win32)
dk_set(VS_X86_NMAKE 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/x86/nmake.exe")
dk_set(VS_X86_COMPILER 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/x86/cl.exe")
dk_set(VS_X86_LINKER 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/x86/link.exe")
dk_set(VS_X86_DUMPBIN 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/x86/dumpbin.exe")

### X86_64 ###
dk_set(VS_X86_64_GENERATOR_PLATFORM	x64)
dk_set(VS_X86_64_NMAKE 				"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/x64/nmake.exe")
dk_set(VS_X86_64_COMPILER 			"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/x64/cl.exe")
dk_set(VS_X86_64_LINKER 			"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/x64/link.exe")
dk_set(VS_X86_64_DUMPBIN 			"${VS}/VC/Tools/MSVC/${visualstudio_Version}/bin/${VS_HOST}/x64/dumpbin.exe")



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
