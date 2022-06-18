if(NOT WIN_HOST)
	return()
endif()

### VERSION ###
dk_set(ANDROIDSDK ${3RDPARTY}/android-sdk)

DKSETENV("ANDROID_HOME" ${ANDROIDSDK})
DKSETENV("VS_AndroidHome" ${ANDROIDSDK})

### DEPENDS ###
DKDEPEND(jdk)
DKDEPEND(jdk8)
DKDEPEND(jdk9)
DKDEPEND(ant)
DKDEPEND(android-cmdline-tools)
DKDEPEND(android-ndk)
DKDEPEND(android-platforms)
DKDEPEND(android-sources)
#DKDEPEND(android-system-images)
DKDEPEND(android-platform-tools)
DKDEPEND(android-build-tools)
DKDEPEND(android-sdk-tools)
DKDEPEND(android-cmake)

if(NOT EXISTS ${ANDROIDSDK}/SignLicenses.cmd)
	dk_copy(${DKIMPORTS}/android-sdk/SignLicenses.cmd ${ANDROIDSDK}/SignLicenses.cmd false)
	DKCOMMAND(${ANDROIDSDK}/SignLicenses.cmd)
endif()
