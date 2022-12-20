# https://androidsdkoffline.blogspot.com/p/android-sdk-platform-tools.html
# https://mirrors.cloud.tencent.com/AndroidSDK/

if(NOT ANDROID)
	dk_undepend(android-platform-tools)
	return()
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
LINUX_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r33.0.3-linux.zip PATH ${ANDROID-SDK}/platform-tools)
