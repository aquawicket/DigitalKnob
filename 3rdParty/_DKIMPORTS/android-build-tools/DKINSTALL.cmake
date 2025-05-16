#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### android-build-tools ######
# https://developer.android.com/tools/releases/build-tools
# https://androidsdkoffline.blogspot.com/p/android-sdk-build-tools.html
# https://mirrors.cloud.tencent.com/AndroidSDK/
# Installed Build Tools revision NN.N.N is corrupted" https://stackoverflow.com/a/68430992/688352

dk_depend(android-sdk)
dk_mkdir(${ANDROID_SDK}/build-tools)

# 30.0.3
dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/android-build-tools/dkconfig.txt")

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(Win_Host)
	dk_import(${ANDROID_BUILD_TOOLS_WIN_IMPORT} PATH ${ANDROID_SDK}/build-tools/${ANDROID_BUILD_TOOLS_VERSION})
elseif(Mac_Host)
	dk_import(${ANDROID_BUILD_TOOLS_MAC_IMPORT} PATH ${ANDROID_SDK}/build-tools/${ANDROID_BUILD_TOOLS_VERSION})
elseif(Linux_Host OR ANDROID_HOST)
    dk_import(${ANDROID_BUILD_TOOLS_LINUX_IMPORT} PATH ${ANDROID_SDK}/build-tools/${ANDROID_BUILD_TOOLS_VERSION})
endif()

# 31.0.0
#WIN_HOST_dk_import(https://dl.google.com/android/repository/09489e417c0a266f2862ddd82b4ac29a1b7af55e.build-tools_r31-windows.zip PATH ${ANDROID_SDK}/build-tools/31.0.0)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/d32e21a8aa8492ef8b86a489f601da425842b5da.build-tools_r31-macosx.zip PATH ${ANDROID_SDK}/build-tools/31.0.0)
#LINUX_HOST_dk_import(https://dl.google.com/android/repository/build-tools_r31-linux.zip PATH ${ANDROID_SDK}/build-tools/31.0.0)

# 32.0.0
#WIN_HOST_dk_import(https://dl.google.com/android/repository/210b77e4bc623bd4cdda4dae790048f227972bd2.build-tools_r32-windows.zip PATH ${ANDROID_SDK}/build-tools/32.0.0)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/5219cc671e844de73762e969ace287c29d2e14cd.build-tools_r32-macosx.zip PATH ${ANDROID_SDK}/build-tools/32.0.0)
#LINUX_HOST_dk_import(https://dl.google.com/android/repository/build-tools_r32-linux.zip PATH ${ANDROID_SDK}/build-tools/32.0.0)

# 32.1.0
#WIN_HOST_dk_import(https://dl.google.com/android/repository/21014bc1a76d38d0dcb79b3b3f49f40ea5a53c10.build-tools_r32.1-rc1-windows.zip PATH ${ANDROID_SDK}/build-tools/32.1.0)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/c165e9b235479731f416c7aea22d065819c7ce23.build-tools_r32.1-rc1-macosx.zip PATH ${ANDROID_SDK}/build-tools/32.1.0)
#LINUX_HOST_dk_import(https://dl.google.com/android/repository/build-tools_r32.1-rc1-linux.zip PATH ${ANDROID_SDK}/build-tools/32.1.0)

# 33.0.0
#WIN_HOST_dk_import(https://dl.google.com/android/repository/build-tools_r33-windows.zip PATH ${ANDROID_SDK}/build-tools/33.0.0)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/build-tools_r33-macosx.zip PATH ${ANDROID_SDK}/build-tools/33.0.0)
#LINUX_HOST_dk_import(https://dl.google.com/android/repository/build-tools_r33-linux.zip PATH ${ANDROID_SDK}/build-tools/33.0.0)
