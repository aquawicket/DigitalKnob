# https://developer.android.com/tools/releases/build-tools
# https://androidsdkoffline.blogspot.com/p/android-sdk-build-tools.html
# https://mirrors.cloud.tencent.com/AndroidSDK/
# Installed Build Tools revision NN.N.N is corrupted" https://stackoverflow.com/a/68430992/688352

if(NOT ANDROID)
	dk_undepend(android-build-tools)
	dk_return()
endif()

dk_depend(android-sdk)

dk_makeDirectory(${ANDROID_SDK}/build-tools)

# 30.0.3
WIN_HOST_dk_import(https://dl.google.com/android/repository/91936d4ee3ccc839f0addd53c9ebf087b1e39251.build-tools_r30.0.3-windows.zip PATH ${ANDROID_SDK}/build-tools/30.0.3)
MAC_HOST_dk_import(https://dl.google.com/android/repository/f6d24b187cc6bd534c6c37604205171784ac5621.build-tools_r30.0.3-macosx.zip PATH ${ANDROID_SDK}/build-tools/30.0.3)
#if(NOT ANDROID_HOST)
    LINUX_HOST_dk_import(https://dl.google.com/android/repository/build-tools_r30.0.3-linux.zip PATH ${ANDROID_SDK}/build-tools/30.0.3)
#endif()

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
