# https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip
# https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg
# https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip

### VERSION ###
DKSET(ANDROIDNDK_VERSION r21e)
DKSET(ANDROIDNDK_NAME android-ndk-r21e)
DKSET(ANDROIDNDK_BUILD 21.4.7075529)
WIN_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r21e-windows-x86_64.zip)
WIN_DKSET(ANDROIDNDK_SHA1 fc44fea8bb3f5a6789821f40f41dce2d2cd5dc30)
MAC_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r21e-darwin-x86_64.dmg)
LINUX_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip)

#DKSET(ANDROIDNDK_VERSION r22b)
#DKSET(ANDROIDNDK_NAME android-ndk-r22b)
#DKSET(ANDROIDNDK_BUILD 22.1.7171670)
#WIN_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-windows-x86_64.zip)
#WIN_DKSET(ANDROIDNDK_SHA1 96ba1a049303cf6bf3ee84cfd64d6bcd43486a50)
#MAC_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-darwin-x86_64.zip)
#LINUX_DKSET(ANDROIDNDK_DL https://dl.google.com/android/repository/android-ndk-r22b-linux-x86_64.zip)

DKSET(ANDROIDNDK ${3RDPARTY}/${ANDROIDNDK_NAME})
DKSETENV("NDK_ROOT" ${ANDROIDNDK})
DKSETENV("VS_NdkRoot" ${ANDROIDNDK})

### INSTALL ###
DKINSTALL(${ANDROIDNDK_DL} android-ndk ${ANDROIDNDK})
