#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ windows_adk ############
# https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install
# https://go.microsoft.com/fwlink/?linkid=2289980
# https://go.microsoft.com/fwlink/?linkid=2289981


###### Download the Windows ADK 10.1.26100.2454 (December 2024) ######
#if(NOT EXISTS "$ENV{SystemDrive}/Program Files (x86)/Windows Kits/10/Assessment and Deployment Kit")
dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_set(windows_adk_Install_Path "${DKTOOLS_DIR}/ADK")
#if(NOT EXISTS "${windows_adk_Install_Path}")
	dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
	#if(NOT EXISTS "${DKDOWNLOAD_DIR}/ADK")
		dk_download("${windows_adk_Import}")
		execute_process(COMMAND cmd /c "${dk_download}" /layout "${DKDOWNLOAD_DIR}/ADK") # /q
	#endif()

	dk_echo("Installing Windows ADK . . .  please wait")
	execute_process(COMMAND cmd /c "${dk_download}" /installpath "${windows_adk_Install_Path}") # /q
#endif()


###### Download the Windows PE add-on for the Windows ADK 10.1.26100.2454 (December 2024) ######
#if(NOT EXISTS "$ENV{SystemDrive}/Program Files (x86)/Windows Kits/10/Assessment and Deployment Kit/Windows Preinstallation Environment")
dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
#if(NOT EXISTS "${windows_adk_Install_Path}")
	dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
	#if(NOT EXISTS "${DKDOWNLOAD_DIR}/ADKWinPEAddons")
		dk_download("${windows_adk_PE_Import}")
		execute_process(COMMAND cmd /c "${dk_download}" /layout "${DKDOWNLOAD_DIR}/ADKWinPEAddons") # /q)
	#endif()
	
	dk_echo("Installing Windows PE add-on for the Windows ADK . . .  please wait")
	execute_process(COMMAND cmd /c "${dk_download}" /installpath "${windows_adk_Install_Path}") # /q)
#endif()

set(DandISetEnv_bat "${DKTOOLS_DIR}/ADK/Assessment and Deployment Kit/Deployment Tools/DandISetEnv.bat")
dk_pathToNative(${DandISetEnv_bat} DandISetEnv_bat)
set(WinPE "${DKTOOLS_DIR}/ADK/WinPE")

if(NOT EXISTS "${WinPE}")
	set(copype_cmd "${DKTOOLS_DIR}/ADK/Assessment and Deployment Kit/Windows Preinstallation Environment/copype.cmd")
	dk_pathToNative(${copype_cmd} copype_cmd)
	dk_pathToNative(${WinPE} WinPE)
	execute_process(COMMAND cmd /c call "${DandISetEnv_bat}" && "${copype_cmd}" amd64 "${WinPE}")
endif()

set(DKWinPE_iso "${DKTOOLS_DIR}/DKWinPE.iso")
if(NOT EXISTS "${DKWinPE_iso}")
	set(MakeWinPEMedia_cmd "${DKTOOLS_DIR}/ADK/Assessment and Deployment Kit/Windows Preinstallation Environment/MakeWinPEMedia.cmd")
	dk_pathToNative(${MakeWinPEMedia_cmd} MakeWinPEMedia_cmd)
	dk_pathToNative(${DKWinPE_iso} DKWinPE_iso)
	set(WPE "${DKTOOLS_DIR}/ADK/Assessment and Deployment Kit/Windows Preinstallation Environment")
	execute_process(COMMAND cmd /c call "${DandISetEnv_bat}" && "${MakeWinPEMedia_cmd}" /ISO "${WinPE}" "${DKWinPE_iso}" WORKING_DIRECTORY "${WPE}")
endif()




