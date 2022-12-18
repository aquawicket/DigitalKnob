# https://developer.android.com/studio/archive
# https://developer.android.com/studio#downloads

if(NOT ANDROID)
	dk_undepend(android-studio)
	return()
endif()


### DEPEND ###
dk_depend(openjdk-8u41)
dk_depend(android-ndk)


### IMPORT ###
WIN_HOST_dk_set(ANDROID-STUDIO_NAME "android-studio-2020.3.1.26-windows.exe")
WIN_HOST_dk_set(ANDROID-STUDIO_DL "https://redirector.gvt1.com/edgedl/android/studio/install/2020.3.1.26/android-studio-2020.3.1.26-windows.exe")
WIN_HOST_dk_set(ANDROID-STUDIO "C:/Program Files/Android/Android Studio/bin")
WIN_HOST_dk_set(ANDROID-STUDIO_EXE "${ANDROID-STUDIO}/studio.exe")

MAC_HOST_dk_set(ANDROID-STUDIO_NAME "android-studio-2021.3.1.17-mac.dmg")
MAC_HOST_dk_set(ANDROID-STUDIO_DL "https://redirector.gvt1.com/edgedl/android/studio/install/2021.3.1.17/android-studio-2021.3.1.17-mac.dmg")
MAC_HOST_dk_set(ANDROID-STUDIO "/Applications")
MAC_HOST_dk_set(ANDROID-STUDIO_EXE "${ANDROID-STUDIO}/Android Studio.app")

LINUX_HOST_dk_set(ANDROID-STUDIO_NAME "android-studio-2021.3.1.17-linux.tar.gz")
LINUX_HOST_dk_set(ANDROID-STUDIO_DL "https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2021.3.1.17/android-studio-2021.3.1.17-linux.tar.gz")
LINUX_HOST_dk_set(ANDROID-STUDIO "${3RDPARTY}/android-studio/bin")
LINUX_HOST_dk_set(ANDROID-STUDIO_EXE "${ANDROID-STUDIO}/Android Studio.app")

dk_setEnv("STUDIO_JDK" ${OPENJDK-8U41})
dk_setEnv("STUDIO_GRADLE_JDK" ${OPENJDK-8U41})


### INSTALL ###
#dk_import(${ANDROID-STUDIO_DL} ${ANDROID-STUDIO_EXE})

if(NOT EXISTS ${ANDROID-STUDIO_EXE})
	dk_download(${ANDROID-STUDIO_DL} ${DKDOWNLOAD}/${ANDROID-STUDIO_NAME})
	dk_command(${DKDOWNLOAD}/${ANDROID-STUDIO_NAME})
endif()
