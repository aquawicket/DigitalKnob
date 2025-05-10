#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### visualstudio ######
dk_validate(Host_Triple "dk_Host_Triple()")
#if(NOT WIN_HOST)
#	dk_undepend(visualstudio)
#	dk_return()
#endif()
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")


#if(EXISTS "$ENV{SystemDrive}/Program Files (x86)/Microsoft Visual Studio/Installer/setup.exe")
	dk_firewallAllow("VS_SETUP" "$ENV{SystemDrive}/Program Files (x86)/Microsoft Visual Studio/Installer/setup.exe")
#endif()

#############################################################################################################
# C:/Program Files (x86)/Microsoft Visual Studio    /2022      /BuildTools    /VC/Tools/MSVC   /14.42.34433
# 				${VS_INSTALL_PATH}               ${VS_YEAR}     ${VS_TYPE}					   ${VS_VERSION}
#
# https://learn.microsoft.com/en-us/visualstudio/releases/2022/release-history

#dk_set(VS_INSTALL_PATH		"$ENV{DKTOOLS_DIR}/VS")
#dk_set(VS_CACHE_PATH		"$ENV{DKDOWNLOAD_DIR}/VS")
dk_set(VS_YEAR 				2022)												# 2019, 2022
#dk_set(VS_TYPE				"BuildTools") 										# BuildTools, Community			
dk_set(VS_MAJOR 			17)													# 17
#dk_set(VS_DL 				"https://aka.ms/vs/17/release/vs_BuildTools.exe")




###### VS_INSTALL_PATH ######
if(NOT VS_INSTALL_PATH)
	set(VS_INSTALL_PATH		"$ENV{SystemDrive}/Program Files (x86)/Microsoft Visual Studio")
else()
	set(VS_INSTALL_FLAG		--path install=${VS_INSTALL_PATH})
endif()

###### VS_CACHE_PATH ######
if(NOT VS_CACHE_PATH)
	#dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	#set(VS_CACHE_PATH	"$ENV{DKDOWNLOAD_DIR}/VS")
	set(VS_CACHE_PATH	"$ENV{SystemDrive}/Program Files \(x86\)/Microsoft Visual Studio/DL")
endif()
set(VS_CACHE_FLAG			--path cache=${VS_CACHE_PATH})		

###### VS_TYPE ######
if(NOT VS_TYPE)
	dk_set(VS_TYPE "BuildTools")
endif()

###### VS_DL ######
if(NOT VS_DL)
	dk_set(VS_DL 	"https://aka.ms/vs/${VS_MAJOR}/release/vs_${VS_TYPE}.exe")
endif()

### 2022
macro(VS_YEAR)
	file(GLOB children RELATIVE "${VS_INSTALL_PATH}" "${VS_INSTALL_PATH}/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${VS_INSTALL_PATH}/${child}")
			if(EXISTS "${VS_INSTALL_PATH}/${child}/${VS_TYPE}")
				set(VS_YEAR ${child})
				dk_printVar(${VS_YEAR})
			endif()
		endif()
	endforeach()
	if(NOT ${VS_YEAR})
		dk_warning("VS_YEAR(): Could not locate year.")
		dk_set(VS_YEAR "2022") # DEFAULT
	endif()
	dk_printVar(${VS_YEAR})
endmacro()
if(NOT VS_YEAR)
	VS_YEAR()
endif()


macro(VS_VERSION)
	file(GLOB children RELATIVE "${VS_INSTALL_PATH}/VC/Tools/MSVC" "${VS_INSTALL_PATH}/VC/Tools/MSVC/*")
	foreach(child ${children})
		if(IS_DIRECTORY "${VS_INSTALL_PATH}/VC/Tools/MSVC/${child}")
			if(EXISTS "${VS_INSTALL_PATH}/VC/Tools/MSVC/${child}/bin/Hostx86")
				set(VS_VERSION ${child})
				dk_printVar(${VS_VERSION})
			endif()
		endif()
	endforeach()
	if(NOT ${VS_VERSION})
		dk_warning("VS_VERSION(): Could not locate version.")
		#dk_set(VS_VERSION "14.42.34433") # DEFAULT
	endif()
	dk_printVar(${VS_VERSION})
