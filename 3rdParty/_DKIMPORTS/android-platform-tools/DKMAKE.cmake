# https://androidsdkoffline.blogspot.com/p/android-sdk-platform-tools.html
# https://mirrors.cloud.tencent.com/AndroidSDK/

if(NOT ANDROID)
	dk_undepend(android-platform-tools)
	dk_return()
endif()

dk_depend(android-sdk)

# 31.0.3
#WIN_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip PATH ${ANDROID-SDK}/platform-tools)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r31.0.3-darwin.zip PATH ${ANDROID-SDK}/platform-tools)
#LINUX_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip PATH ${ANDROID-SDK}/platform-tools)

# 33.0.2
#WIN_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r33.0.2-windows.zip PATH ${ANDROID-SDK}/platform-tools)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r33.0.2-darwin.zip PATH ${ANDROID-SDK}/platform-tools)
#LINUX_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r33.0.2-linux.zip PATH ${ANDROID-SDK}/platform-tools)

# 33.0.3
WIN_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r33.0.3-windows.zip PATH ${ANDROID-SDK}/platform-tools)
MAC_HOST_dk_import(https://mirrors.cloud.tencent.com/AndroidSDK/platform-tools_r33.0.3-darwin.zip PATH ${ANDROID-SDK}/platform-tools)
if(NOT ANDROID_HOST)
     LINUX_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r33.0.3-linux.zip PATH ${ANDROID-SDK}/platform-tools)
else()
    ANDROID_HOST_dk_import(https://github.com/lzhiyong/android-sdk-tools/releases/download/33.0.3/android-sdk-tools-static-aarch64.zip PATH ${ANDROID-SDK}/termux)
    # move termux/build-tools to android-sdk
    dk_copy(${ANDROID-SDK}/termux/build-tools ${ANDROID-SDK}/build-tools/30.0.3)
    # move termux/platform-tools to android-sdk
    dk_copy(${ANDROID-SDK}/termux/platform-tools ${ANDROID-SDK}/platform-tools)
    
    ## fix aapt in gradle cache
    if(EXISTS ~/.gradle)
        dk_info("Patching Gradle aapt2 .......")
        dk_executeProcess(cd ~/.gradle/caches/modules-2/files-2.1/com.android.tools.build/aapt2/7.0.3-7396180/942684a205d274f6b23f6d066cafcc12a17ce9ff)
        dk_executeProcess(unzip aapt2-7.0.3-7396180-linux.jar)
        dk_executeProcess(rm aapt2)
        dk_executeProcess(cp ${ANDROID-SDK}/build-tools/30.0.3/aapt2 .)
        dk_executeProcess(rm aapt2-7.0.3-7396180-linux.jar)
        dk_executeProcess(zip aapt2-7.0.3-7396180-linux.jar *)
        dk_executeProcess(rm -rf META-INF NOTICE aapt2)
    endif()
endif()
