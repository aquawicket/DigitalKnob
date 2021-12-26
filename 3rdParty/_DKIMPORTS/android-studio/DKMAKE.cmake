if(NOT WIN_HOST)
	return()
endif()

# https://developer.android.com/studio/archive
#
# https://r5---sn-a5meknsy.gvt1.com/edgedl/android/studio/install/4.2.2.0/android-studio-ide-202.7486908-windows.exe?cms_redirect=yes&mh=2R&mip=47.148.227.149&mm=28&mn=sn-a5meknsy&ms=nvh&mt=1627334431&mv=m&mvi=5&pl=16&rmhost=r2---sn-a5meknsy.gvt1.com&shardbypass=yes&smhost=r6---sn-a5mekner.gvt1.com

DKDEPEND(jdk)
DKDEPEND(android-sdk)
DKDEPEND(android-ndk)


### VERSION ###
DKSET(ANDROIDSTUDIO_VERSION 202.7486908-windows)
DKSET(ANDROIDSTUDIO_NAME android-studio-ide-${ANDROIDSTUDIO_VERSION})
WIN_HOST_DKSET(ANDROIDSTUDIO_DL "https://r5---sn-a5meknsy.gvt1.com/edgedl/android/studio/install/4.2.2.0/android-studio-ide-202.7486908-windows.exe?cms_redirect=yes&mh=2R&mip=47.148.227.149&mm=28&mn=sn-a5meknsy&ms=nvh&mt=1627334431&mv=m&mvi=5&pl=16&rmhost=r2---sn-a5meknsy.gvt1.com&shardbypass=yes&smhost=r6---sn-a5mekner.gvt1.com")
WIN_HOST_DKSET(ANDROIDSTUDIO "C:/Program Files/Android/Android Studio/bin")
WIN_HOST_DKSET(ANDROIDSTUDIO_NAME "studio.exe")
WIN_HOST_DKSET(ANDROIDSTUDIO_EXE "${ANDROIDSTUDIO}/${ANDROIDSTUDIO_NAME}")
MAC_HOST_DKSET(ANDROIDSTUDIO "/Applications")
MAC_HOST_DKSET(ANDROIDSTUDIO_EXE "${ANDROIDSTUDIO}/Android Studio.app")
LINUX_HOST_DKSET(ANDROIDSTUDIO "${3RDPARTY}/android-studio/bin")
LINUX_HOST_DKSET(ANDROIDSTUDIO_EXE "${ANDROIDSTUDIO}/Android Studio.app")

DKSETENV("STUDIO_JDK" ${JDK})
DKSETENV("STUDIO_GRADLE_JDK" ${JDK})


### INSTALL ###
#DKINSTALL(${ANDROIDSTUDIO_DL} android-studio ${ANDROIDSTUDIO_EXE})

if(NOT EXISTS ${ANDROIDSTUDIO_EXE})
	DOWNLOAD(${ANDROIDSTUDIO_DL} ${DKDOWNLOAD}/${ANDROIDSTUDIO_NAME})
	DKCOMMAND(${DKDOWNLOAD}/${ANDROIDSTUDIO_NAME})
endif()
