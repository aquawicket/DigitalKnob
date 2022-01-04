# https://dl.google.com/android/repository/7c386a739f915fbd60051f2572c24782388e807.cmake-3.18.1-windows.zip



### VERSION ####
WIN_DKSET(ANDROIDJAVA_VERSION 2.8)
WIN_DKSET(ANDROIDJAVA_DL  https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage)



### INSTALL ###
file(MAKE_DIRECTORY ${3RDPARTY}/android-sdk/cmake)
WIN_DKINSTALL(${ANDROIDJAVA_DL} android_java_tools ${ANDROIDJAVA})
WIN_DKSET(ANDROIDJAVA_NAME androoidjavatools-${ANDROIDJAVA_VERSION})
WIN_DKSET(ANDROIDJAVA ${3RDPARTY}/${ANDROIDJAVA_NAME})