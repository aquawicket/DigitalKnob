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


############ windows_adk ############
# https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install
# https://go.microsoft.com/fwlink/?linkid=2289980
# https://go.microsoft.com/fwlink/?linkid=2289981


###### Download the Windows ADK 10.1.26100.2454 (December 2024) ######
# https://download.microsoft.com/download/2/d/9/2d9c8902-3fcd-48a6-a22a-432b08bed61e/ADK/adksetup.exe
#if(NOT EXISTS "$ENV{SystemDrive}/Program Files (x86)/Windows Kits/10/Assessment and Deployment Kit")
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
dk_set(windows_adk_Install_Path "$ENV{DKTOOLS_DIR}/ADK")
#if(NOT EXISTS "${windows_adk_Install_Path}")
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	#if(NOT EXISTS "$ENV{DKDOWNLOAD_DIR}/ADK")
		dk_download("https://go.microsoft.com/fwlink/?linkid=2289980")
		execute_process(COMMAND cmd /c "${dk_download}" /layout "$ENV{DKDOWNLOAD_DIR}/ADK") # /q
	#endif()

	dk_echo("Installing Windows ADK . . .  please wait")
	execute_process(COMMAND cmd /c "${dk_download}" /installpath "${windows_adk_Install_Path}") # /q
#endif()


###### Download the Windows PE add-on for the Windows ADK 10.1.26100.2454 (December 2024) ######
# https://download.microsoft.com/download/5/5/6/556e01ec-9d78-417d-b1e1-d83a2eff20bc/ADKWinPEAddons/adkwinpesetup.exe
#if(NOT EXISTS "$ENV{SystemDrive}/Program Files (x86)/Windows Kits/10/Assessment and Deployment Kit/Windows Preinstallation Environment")
dk_validate(ENV{DKTOOLS_DIR} "dk_DKTOOLS_DIR()")
#if(NOT EXISTS "${windows_adk_Install_Path}")
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	#if(NOT EXISTS "$ENV{DKDOWNLOAD_DIR}/ADKWinPEAddons")
		dk_download("https://go.microsoft.com/fwlink/?linkid=2289981")
		execute_process(COMMAND cmd /c "${dk_download}" /layout "$ENV{DKDOWNLOAD_DIR}/ADKWinPEAddons") # /q)
	#endif()
	
	dk_echo("Installing Windows PE add-on for the Windows ADK . . .  please wait")
	execute_process(COMMAND cmd /c "${dk_download}" /installpath "${windows_adk_Install_Path}") # /q)
#endif()

set(DandISetEnv_bat "$ENV{DKTOOLS_DIR}/ADK/Assessment and Deployment Kit/Deployment Tools/DandISetEnv.bat")
dk_nativePath(${DandISetEnv_bat} DandISetEnv_bat)
set(WinPE "$ENV{DKTOOLS_DIR}/ADK/WinPE")

if(NOT EXISTS "${WinPE}")
	set(copype_cmd "$ENV{DKTOOLS_DIR}/ADK/Assessment and Deployment Kit/Windows Preinstallation Environment/copype.cmd")
	dk_nativePath(${copype_cmd} copype_cmd)
	dk_nativePath(${WinPE} WinPE)
	execute_process(COMMAND cmd /c call "${DandISetEnv_bat}" && "${copype_cmd}" amd64 "${WinPE}")
endif()

set(DKWinPE_iso "$ENV{DKTOOLS_DIR}/DKWinPE.iso")
if(NOT EXISTS "${DKWinPE_iso}")
	set(MakeWinPEMedia_cmd "$ENV{DKTOOLS_DIR}/ADK/Assessment and Deployment Kit/Windows Preinstallation Environment/MakeWinPEMedia.cmd")
	dk_nativePath(${MakeWinPEMedia_cmd} MakeWinPEMedia_cmd)
	dk_nativePath(${DKWinPE_iso} DKWinPE_iso)
	set(WPE "$ENV{DKTOOLS_DIR}/ADK/Assessment and Deployment Kit/Windows Preinstallation Environment")
	execute_process(COMMAND cmd /c call "${DandISetEnv_bat}" && "${MakeWinPEMedia_cmd}" /ISO "${WinPE}" "${DKWinPE_iso}" WORKING_DIRECTORY "${WPE}")
endif()




