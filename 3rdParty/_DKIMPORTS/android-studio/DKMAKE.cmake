# https://developer.android.com/studio/archive

DKDEPEND(jdk)
DKDEPEND(android-sdk)
DKDEPEND(android-ndk)


### VERSION ###
DKSET(ANDROIDSTUDIO_VERSION 202.7486908-windows)
DKSET(ANDROIDSTUDIO_NAME android-studio-ide-${ANDROIDSTUDIO_VERSION})
DKSET(ANDROIDSTUDIO_DL https://r5---sn-a5meknsy.gvt1.com/edgedl/android/studio/install/4.2.2.0/android-studio-ide-202.7486908-windows.exe?cms_redirect=yes&mh=2R&mip=47.148.227.149&mm=28&mn=sn-a5meknsy&ms=nvh&mt=1627334431&mv=m&mvi=5&pl=16&rmhost=r2---sn-a5meknsy.gvt1.com&shardbypass=yes&smhost=r6---sn-a5mekner.gvt1.com)

DKSETENV("STUDIO_JDK" ${JDK})
DKSETENV("STUDIO_GRADLE_JDK" ${JDK})


### INSTALL ###
IF(CMAKE_HOST_WIN32)
#IF(NOT EXISTS "C:/Program Files/Android/Android Studio/bin/studio.exe")
	##DKSETPATH(${DIGITALKNOB}/Download)
	DKINSTALL(${ANDROIDSTUDIO_DL} android-sdk C:/Program Files/Android/Android Studio/bin/studio.exe)
	## DKDOWNLOAD(www.internet.com/android-studio-ide-${ANDROIDSDK_VERSION}-windows.exe)
	## DKSETPATH(C:/)
	## DKSET(QUEUE_BUILD ON)
	## ANDROID_COMMAND(${DIGITALKNOB}/Download/android-studio-ide-${ANDROIDSDK_VERSION}-windows.exe)
#ENDIF()
ENDIF()

IF(CMAKE_HOST_APPLE)
IF(NOT EXISTS "/Applications/Android Studio.app")
	DKSETPATH(${DIGITALKNOB}/Download)
	## DKDOWNLOAD(www.internet.com/android-studio-ide-${ANDROIDSDK_VERSION}-mac.dmg)
	## DKSET(QUEUE_BUILD ON)
	## ANDROID_COMMAND(${DIGITALKNOB}/Download/android-studio-ide-${ANDROIDSDK_VERSION}-mac.dmg)
ENDIF()
ENDIF()

IF(CMAKE_HOST_LINUX)
IF(NOT EXISTS "${DIGITALKNOB}/3rdParty/android-studio/bin/studio.sh")
	DKSETPATH(${DIGITALKNOB}/Download)
	## DKDOWNLOAD(www.internet.com/android-studio-ide-${ANDROIDSDK_VERSION}-linux.zip)
	## DKSET(QUEUE_BUILD ON)
	## ANDROID_COMMAND(${DIGITALKNOB}/Download/android-studio-ide-${ANDROIDSDK_VERSION}-linux.zip)
ENDIF()
ENDIF()