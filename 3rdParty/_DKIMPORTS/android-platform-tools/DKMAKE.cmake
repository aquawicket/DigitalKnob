# https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip
# https://dl.google.com/android/repository/platform-tools_r31.0.3-darwin.zip
# https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip


dk_set(ANDROIDPLATFORMTOOLS_VERSION 31.0.3)
WIN_HOST_dk_set(ANDROIDPLATFORMTOOLS_DL https://dl.google.com/android/repository/platform-tools_r${ANDROIDPLATFORMTOOLS_VERSION}-windows.zip)
MAC_HOST_dk_set(ANDROIDPLATFORMTOOLS_DL https://dl.google.com/android/repository/platform-tools_r${ANDROIDPLATFORMTOOLS_VERSION}-darwin.zip)
LINUX_HOST_dk_set(ANDROIDPLATFORMTOOLS_DL https://dl.google.com/android/repository/platform-tools_r${ANDROIDPLATFORMTOOLS_VERSION}-linux.zip)
dk_set(ANDROIDPLATFORMTOOLS ${ANDROIDSDK}/platform-tools)
dk_makeDirectory(${ANDROIDSDK}/platform-tools)
dk_install(${ANDROIDPLATFORMTOOLS_DL} android-platform-tools ${ANDROIDPLATFORMTOOLS})
#WIN_HOST_dk_import(ANDROIDPLATFORMTOOLS_DL https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip)
#MAC_HOST_dk_import(ANDROIDPLATFORMTOOLS_DL https://dl.google.com/android/repository/platform-tools_r31.0.3-darwin.zip)
#LINUX_HOST_dk_import(ANDROIDPLATFORMTOOLS_DL https://dl.google.com/android/repository/platform-tools_r31.0.3-linux.zip)
