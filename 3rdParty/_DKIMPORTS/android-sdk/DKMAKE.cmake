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
