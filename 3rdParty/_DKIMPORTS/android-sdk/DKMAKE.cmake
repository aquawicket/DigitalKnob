# Information
# https://androidsdkmanager.azurewebsites.net/
# https://developer.android.com/studio/releases/cmdline-tools
# https://developer.android.com/studio?hl=fr#command-tools
# https://androidsdkoffline.blogspot.com/p/android-sdk-cmdline-tools-offline.html

# Downloads
# https://dl.google.com/android/repository/commandlinetools-win-7302050_latest.zip
# https://dl.google.com/android/repository/commandlinetools-mac-7302050_latest.zip
# https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip

### VERSION ###
DKSET(ANDROIDSDK ${3RDPARTY}/android-sdk)

DKSETENV("ANDROID_HOME" ${ANDROIDSDK})
DKSETENV("VS_AndroidHome" ${ANDROIDSDK})

### DEPENDS ###
DKDEPEND(jdk)
DKDEPEND(apache-ant)
DKDEPEND(android-ndk)
DKDEPEND(android-cmdline-tools)
DKDEPEND(android-platforms)
DKDEPEND(android-sources)
#DKDEPEND(android-system-images)
DKDEPEND(android-platform-tools)
DKDEPEND(android-build-tools)
