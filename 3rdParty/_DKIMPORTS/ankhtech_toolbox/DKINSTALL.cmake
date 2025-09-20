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


###### ankhtech_toolbox ######
# https://d9750.download-send.com/d/nryyw7au6cosj4l4onsfta7kzj7jhkkax5a2bclu466wflbbl4u3ovogbyivfspn3iwoq6gn/AT.Toolbox.zip

### INSTALL ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_validate			(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
set					(ANKHTECH_TOOLBOX "${DKTOOLS_DIR}/Ankhtech_Toolbox")

dk_mkdir("${ANKHTECH_TOOLBOX}/ATToolbox/Tweaks")
dk_mkdir("${ANKHTECH_TOOLBOX}/ATToolbox/Temp")
dk_mkdir("${ANKHTECH_TOOLBOX}/ATToolbox/Temp/Programs")
dk_mkdir("${ANKHTECH_TOOLBOX}/ATToolbox/Temp/Frameworks")
dk_mkdir("${ANKHTECH_TOOLBOX}/ATToolbox/Temp/Repacks")
dk_download(${ankhtech_toolbox_Import})
dk_copy(${dk_download} "${ANKHTECH_TOOLBOX}/AT.Toolbox.bat")
dk_download(${ankhtech_toolbox_Wget_exe})
dk_copy(${dk_download} "${ANKHTECH_TOOLBOX}/ATToolbox/Files/wget.exe")
dk_firewallAllow("${ANKHTECH_TOOLBOX}/ATToolbox/Files/wget.exe")
dk_download(${ankhtech_toolbox_7z_exe})	
dk_copy(${dk_download} "${ANKHTECH_TOOLBOX}/ATToolbox/Files/7z.exe")
dk_download(${ankhtech_toolbox_7z_dll})		
dk_copy(${dk_download} "${ANKHTECH_TOOLBOX}/ATToolbox/Files/7z.dll")

dk_fileReplace("${ANKHTECH_TOOLBOX}/AT.Toolbox.bat" "otoupd=2" "otoupd=1")



#dk_download("https://www.morkoskhalaf.com/ankhtech/Toolbox/Tweaks.exe"						"${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Tweaks.7z")
#cd "${DKTOOLS_DIR}/Ankhtech_Toolbox"
#execute_process(COMMAND "${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Files/7z.exe" x -y "${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Tweaks.7z" -o"${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox")


