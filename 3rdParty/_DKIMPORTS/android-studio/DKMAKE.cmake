# https://developer.android.com/studio/archive
# https://developer.android.com/studio#downloads


dk_depend(openjdk-8u41)
dk_depend(android-ndk)


#dk_set(ANDROID-STUDIO_VERSION "2020.3.1.26-windows")
dk_set(ANDROID-STUDIO_NAME "android-studio-2020.3.1.26-windows.exe")
WIN_HOST_dk_set(ANDROID-STUDIO_DL "https://redirector.gvt1.com/edgedl/android/studio/install/2020.3.1.26/android-studio-2020.3.1.26-windows.exe")
#WIN_dk_import(https://redirector.gvt1.com/edgedl/android/studio/install/2020.3.1.26/android-studio-2020.3.1.26-windows.exe)

WIN_HOST_dk_set(ANDROID-STUDIO "C:/Program Files/Android/Android Studio/bin")
WIN_HOST_dk_set(ANDROID-STUDIO_EXE "${ANDROID-STUDIO}/studio.exe")

MAC_HOST_dk_set(ANDROID-STUDIO "/Applications")
MAC_HOST_dk_set(ANDROID-STUDIO_EXE "${ANDROID-STUDIO}/Android Studio.app")

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
