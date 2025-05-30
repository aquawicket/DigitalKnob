#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### ankhtech_toolbox ######
# https://d9750.download-send.com/d/nryyw7au6cosj4l4onsfta7kzj7jhkkax5a2bclu466wflbbl4u3ovogbyivfspn3iwoq6gn/AT.Toolbox.zip

### INSTALL ###
dk_validate			(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/ankhtech_toolbox/dkconfig.txt")
dk_validate			(DKTOOLS_DIR "dk_DKTOOLS_DIR()")


dk_mkdir("${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Tweaks")
dk_mkdir("${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Temp")
dk_mkdir("${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Temp/Programs")
dk_mkdir("${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Temp/Frameworks")
dk_mkdir("${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Temp/Repacks")
dk_download("https://www.morkoskhalaf.com/ankhtech/Toolbox/AT.Toolbox.txt" 					"${DKTOOLS_DIR}/Ankhtech_Toolbox/AT.Toolbox.bat")
dk_download("https://www.morkoskhalaf.com/ankhtech/Toolbox/ATToolbox/Files/wget.exe" 		"${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Files/wget.exe")
dk_download("https://www.morkoskhalaf.com/ankhtech/Toolbox/ATToolbox/Files/7z.exe" 			"${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Files/7z.exe")
dk_download("https://www.morkoskhalaf.com/ankhtech/Toolbox/ATToolbox/Files/7z.dll" 			"${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Files/7z.dll")


dk_fileReplace("${DKTOOLS_DIR}/Ankhtech_Toolbox/AT.Toolbox.bat" "otoupd=2" "otoupd=1")


#dk_download("https://www.morkoskhalaf.com/ankhtech/Toolbox/Tweaks.exe"						"${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Tweaks.7z")
#cd "${DKTOOLS_DIR}/Ankhtech_Toolbox"
#execute_process(COMMAND "${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Files/7z.exe" x -y "${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox/Tweaks.7z" -o"${DKTOOLS_DIR}/Ankhtech_Toolbox/ATToolbox")


