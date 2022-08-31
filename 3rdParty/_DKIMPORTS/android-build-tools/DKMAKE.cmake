# Installed Build Tools revision NN.N.N is corrupted" https://stackoverflow.com/a/68430992/688352

# Information
# https://developer.android.com/studio/releases/build-tools
# https://androidsdkoffline.blogspot.com/p/android-sdk-build-tools.html
# https://mirrors.cloud.tencent.com/AndroidSDK/
#
# Source
# https://dl.google.com/android/repository/91936d4ee3ccc839f0addd53c9ebf087b1e39251.build-tools_r30.0.3-windows.zip
# https://dl.google.com/android/repository/build-tools_r30.0.3-darwin.zip
# https://mirrors.cloud.tencent.com/AndroidSDK/build-tools_r30.0.1-macosx.zip
# https://dl.google.com/android/repository/cc6bd534c6c37604205171784ac5621.build-tools_r30.0.3-linux.zip

dk_depend(android-sdk)

dk_makeDirectory(${ANDROID-SDK}/build-tools)
WIN_HOST_dk_import(https://dl.google.com/android/repository/91936d4ee3ccc839f0addd53c9ebf087b1e39251.build-tools_r30.0.3-windows.zip PATH ${ANDROID-SDK}/build-tools/30.0.3)
#MAC_HOST_dk_import(https://dl.google.com/android/repository/build-tools_r30.0.3-darwin.zip PATH ${ANDROID-SDK}/build-tools/30.0.3)
MAC_HOST_dk_import(https://mirrors.cloud.tencent.com/AndroidSDK/build-tools_r30.0.1-macosx.zip PATH ${ANDROID-SDK}/build-tools/30.0.1)
LINUX_HOST_dk_import(https://dl.google.com/android/repository/cc6bd534c6c37604205171784ac5621.build-tools_r30.0.3-linux.zip PATH ${ANDROID-SDK}/build-tools/30.0.3)
