# https://developer.android.com/studio/archive
#
# https://r5---sn-a5meknsy.gvt1.com/edgedl/android/studio/install/4.2.2.0/android-studio-ide-202.7486908-windows.exe?cms_redirect=yes&mh=2R&mip=47.148.227.149&mm=28&mn=sn-a5meknsy&ms=nvh&mt=1627334431&mv=m&mvi=5&pl=16&rmhost=r2---sn-a5meknsy.gvt1.com&shardbypass=yes&smhost=r6---sn-a5mekner.gvt1.com

DKDEPEND(jdk)
DKDEPEND(android-sdk)
DKDEPEND(android-ndk)


### VERSION ###
DKSET(ANDROIDSTUDIO_VERSION 202.7486908-windows)
DKSET(ANDROIDSTUDIO_NAME android-studio-ide-${ANDROIDSTUDIO_VERSION})
WIN_DKSET(ANDROIDSTUDIO_DL https://r5---sn-a5meknsy.gvt1.com/edgedl/android/studio/install/4.2.2.0/android-studio-ide-202.7486908-windows.exe?cms_redirect=yes&mh=2R&mip=47.148.227.149&mm=28&mn=sn-a5meknsy&ms=nvh&mt=1627334431&mv=m&mvi=5&pl=16&rmhost=r2---sn-a5meknsy.gvt1.com&shardbypass=yes&smhost=r6---sn-a5mekner.gvt1.com)
WIN_DKSET(ANDROIDSTUDIO "C:/Program Files/Android/Android Studio/bin")
WIN_DKSET(ANDROIDSTUDIO_EXE "${ANDROIDSTUDIO}/studio.exe")
MAC_DKSET(ANDROIDSTUDIO "/Applications")
MAC_DKSET(ANDROIDSTUDIO_EXE "${ANDROIDSTUDIO}/Android Studio.app")
LINUX_DKSET(ANDROIDSTUDIO "${DK}/3rdParty/android-studio/bin")
LINUX_DKSET(ANDROIDSTUDIO_EXE "${ANDROIDSTUDIO}/Android Studio.app")

DKSETENV("STUDIO_JDK" ${JDK})
DKSETENV("STUDIO_GRADLE_JDK" ${JDK})


### INSTALL ###
#DKINSTALL(${ANDROIDSTUDIO_DL} android-sdk ${ANDROIDSTUDIO_EXE})

if(NOT EXISTS ${ANDROIDSTUDIO_EXE})
	DKSETPATH(${DK}/Download)
	DKDOWNLOAD(${ANDROIDSTUDIO_DL})
	DKSET(QUEUE_BUILD ON)
	if(CMAKE_HOST_WIN32)
		ANDROID_COMMAND(${DK}/Download/android-studio-ide-${ANDROIDSDK_VERSION}-windows.exe)
	endif()
	if(CMAKE_HOST_APPLE)
		ANDROID_COMMAND(${DK}/Download/android-studio-ide-${ANDROIDSDK_VERSION}-mac.dmg)
	endif()
	if(CMAKE_HOST_LINUX)
		ANDROID_COMMAND(${DK}/Download/android-studio-ide-${ANDROIDSDK_VERSION}-linux.zip)
	endif()
endif()
