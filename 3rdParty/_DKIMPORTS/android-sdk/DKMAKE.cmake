# android-sdk

dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)

if(WIN_HOST)
	dk_setEnv("ANDROID_HOME" ${ANDROID-SDK})
	dk_setEnv("VS_AndroidHome" ${ANDROID-SDK})
	#dk_copy(${DKIMPORTS}/android-sdk/SignLicenses.cmd ${ANDROID-SDK}/SignLicenses.cmd OVERWRITE)
	dk_patch(android-sdk ${ANDROID-SDK})

### Batch script ###
	#dk_command(${ANDROID-SDK}/SignLicenses.cmd)
# call EndProcess java.exe
	dk_executeProcess(tasklist /fi "imagename eq java.exe" |find ":" > nul)
# call EndProcess adb.exe
	dk_executeProcess(tasklist /fi "imagename eq adb.exe" |find ":" > nul)
# call "C:/Users/%USERNAME%/digitalknob/DK/3rdParty/_DKIMPORTS/openjdk-8u41/registerJDK.cmd"
	dk_executeProcess(call "C:/Users/%USERNAME%/digitalknob/DK/3rdParty/_DKIMPORTS/openjdk-8u41/registerJDK.cmd")
# set "SDKMANAGER=C:\Users\%USERNAME%\digitalknob\DK\3rdParty\android-sdk\cmdline-tools\latest\bin\sdkmanager.bat
# %SDKMANAGER% --licenses
	dk_executeProcess(${ANDROID-SDK}\cmdline-tools\latest\bin\sdkmanager.bat --licenses)
#::echo y | %SDKMANAGER% --licenses
# call "C:/Users/%USERNAME%/digitalknob/DK/3rdParty/_DKIMPORTS/openjdk/registerJDK.cmd"
	dk_executeProcess(call "C:/Users/%USERNAME%/digitalknob/DK/3rdParty/_DKIMPORTS/openjdk/registerJDK.cmd")
####################

endif()
