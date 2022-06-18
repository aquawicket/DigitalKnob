# https://developer.android.com/studio/archive
# https://developer.android.com/studio#downloads
# 
if(NOT WIN_HOST)
	return()
endif()


#dk_depend(jdk)
dk_depend(android-sdk)
dk_depend(android-ndk)


#dk_import(https://redirector.gvt1.com/edgedl/android/studio/install/2020.3.1.26/android-studio-2020.3.1.26-windows.exe)

dk_set(ANDROIDSTUDIO_VERSION "2020.3.1.26-windows")
dk_set(ANDROIDSTUDIO_NAME "android-studio-2020.3.1.26-windows.exe")
WIN_HOST_dk_set(ANDROIDSTUDIO_DL "https://redirector.gvt1.com/edgedl/android/studio/install/2020.3.1.26/android-studio-2020.3.1.26-windows.exe")


WIN_HOST_dk_set(ANDROIDSTUDIO "C:/Program Files/Android/Android Studio/bin")
WIN_HOST_dk_set(ANDROIDSTUDIO_EXE "${ANDROIDSTUDIO}/studio.exe")

MAC_HOST_dk_set(ANDROIDSTUDIO "/Applications")
MAC_HOST_dk_set(ANDROIDSTUDIO_EXE "${ANDROIDSTUDIO}/Android Studio.app")

LINUX_HOST_dk_set(ANDROIDSTUDIO "${3RDPARTY}/android-studio/bin")
LINUX_HOST_dk_set(ANDROIDSTUDIO_EXE "${ANDROIDSTUDIO}/Android Studio.app")

dk_setEnv("STUDIO_JDK" ${JDK8})
dk_setEnv("STUDIO_GRADLE_JDK" ${JDK8})


### INSTALL ###
#dk_install(${ANDROIDSTUDIO_DL} android-studio ${ANDROIDSTUDIO_EXE})

if(NOT EXISTS ${ANDROIDSTUDIO_EXE})
	dk_download(${ANDROIDSTUDIO_DL} ${DKDOWNLOAD}/${ANDROIDSTUDIO_NAME})
	dk_command(${DKDOWNLOAD}/${ANDROIDSTUDIO_NAME})
endif()
