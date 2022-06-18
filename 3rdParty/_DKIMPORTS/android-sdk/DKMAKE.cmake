if(NOT WIN_HOST)
	return()
endif()

### VERSION ###
dk_set(ANDROIDSDK ${3RDPARTY}/android-sdk)

DKSETENV("ANDROID_HOME" ${ANDROIDSDK})
DKSETENV("VS_AndroidHome" ${ANDROIDSDK})

### DEPENDS ###
dk_depend(jdk)
dk_depend(jdk8)
dk_depend(jdk9)
dk_depend(ant)
dk_depend(android-cmdline-tools)
dk_depend(android-ndk)
dk_depend(android-platforms)
dk_depend(android-sources)
#dk_depend(android-system-images)
dk_depend(android-platform-tools)
dk_depend(android-build-tools)
dk_depend(android-sdk-tools)
dk_depend(android-cmake)

if(NOT EXISTS ${ANDROIDSDK}/SignLicenses.cmd)
	dk_copy(${DKIMPORTS}/android-sdk/SignLicenses.cmd ${ANDROIDSDK}/SignLicenses.cmd false)
	dk_command(${ANDROIDSDK}/SignLicenses.cmd)
endif()
