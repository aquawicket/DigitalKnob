include_guard()
# https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip
# https://dl.google.com/android/repository/platform-tools_r31.0.3-darwin.zip
# https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip


dk_set(ANDROID-PLATFORM-TOOLS_VERSION 31.0.3)
WIN_HOST_dk_set(ANDROID-PLATFORM-TOOLS_DL https://dl.google.com/android/repository/platform-tools_r${ANDROID-PLATFORM-TOOLS_VERSION}-windows.zip)
MAC_HOST_dk_set(ANDROID-PLATFORM-TOOLS_DL https://dl.google.com/android/repository/platform-tools_r${ANDROID-PLATFORM-TOOLS_VERSION}-darwin.zip)
LINUX_HOST_dk_set(ANDROID-PLATFORM-TOOLS_DL https://dl.google.com/android/repository/platform-tools_r${ANDROID-PLATFORM-TOOLS_VERSION}-linux.zip)
dk_set(ANDROID-PLATFORM-TOOLS ${ANDROIDSDK}/platform-tools)
dk_makeDirectory(${ANDROIDSDK}/platform-tools)
dk_install(${ANDROID-PLATFORM-TOOLS_DL} android-platform-tools ${ANDROID-PLATFORM-TOOLS})
#WIN_HOST_dk_import(ANDROID-PLATFORM-TOOLS_DL https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip)
#MAC_HOST_dk_import(ANDROID-PLATFORM-TOOLS_DL https://dl.google.com/android/repository/platform-tools_r31.0.3-darwin.zip)
#LINUX_HOST_dk_import(ANDROID-PLATFORM-TOOLS_DL https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip)