endmacro()
if(NOT VS_VERSION)
	VS_VERSION()
endif()

###### VS ######
dk_set(VS	"${VS_INSTALL_PATH}/${VS_YEAR}/${VS_TYPE}")




###### INSTALL Visual Studio ######
if(NOT EXISTS "${VS}")
	dk_info("Installing Visual Studio ${VS_TYPE} ${VS_YEAR} ${VS_VERSION}. . .")
	dk_basename(${VS_DL} VS_DL_FILE)
	dk_download(${VS_DL} $ENV{DKDOWNLOAD_DIR}/${VS_DL_FILE})
	#dk_download(${VS_DL})
	
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
	
	
	#execute_process(COMMAND cmd /c start /wait $ENV{DKDOWNLOAD_DIR}/${VS_DL_FILE} ${VS_INSTALL_FLAG} ${VS_CACHE_FLAG} --cache --downloadThenInstall)
	execute_process(COMMAND $ENV{DKDOWNLOAD_DIR}/${VS_DL_FILE} ${VS_INSTALL_FLAG} ${VS_CACHE_FLAG} --cache --downloadThenInstall TIMEOUT 1)

	### wait for vs_setup_bootstrapper.exe to exist in C:/windows/temp ###
	while(NOT VS_SETUP_BOOTSTRAPPER_EXE)
		dk_findProgram(VS_SETUP_BOOTSTRAPPER_EXE vs_setup_bootstrapper.exe "$ENV{SystemDrive}/Windows/Temp")
	endwhile()
	dk_printVar(VS_SETUP_BOOTSTRAPPER_EXE)
	dk_firewallAllow("VS_SETUP_BOOTSTRAPPER" "${VS_SETUP_BOOTSTRAPPER_EXE}")
	
	while(NOT EXISTS "${VS_SETUP_EXE}")
		dk_findProgram(VS_SETUP_EXE setup.exe "$ENV{SystemDrive}/Program Files (x86)/Microsoft Visual Studio/Installer")
	endwhile()
	dk_printVar(VS_SETUP_EXE)
	dk_firewallAllow("VS_SETUP_EXE" "${VS_SETUP_EXE}")

	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	while(NOT EXISTS "${VS_CACHE_PATH}")
		dk_sleep(1)
	endwhile()
	dk_copy("${VS_CACHE_PATH}" "$ENV{DKDOWNLOAD_DIR}/VS")
else()
	dk_info("Visual Studio ${VS_TYPE} ${VS_MAJOR} ${VS_YEAR} already installed")
endif()

###### set VS variables ######

dk_validate(VS_YEAR 				"VS_YEAR()")
dk_validate(VS_VERSION 				"VS_VERSION()")
dk_set(VS_GENERATOR 				"Visual Studio ${VS_MAJOR} ${VS_YEAR}")
dk_set(VS_MAKE_PROGRAM				"${VS}/MSBuild/Current/Bin/amd64/MSBuild.exe")
dk_set(VS_MAKE_VCVARSALL			"${VS}/VC/Auxiliary/Build/vcvarsall.bat")

dk_set(VS_ARM64_GENERATOR_PLATFORM	ARM64)

dk_set(VS_X86_GENERATOR_PLATFORM	Win32)
dk_set(VS_X86_NMAKE 				"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx64/x86/nmake.exe")
dk_set(VS_X86_COMPILER 				"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx64/x86/cl.exe")
dk_set(VS_X86_LINKER 				"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx64/x86/link.exe")
dk_set(VS_X86_DUMPBIN 				"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx86/x86/dumpbin.exe")

dk_set(VS_X86_64_GENERATOR_PLATFORM	x64)
dk_set(VS_X86_64_NMAKE 				"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx64/x64/nmake.exe")
dk_set(VS_X86_64_COMPILER 			"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx64/x64/cl.exe")
dk_set(VS_X86_64_LINKER 			"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx64/x64/link.exe")
dk_set(VS_X86_64_DUMPBIN 			"${VS}/VC/Tools/MSVC/${VS_VERSION}/bin/Hostx86/x64/dumpbin.exe")



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
