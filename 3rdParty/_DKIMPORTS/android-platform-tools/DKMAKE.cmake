# https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip
# https://dl.google.com/android/repository/platform-tools_r31.0.3-darwin.zip
# https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip
# https://mirrors.cloud.tencent.com/AndroidSDK/

dk_depend(android-sdk)

WIN_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip PATH ${ANDROID-SDK}/platform-tools)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r31.0.3-darwin.zip PATH ${ANDROID-SDK}/platform-tools)
MAC_HOST_dk_import(https://mirrors.cloud.tencent.com/AndroidSDK/platform-tools_r33.0.3-darwin.zip PATH ${ANDROID-SDK}/platform-tools)
LINUX_HOST_dk_import(https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip PATH ${ANDROID-SDK}/platform-tools)
