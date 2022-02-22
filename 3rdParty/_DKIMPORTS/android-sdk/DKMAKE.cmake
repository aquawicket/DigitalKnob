if(NOT WIN_HOST)
	return()
endif()

### VERSION ###
DKSET(ANDROIDSDK ${3RDPARTY}/android-sdk)

DKSETENV("ANDROID_HOME" ${ANDROIDSDK})
DKSETENV("VS_AndroidHome" ${ANDROIDSDK})

### DEPENDS ###
DKDEPEND(jdk)
DKDEPEND(jdk8)
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
	DKCOPY(${DKIMPORTS}/android-sdk/SignLicenses.cmd ${ANDROIDSDK}/SignLicenses.cmd false)
	DKCOMMAND(${ANDROIDSDK}/SignLicenses.cmd)
endif()
